#include <errno.h>
#include <fcntl.h>
#include <libevdev/libevdev.h>
#include <libevdev/libevdev-uinput.h>
#include <linux/input-event-codes.h>
#include <linux/input.h>
#include <poll.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define FILE_PATH_SIZE 32
#define UINPUT_PATH "/dev/uinput"

static volatile int keep_running = 1;
void handle_sig(int sig) { keep_running = 0; }

int main() {
  signal(SIGINT, handle_sig);    // Ctrl-C in terminal
  signal(SIGTERM, handle_sig);   // Issued by systemd

  struct libevdev *ev_devs[32];
  int ev_fds[32];
  int head = 0;

  for (int i = 0; i < 32; i++) {
    char file_path[FILE_PATH_SIZE];
    struct libevdev *dev;

    snprintf(file_path, FILE_PATH_SIZE, "/dev/input/event%d", i);
    int fd = open(file_path, O_RDONLY | O_NONBLOCK);

    if (fd < 0) continue;

    if (libevdev_new_from_fd(fd, &dev)) {
      fprintf(stderr, "Failed to create evdev for %s", file_path);
      goto close_fd;
    }
    
    if (!(libevdev_has_event_type(dev, EV_KEY) && libevdev_has_event_code(dev, EV_KEY, KEY_ESC))) goto free_dev;

    usleep(100000);
    if (libevdev_grab(dev, LIBEVDEV_GRAB)) {
      fprintf(stderr, "Failed to grab %s: %s\n", file_path, strerror(errno));
      goto free_dev;
    }

    ev_devs[head] = dev;
    ev_fds[head] = fd;
    head++;
    continue;
    
  free_dev:
    libevdev_free(dev);
  close_fd:
    close(fd);
    continue;
  }

  if (head == 0) {
    fprintf(stderr, "No supported keyboards found");
    return 1;
  }

  fprintf(stdout, "All inputs grabbed successfully\n");

  int uinput_fd;
  struct libevdev_uinput *uinput_dev = NULL;
  struct libevdev *tmp_dev = NULL;
  struct input_event event;

  uinput_fd = open(UINPUT_PATH, O_WRONLY | O_NONBLOCK);
  if (uinput_fd < 0) { 
    fprintf(stderr, "Failed to open %s: %s\n", UINPUT_PATH, strerror(errno));
    goto cleanup_error;
  }

  if (libevdev_new_from_fd(ev_fds[0], &tmp_dev)) {
    fprintf(stderr, "Failed to create a temporary device\n");
    close(uinput_fd);
    goto cleanup_error;
  }

  libevdev_set_name(tmp_dev, "My Keyboard");

  if (libevdev_uinput_create_from_device(tmp_dev, uinput_fd, &uinput_dev)) {
    fprintf(stderr, "Failed to create virtual keyboard: %s\n", strerror(errno));
    close(uinput_fd);
    libevdev_free(tmp_dev);
    goto cleanup_error;
  }

  libevdev_free(tmp_dev);

  {
    struct pollfd pfds[head];

    for (int i = 0; i < head; i++) {
      pfds[i].fd = ev_fds[i];
      pfds[i].events = POLLIN;
    }

    while (keep_running) {
      int num_events = poll(pfds, head, -1); 

      if (num_events < 0) {
        if (errno == EINTR) break;  // Normal exit
        fprintf(stderr, "Poll Failed: %s\n", strerror(errno));
        break;
      }

      for (int i = 0; i < head; i++) {
        if (pfds[i].revents & POLLHUP) {
          pfds[i].fd = -1;
        }
        if (pfds[i].revents & POLLIN) {
          while(libevdev_next_event(ev_devs[i], LIBEVDEV_READ_FLAG_NORMAL, &event) == LIBEVDEV_READ_STATUS_SUCCESS) {
            if (event.type != EV_KEY && event.type != EV_SYN) continue;
            // swap SUPER and ALT on bluetooth keyboard
            const char *dev_name = libevdev_get_name(ev_devs[i]);
            if (dev_name && !(strcmp(dev_name, "Optimus BT1 Keyboard"))) {
                if (event.code == KEY_LEFTMETA) { event.code = KEY_LEFTALT; }
                else if (event.code == KEY_LEFTALT) { event.code = KEY_LEFTMETA; }
                else if (event.code == KEY_RIGHTALT) { event.code = KEY_RIGHTCTRL; }
            }

            // swap CAPS and ESC
            if (event.code == KEY_CAPSLOCK) { event.code = KEY_ESC; }
            else if (event.code == KEY_ESC) { event.code = KEY_CAPSLOCK; }
            libevdev_uinput_write_event(uinput_dev, event.type, event.code, event.value);
          }
        }
      }
    }
  }

  fprintf(stdout, "Clean exit\n");
  int exit_code = 0;
  libevdev_uinput_destroy(uinput_dev);
  close(uinput_fd);
  goto cleanup;

cleanup_error:
  exit_code = 1;

cleanup:
  for (int i = 0; i < head; i++) {
    libevdev_grab(ev_devs[i], LIBEVDEV_UNGRAB);
    libevdev_free(ev_devs[i]);
    close(ev_fds[i]);
  }
  return exit_code;
}
