@echo off

REM Remove neovim
choco uninstall neovim -y

REM Remove ripgrep
choco uninstall ripgrep -y

REM Remove nvim appdata
rd /s /q %LocalAppData%\nvim
rd /s /q %LocalAppData%\nvim-data


