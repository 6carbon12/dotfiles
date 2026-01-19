SHELL := /bin/bash

.PHONY: help install link system clean all

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install    Install all packages"
	@echo "  link       Symlink dotfiles to ~/.config"
	@echo "  system     Copy system-wide configs to / (requires sudo)"
	@echo "  clean      Remove backups created by system setup"
	@echo "  all        Run install, link, and system"

install:
	@echo "📦 Installing packages..."
	@bash scripts/install.sh

user:
	@echo "🔗 Linking dotfiles..."
	@bash scripts/user.sh

root:
	@echo "🔧 Setting up system configurations..."
	@bash scripts/root.sh

clean:
	@echo "🧹 Cleaning up..."
	@bash scripts/clean.sh

all: install link system
