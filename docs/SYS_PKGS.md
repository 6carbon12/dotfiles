# SYSTEM PACKAGES

Packages used to setup the base system.

## Bootloader

- **grub**: Main Bootloader
- **efibootmgr**: Used by grub to write EFI boot records

## File System and Snapshots

- **btrfs-progs**: Utilities to interact with BTRFS.
- **snapper**: Snapshot manager.
- **snap-pac**: Pacman hooks for pre and post snapshot on updates.
- **grub-btrfs**: Adds snapshots to GRUB menu.
    - **inotify-tools**: Needed for grub-btrfsd

## Boot Splash

- **plymouth**: Used to show boot animations
- **plymouth-theme-tech-a-git**: Themes for plymouth

## Bluetooth Stack

- **bluez**: Main protocol for bluetooth stack.
- **bluez-utils**: Utilities to interface with bluetooth

## Printer Stack

- **cups**: Main backend to interface with printers
- **cups-pdf**: Used to create print-to-PDF printer
