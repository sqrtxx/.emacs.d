# .emacs.d

## 前提

emacs は 24.5 をインストールしておくこと.


Cask で管理する.
詳細は [Emacs - caskとpalletを使って、RubyのBundlerのようにpackage.elから管理する - Qiita](http://qiita.com/kametaro/items/2a0197c74cfd38fddb6b) を参照のこと.

## How to use

ダウンロード

```bash
cd ~
git clone git@github.com:sqrtxx/.emacs.d.git
```

cask をインストール

```bash
curl -fsSkL https://raw.github.com/cask/cask/master/go | python
```

cask をアップグレード

```bash
cask upgrade
```

cask install

```bash
cd ~/.emacs.d
cask install
```
