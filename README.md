# NVIM CONFIGS

## For Yanking

1. Download win32yank on Windows

    Download the latest release:

            https (colon) //github.com/equalsraf/win32yank/releases

            Download win32yank-x64.zip → extract win32yank.exe.

2. Put it somewhere WSL can access

    For example:

            C:\Users\<you>\bin\win32yank.exe

3. Make it executable inside WSL

    WSL can run Windows binaries directly, but you must give exec perms:

            chmod +x /mnt/c/Users/<you>/bin/win32yank.exe

4. Add it to your PATH inside WSL

    Add this to your ~/.bashrc or ~/.zshrc:

            export PATH="$PATH:/mnt/c/Users/<you>/bin"


5. Tell Neovim to use the clipboard

        vim.opt.clipboard = "unnamedplus"

## For FuzzyFinding

I think we needed to install ripgrep, don't remember anymore:

        sudo apt install ripgrep and fd

## For formatters

Needed apt install `unzip` and `python3-venv`
