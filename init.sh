#!/bin/bash
function backup() {
  if [ -e $1 ]; then
    mv $1 ${1}_${2}
  fi
}

if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

backup_suffix='bk'
script_dir=$(cd $(dirname $0); pwd)

home_file_paths=(~/.vimrc ~/.bashrc ~/.gitconfig)
script_file_paths=($script_dir/.vimrc $script_dir/.bashrc $script_dir/.gitconfig)
((n_elements=${#home_file_paths[@]}, max_index=n_elements - 1))

for ((i = 0; i <= max_index; i++)); do
  home_file_path=${home_file_paths[i]}
  script_file_path=${script_file_paths[i]}

  backup $home_file_path $backup_suffix
  cp -rf ${script_file_path} ~/

  echo "Setting of $home_file_path is completed.\n"
done

mkdir -p ~/.vim/bundle
backup ~/.vim/bundle/neobundle $backup_suffix
git clone https://github.com/shougo/neobundle.vim ~/.vim/bundle/neobundle
echo "neobundle download is complete.\n"

setting_files=(~/git-completion.bash ~/dircolors.ansi-universal)
setting_file_urls=(\
  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
  https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-universal\
)
((n_elements=${#setting_files[@]}, max_index=n_elements - 1))

for ((i = 0; i <= max_index; i++)); do
  setting_file=${setting_files[i]}
  setting_file_url=${setting_file_urls[i]}
  backup $setting_file $backup_suffix
  curl -s $setting_file_url > $setting_file
  echo "Setting of $setting_file is completed.\n"
done

if [ $OS == 'Mac' ]; then
  echo "brew update.\n"
  brew update
  if [ `brew ls --versions coreutils > /dev/null` ]; then
    echo "brew install coreutils.\n"
    brew install coreutils
    brew unlink coreutils && brew link --force coreutils
    echo "coreutils is completed.\n"
  fi

  if [ `brew ls --versions ricty > /dev/null` ]; then
    echo "brew install ricty.\n"
    brew tap sanemat/font
    brew install ricty
    cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
    fc-cache -vf
    echo "ricty is completed.\n"
  fi
fi

echo "Please execute 'source ~/.bashrc'"
