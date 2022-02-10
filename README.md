# dotfiles

1. gitとzshをインストール
2. OSのデフォルトのシェルがzshでない場合、`cat /etc/shells` と `chsh`
3. https://github.com/romkatv/powerlevel10k を参考にフォントをインストール
4. `zsh setup.sh`

zshが5.1より古いとpowerlevel10kが動かないので

```sh
vi .zpreztorc
```

でテーマをpureとかに変える
