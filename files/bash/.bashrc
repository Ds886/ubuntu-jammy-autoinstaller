PATH_BASH_CONFIG="$HOME/.config/bash"

BASH_CONFIG_FILES="$(find "${PATH_BASH_CONFIG}" -type f |sort)"

for item in ${BASH_CONFIG_FILES} 
do
  source $item
done



