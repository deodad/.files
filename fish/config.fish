###############################################################################
# Initialize XDG base directory environment variables as defined in:
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html.
#
# Explicitly define them here so we don't need to add the additional code of
# handling the case where they are not explicitly defined, simplifying the code
# in the rest of our configurations which use XDG.

# Directory where user-specific data files should be stored.
export XDG_DATA_HOME="$HOME/.local/share"
# Preference-ordered set of base directories to search for data files in
# addition to the $XDG_DATA_HOME base directory.
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
# Directory where user-specific configuration files should be stored.
export XDG_CONFIG_HOME="$HOME/.config"
# Preference-ordered set of base directories to search for configuration files
# in addition to the $XDG_CONFIG_HOME base directory.
export XDG_CONFIG_DIRS="/etc/xdg"
# Directory where user-specific non-essential data files should be stored.
export XDG_CACHE_HOME="$HOME/.cache"

###############################################################################
# Update PATH with helpful utilities

# homebrew
/opt/homebrew/bin/brew shellenv | source

fish_add_path /opt/homebrew/opt/curl/bin # Not installed in default brew bin dir
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin # Use GNU core utils (`ls` etc) instead of macOS ones
fish_add_path /opt/homebrew/opt/postgresql@17/bin
fish_add_path "$HOME/.files/git-helpers"
fish_add_path "$HOME/.claude/local"
fish_add_path "$HOME/.local/bin"

# fnm
fnm env --shell fish | source

# rust
source "$HOME/.cargo/env.fish"

# direnv
direnv hook fish | source


###############################################################################

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim

set -g fish_greeting 'hey there'
set -g fish_prompt_pwd_dir_length 0

set -g fish_key_bindings fish_vi_key_bindings

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line

# Use `less` as the default viewer for multi-page output
set -x PAGER "less"

# Output ANSI control/color sequences
set -x LESS "--RAW-CONTROL-CHARS"

if which gpgconf >/dev/null 2>&1
  if not pgrep gpg-agent >/dev/null
    gpgconf --launch gpg-agent
  end

  set -x SSH_AUTH_SOCK "$(gpgconf --list-dirs agent-ssh-socket)"

  # Ensure pinentry program displays to the correct terminal
  set -x GPG_TTY "$(tty)"
  set -x GNUPGHOME "$HOME/.gnupg"
  gpg-connect-agent updatestartuptty /bye >/dev/null
else
  echo "Skipping GPG setup since it is not yet installed."
end


# vi + emacs bindings
function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

### edit configs
abbr -a conf-fish 'nvim ~/.config/fish/config.fish'
abbr -a conf-nvim 'nvim ~/.config/nvim'
abbr -a conf-files 'nvim ~/.files'
abbr -a conf-tmux 'nvim ~/.config/tmux/tmux.conf'

abbr -a v nvim

# tmux
abbr -a ta tmux attach
abbr -a td tmux detach

# eza
abbr -a ls eza
abbr -a lsa 'eza -lah'
abbr -a lt 'eza --tree'

# git
function git_main_branch -d 'Detect name of main branch of current git repository'
  # heuristic to return the name of the main branch
  command git rev-parse --git-dir &> /dev/null || return
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,master,trunk}
    if command git show-ref -q --verify $ref
      echo (string split -r -m1 -f2 / $ref)
      return
    end
  end
  echo main
end

function git_current_branch -d 'Detect name of current branch of current git repository'
  echo (git branch --show-current)
end

abbr -a g git

abbr ga 'git add'
abbr gaa 'git add --all'
abbr gapa 'git add --patch'
abbr gau 'git add --update'
abbr gav 'git add --verbose'
abbr gap 'git apply'
abbr gapt 'git apply --3way'

abbr gb 'git branch'
abbr gba 'git branch -a'
abbr gbd 'git branch -d'
abbr gbD 'git branch -D'

abbr gbl 'git blame -b -w'

abbr gc 'git commit -v'
abbr gc! 'git commit -v --amend'
abbr gcn 'git commit -v --no-edit'
abbr gcn! 'git commit -v --amend --no-edit'
abbr gca 'git commit -a -v'
abbr gca! 'git commit -a -v --amend'
abbr gcan! 'git commit -a -v --no-edit --amend'
abbr gcans! 'git commit -a -v -s --no-edit --amend'
abbr gcam 'git commit -a -m'
abbr gcas 'git commit -a -s'
abbr gcasm 'git commit -a -s -m'
abbr gcsm 'git commit -s -m'
abbr gcm 'git commit -m'
abbr gcs 'git commit -S'
abbr gwip 'git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'

