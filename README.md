# dotfiles

1. `ssh-keygen -t ed25519` して GitHubに追加
1. gitとzshをインストール
1. OSのデフォルトのシェルがzshでない場合、`cat /etc/shells` と `chsh`
1. cloneして`zsh setup.zsh`
1. https://github.com/romkatv/powerlevel10k を参考にフォントをインストール
1. Macの場合iTerm2の設定をインポート

`setup.zsh` はリポジトリ外から実行しても構いません。既存の設定ファイルは
`.backup.<日時>.<PID>` を付けて退避します。同じリンクがある場合は変更しません。
VS Code は `settings.json` のみをリンクし、拡張機能などは保持します。

zshが5.1より古いとpowerlevel10kが動かないので

```sh
vi .zpreztorc
```

でテーマをpureとかに変える
