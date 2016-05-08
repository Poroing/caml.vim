# caml.vim
Modification of the original ocaml.vim to fit Caml syntax.

## Usage

In the shell:
```
$ git clone https://github.com/Poroing/caml.vim.git
$ mkdir -p ~/.vim/after/syntax/
$ cp caml.vim/caml.vim .vim/after/syntax/
```

In your `.vimrc` add:
```
au BufNewFile,BufRead *.ml set filetype=caml
au BufNewFile,BufRead *.mli set filetype=caml
```

## Author Note

This caml.vim file is dedicated to the poor french CPGE student who
have to code in the non-utilized language caml language and therefore don't
have access to any proper tool.
