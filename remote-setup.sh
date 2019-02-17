#!/usr/bin/env bash

# [[ -x `command -v wget` ]] && CMD="wget --no-check-certificate -O -"
# [[ -x `command -v curl` ]] >/dev/null 2>&1 && CMD="curl -#L"
CMD="curl -#L"
if [ -z "$CMD" ]; then
  echo "No curl or wget available. Aborting."
else
  echo "Installing dotfiles"
  mkdir -p "$HOME/src/dotfiles" && \
  eval "$CMD https://github.com/0i0/dotfiles/tarball/master | tar -xzv -C ~/src/dotfiles --strip-components=1 --exclude='{.gitignore}'"
  . "$HOME/src/dotfiles/setup.sh"
fi