abbr gclean 'git clean -id'

abbr gco 'git checkout'
abbr gcob 'git checkout -b'
abbr gcb 'git checkout -b'

abbr gcp 'git cherry-pick'
abbr gcpa 'git cherry-pick --abort'
abbr gcpc 'git cherry-pick --continue'

abbr gf 'git fetch'
abbr gfa 'git fetch --all --prune'
abbr gfo 'git fetch origin'

abbr gl 'git log'
abbr gls 'git log --stat'
abbr glsp 'git log --stat -p'
abbr glg 'git log --graph'
abbr glgda 'git log --graph --decorate --all'
abbr glgm 'git log --graph --max-count=10'
abbr glo 'git log --oneline --decorate'
abbr glog 'git log --oneline --decorate --graph'
abbr gloga 'git log --oneline --decorate --graph --all'

abbr gp 'git push'
abbr gpd 'git push --dry-run'
abbr gpf 'git push --force-with-lease'
abbr gpf! 'git push --force'
abbr gpsu 'git push --set-upstream origin (git_current_branch)'
abbr gpt 'git push --tags'
abbr gptf 'git push --tags --force-with-lease'
abbr gptf! 'git push --tags --force'

abbr gpl 'git pull'
abbr gplo 'git pull origin'
abbr gplom 'git pull origin (git_main_branch)'
abbr gplu 'git pull upstream'
abbr gplum 'git pull upstream (git_main_branch)'

abbr grbbb 'git fetch origin main:main -f && git rebase main'
abbr grb 'git rebase'
abbr grbm 'git rebase main'
abbr grba 'git rebase --abort'
abbr grbc 'git rebase --continue'
abbr grbi 'git rebase -i'
abbr grbom 'git rebase origin/(git_main_branch)'
abbr grbo 'git rebase --onto'
abbr grbs 'git rebase --skip'

abbr grs 'git reset'
abbr grs! 'git reset --hard'
abbr grsh 'git reset HEAD'
abbr grsh! 'git reset HEAD --hard'
abbr grsoh 'git reset origin/(git_current_branch)'
abbr grsoh! 'git reset origin/(git_current_branch) --hard'
abbr gpristine 'git reset --hard && git clean -dffx'
abbr grs- 'git reset --'

abbr gs 'git status'
abbr gss 'git status -s'
abbr gsb 'git status -sb'

abbr gst 'git stash'
abbr gsta 'git stash apply'
abbr gstc 'git stash clear'
abbr gstd 'git stash drop'
abbr gstl 'git stash list'
abbr gstp 'git stash pop'
abbr gstshow 'git stash show --text'
abbr gstall 'git stash --all'
abbr gsts 'git stash save'

abbr gsw 'git switch'
abbr gswc 'git switch -c'
abbr gg 'git switch -'

abbr lg lazygit
abbr gt 'git trim --no-confirm'

# yarn
abbr -a y yarn
abbr -a ya yarn add
abbr -a yad yarn add --dev

# pnpm
abbr -a p pnpm

# make
abbr -a m make

# claude
abbr -a c 'env SHELL=/bin/bash claude'

# zoxide
zoxide init fish | source

# mobile dev
abbr dl 'xcrun simctl openurl booted'
abbr dla 'adb shell am start -a android.intent.action.VIEW -d'

# gpg
export GPG_TTY=$(tty)

# android studio
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=/Users/deodad/Library/Android/sdk
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools

fish_add_path -a /Users/deodad/.foundry/bin

# pnpm
set -gx PNPM_HOME "/Users/deodad/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Load any local configuration, if any
if test -e "$HOME/.config/fish/local.fish"
  source "$HOME/.config/fish/local.fish"
end


fish_add_path -a /Users/deodad/.config/.foundry/bin

# Amp CLI
export PATH="/Users/deodad/.amp/bin:$PATH"

# Created by `pipx` on 2026-01-13 20:41:33
set PATH $PATH /Users/deodad/.local/bin
