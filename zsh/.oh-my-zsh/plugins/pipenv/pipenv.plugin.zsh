# tab completion
eval "$(pipenv --completion)"

# auto-toggle shell when changing directories
_togglePipenvShell() {
  # deactivate shell if Pipfile doesn't exit and not in a sub dir
  if [[ ! -a "$PWD/Pipfile" ]]; then
      if [[ "$PIPENV_ACTIVE" == 1 ]]; then
          if [[ "$PWD" != "$pipfile_dir"* ]]; then
            exit
          fi
    fi
  fi

  # activate the shell if Pipfile exists
  if [[ "$PIPENV_ACTIVE" != 1 ]]; then
    if [[ -a "$PWD/Pipfile" ]]; then
        pipfile_dir="$PWD" pipenv shell
        cd -
    fi
  fi
}

add-zsh-hook chpwd _togglePipenvShell
