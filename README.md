# dotfiles

## My dotfiles for:

* emacs
* git(ignore global, config)
* screen
* textlint
* tmux
* zellij
* vim
* zsh

## 管理方法

[chezmoi](https://www.chezmoi.io/) で管理しています。

## Install

### 新しいマシンへのセットアップ

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply rednes
```

### 日常の使い方

```sh
# ファイルを管理対象に追加
chezmoi add ~/.example

# ファイルを編集
chezmoi edit ~/.example

# 変更をホームディレクトリに反映
chezmoi apply

# ソースと実ファイルの差分を確認
chezmoi diff

# 管理対象ファイルの一覧
chezmoi managed
```

## zsh の設定について

`chezmoi apply` は `~/.git.zshrc` を配置するが、**`~/.zshrc` は手動で作成する必要がある**。

以下のスニペットを `~/.zshrc` に追記すること：

```zsh
# GitHub管理の共通設定を読み込む
[[ -f ~/.git.zshrc ]] && source ~/.git.zshrc
```

## :+1: Commit symbol

|emoji              | mean            |
|-------------------|-----------------|
|:sparkles:         |機能追加         |
|:pencil2:          |修正             |
|:bug:              |バグ修正         |
|:hammer:           |リファクタリング |
|:fire:             |不要な記述の削除 |
|:memo:             |ドキュメント修正 |
