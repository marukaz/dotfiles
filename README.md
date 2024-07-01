# dotfiles

1. `ssh-keygen -t ed25519` して GitHubに追加
1. gitとzshをインストール
1. OSのデフォルトのシェルがzshでない場合、`cat /etc/shells` と `chsh`
1. cloneして`zsh setup.zsh`
1. https://github.com/romkatv/powerlevel10k を参考にフォントをインストール
1. Macの場合iTerm2の設定をインポート

zshが5.1より古いとpowerlevel10kが動かないので

```sh
vi .zpreztorc
```

でテーマをpureとかに変える
