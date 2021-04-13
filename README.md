# mydev

將自己使用 VSCode 開發程式（Go)常用的工具與環境設定，建立 Docker Image。

## 開發環境

1. Go
1. VSCode Remote-Conainers
1. VSCode extensions:
    1. shd101wyy.markdown-preview-enhanced
    1. davidanson.vscode-markdownlint
    1. slevesque.vscode-hexdump
    1. in4margaret.compareit
    1. TabNine.tabnine-vscode
    1. golang.Go
    1. eamodio.gitlens
1. Markdown Preview Enhanced 相關:
    1. PlantUML
        1. JDK
        1. GraphViz
    1. Pandoc
        1. pdflatex
        1. imagemagick
    1. Chrome and Puppeteer

## 常用工具

1. git-lfs
1. zsh and Ohmyzsh
1. tmux and Ohmytmux
1. ffmpeg
1. curl and wget
1. zip
1. xsel

## 設定

在安裝完 VSCode 後，請將以下，加入 VSCode 的 User 設定。

@import "settings.json"

設定完後，使用 VSCode 的 Remote-Containers 的功能，Attach 啟動的後的 container，會自動安裝相關的 VSCode extensions.
