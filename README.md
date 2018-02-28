# git-diff-unified.vim

Open the result of `git diff` in Vim.

experimental: Auto save diff file if `/tmp` directory exists.

## Installation

### NeoBundle

Add the following line to .vimrc.

```
NeoBundle 'clear-code/git-diff-unified.vim'
```

## Usage

```
:GitDiffUnified [OPTIONS]
```

### For example

* `:GitDiffUnified`
* `:GitDiffUnified --cached`
