@echo off

REM Install rip-grep dependency for telescope.
choco install ripgrep -y

REM Install neovim
choco install neovim -y

REM Install plug
curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir %LocalAppData%\nvim-data\site\autoload\plug.vim
copy /Y plug.vim %LocalAppData%\nvim-data\site\autoload\plug.vim

REM configure nvim
mkdir %LocalAppData%\nvim
copy /Y ../init.vim %LocalAppData%\nvim
