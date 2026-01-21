#include <signal.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define TRUE 1

int open_ipc_sock(char *path, int n);
int query_state(int ipc_sock);
void publish_state(const char *XDG_RUNTIME_DIR,const char *HYPRLAND_INSTANCE_SIGNATURE);
int send_ipc_command(char *command, int ipc_sock);

// Replacements for snprintf and printf
void build_socket_path(char *dest, const char *xdg, const char *sig, const char *suffix);
void print(const char *str);

char path_buf[108];
char read_buf[1024];
char staging_buf[4096];
char output_buf[8192];

const int MAX_RETRIES = 3;
const float RETRY_DELAY = 200 * 1000; // micro seconds

int main() {
  const char *XDG = getenv("XDG_RUNTIME_DIR");
  const char *SIGN = getenv("HYPRLAND_INSTANCE_SIGNATURE");
  signal(SIGPIPE, SIG_IGN);

  if (!XDG || !SIGN) {
    print("\
      $XDG_RUNTIME_DIR or $HYPRLAND_INSTANCE_SIGNATURE not found\n\
      Are you sure you are running this in a Hyprland session?\
    ");
    return 1;
  }

  publish_state(XDG, SIGN);

  build_socket_path(path_buf, XDG, SIGN, "/.socket2.sock");
  int event_socket = open_ipc_sock(path_buf, sizeof(path_buf));
  int staging_buf_len = 0;

  while (TRUE) {
    long len = read(event_socket, read_buf, sizeof(read_buf));
    memcpy(staging_buf + staging_buf_len, read_buf, len);
    staging_buf_len += len;

    while (TRUE) {
      char *newline_ptr = memchr(staging_buf, '\n', staging_buf_len);
      if (!newline_ptr) break;

      *newline_ptr = '\0';
      if (strstr(staging_buf, "openwindow") || strstr(staging_buf, "closewindow") || strstr(staging_buf, "movewindow")) {
        publish_state(XDG, SIGN);
      }
      staging_buf_len -= (strlen(staging_buf) + 1); // lenght of string + 1 for the null terminator
      memmove(staging_buf, newline_ptr + 1, staging_buf_len);
    }
  }
}

int open_ipc_sock(char *path, int n) {
  if (n > 108) return -1;

  struct sockaddr_un socket_addr;
  memset(&socket_addr, 0, sizeof(socket_addr));
  strcpy(socket_addr.sun_path, path);
  socket_addr.sun_family = AF_UNIX;

  int sock = socket(AF_UNIX, SOCK_STREAM, 0);
  int connect_fail = connect(sock, (struct sockaddr *)&socket_addr, n);
  if (connect_fail) return -1;

  return sock;
}

int query_state(int ipc_sock) {
  while (TRUE) {
    int read_bytes = read(ipc_sock, output_buf, sizeof(output_buf) - 1);
    output_buf[read_bytes] = '\0';  // make it a valid C-string so str str can work
    if (!read_bytes) return 0;
    if (strstr(output_buf, "special:minimized")) return 1;
  }
}

int send_ipc_command(char *command, int ipc_sock) {
  int written_bytes = write(ipc_sock, command, strlen(command));
  if (written_bytes == -1 || written_bytes < strlen(command)) {
    return -1;
  }
  return 0;
}

void publish_state(const char *XDG_RUNTIME_DIR,const char *HYPRLAND_INSTANCE_SIGNATURE) {
  build_socket_path(path_buf, XDG_RUNTIME_DIR, HYPRLAND_INSTANCE_SIGNATURE, "/.socket.sock");

  int command_sock;
  for (int i = 0; i < MAX_RETRIES; i++) {
    command_sock = open_ipc_sock(path_buf, sizeof(path_buf));
    if (command_sock != -1 && send_ipc_command("clients", command_sock) != -1 ) {
      break;
    }
    usleep(RETRY_DELAY);
  }

  char *output;
  if (query_state(command_sock)) {
    output = "{\"text\": \"●\", \"class\": \"occupied\", \"tooltip\": \"Minimized Windows\"}\n";
  }
  else {
    output = "{\"text\": \"\", \"class\": \"\", \"tooltip\": \"\"}\n";
  }

  close(command_sock);
  write(STDOUT_FILENO, output, strlen(output));
}

void print(const char *str) {
  write(STDOUT_FILENO, str, strlen(str));
}

void build_socket_path(char *dest, const char *xdg, const char *sig, const char *suffix) {
  strcpy(dest, xdg);
  strcat(dest, "/hypr/");
  strcat(dest, sig);
  strcat(dest, suffix);
}
