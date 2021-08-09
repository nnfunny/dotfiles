# $PATH
export TERM="xterm-256color"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.fzf/bin


# Variables
export FORMAT="ID\t{{.ID}}\nNAME\t{{.Names}}\nIMAGE\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n"

# Starship
#eval "$(starship init zsh)"
PROMPT='%F{cyan}%n%f %~'$'\n$ '

# Z
if command -v brew >/dev/null 2>&1; then
	# Load rupa's z if installed
	[ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
fi

# auto-completions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Vim mode
set -o vi

# Reduce latency when pressing <Esc>
export KEYTIMEOUT=1

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh time
function timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# mov to gif
function movgif() {
  movie=$1
  height=$(mdls -name kMDItemPixelHeight ${movie} | grep -o '[0-9]\+')
  width=$(mdls -name kMDItemPixelWidth ${movie} | grep -o '[0-9]\+')
  dimensions="${width}x${height}"
  ffmpeg -i ${movie} -s ${dimensions} -pix_fmt rgb24 -r 1 -f gif output.gif
  gifsicle -O3 output.gif -o output.gif
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
