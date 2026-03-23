# dotfiles

## My dotfiles for:

* emacs
* fish
* git(ignore global, config)
* screen
* textlint
* tmux
* vim
* zsh

## ファイル命名規則

`install.sh` は以下のルールでシンボリックリンクを作成する：

| リポジトリ内 | リンク先 | 説明 |
|---|---|---|
| `conf.gitconfig` | `~/.gitconfig` | 先頭の `conf` を除去してリンク |
| `dot.config/` | `~/.config/` | 先頭の `dot` を除去してリンク |

- `conf.*` → ファイルを `~/.*` にリンク
- `dot.*` → ディレクトリを `~/.*/` にリンク

## Install:

```sh
$ git clone https://github.com/rednes/dotfiles.git
$ ./dotfiles/install.sh
```

## zsh の設定について

`install.sh` は `~/.git.zshrc` のシンボリックリンクを作成するが、**`~/.zshrc` は手動で作成する必要がある**。

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

