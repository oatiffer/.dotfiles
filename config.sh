#!/usr/bin/env bash

# Copyright 2025 Omar Tiffer
#
# Portions of this file are based on code from ThePrimeagen’s
# "My Dev Setup Is Better Than Yours" course on Frontend Masters.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

source "$DOTFILES"/utils.sh

parse_args "$@"

if_not_dry mkdir "$HOME"/.local/my-scripts
if_not_dry export PATH="$PATH":"$HOME"/.local/my-scripts

copy_dir() {
  local from=$1
  local to=$2

  pushd "$from" &>/dev/null || exit
  while IFS= read -r entry; do
    log INFO "Replacing $to/$entry with $PWD/$entry..."
    if_not_dry rm -rf "$to/$entry"
    if_not_dry cp -avr "$PWD/$entry" "$to/$entry"
  done < <(find . -mindepth 1 -maxdepth 1 \( -type f -o -type d \))
  popd &>/dev/null || exit
}

copy_file() {
  local from=$1
  local to=$2

  log INFO "Replacing $to with $from"
  if_not_dry rm "$to"
  if_not_dry cp -av "$from" "$to"
}

copy_dir "$DOTFILES"/.config "$HOME"/.config
copy_dir "$DOTFILES"/.local "$HOME"/.local

copy_file "$DOTFILES"/.zshrc "$HOME"/.zshrc
copy_file "$DOTFILES"/.gitconfig "$HOME"/.gitconfig
copy_file "$DOTFILES"/.tmux.conf "$HOME"/.tmux.conf

log OK "Successfully copied configuration files\n"
