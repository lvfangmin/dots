#!/bin/bash

VIM=~/.vim

# create required folders
mkdir -p "$VIM/autoload/" "$VIM/bundle/"

# install pathogen to manage vim plugins
curl -LSso $VIM/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# download all bundles
BUNDLES=("git@github.com:mileszs/ack.vim.git"
         "git@github.com:vim-scripts/AutoComplPop.git"
         "git@github.com:wincent/command-t.git"
         "git@github.com:rizzatti/dash.vim.git"
         "git@github.com:Raimondi/delimitMate.git"
         "git@github.com:vim-scripts/mru.vim.git"
         "git@github.com:Shougo/neocomplcache.vim.git"
         "git@github.com:scrooloose/nerdtree.git"
         "git@github.com:kien/rainbow_parentheses.vim.git"
         "git@github.com:majutsushi/tagbar.git"
         "git@github.com:altercation/vim-colors-solarized.git"
)

pushd . && cd $VIM/bundle

for bundle in "${BUNDLES[@]}"; do
  name=`echo $bundle | sed -e "s|\([^/]*\)/\(.*\).git|\2|"`
  if [ ! -e $name ]; then
    git clone $bundle
    echo "successfully cloned bundle: $bundle."
  else
    echo "bundle: $bundle already exist, skip cloning it!"
  fi
done

popd

# init command-t
if [ -e $VIM/bundle/command-t/ruby/command-t ]; then
  pushd . && cd $VIM/bundle/command-t/ruby/command-t
  ruby extconf.rb && make && make install
  popd
fi

# init tagbar
pushd . && cd /tmp
# download and install tagbar's prerequest ctags
CTAGS_URL=http://ncu.dl.sourceforge.net/project/ctags/ctags/5.8/ctags-5.8.tar.gz
curl -LSso ctags.tar.gz $CTAGS_URL \
  && tar -zxvf ctags.tar.gz && cd ctags-* && ./configure && make \
  && sudo make install
# clean up
cd .. && rm -rf ctags-* && rm ctags.tar.gz
popd

# init power line
