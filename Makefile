SHELL := /bin/bash

.PHONY: help install link system clean all

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install    Install all packages"
	@echo "  link       Symlink dotfiles to ~/.config"
	@echo "  all        Run install, link, and system"

install:
	@echo "📦 Installing packages..."
	@bash scripts/install.sh

user:
	@echo "🔗 Linking dotfiles..."
	@bash scripts/user.sh

all: install link
