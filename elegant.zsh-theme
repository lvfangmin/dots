PROMPT='%{$fg[magenta]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%3~%{$reset_color%} %(!.#.$) '
RPS1='%{$fg[cyan]%}%*%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"