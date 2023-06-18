# Mayeu's dotfiles

My dotfiles, the whole organisation is based on the work of
[@caarlos0][caarlos-dots], with some adaptation.

I am pretty sure you won't be interested to install it on your machine since it
is a custom configuration. Maybe at some point I will extract the commonality
between his repo and mine to make it an independent and customisable dotfiles
template (don't dream too much, I have a lot of other stuff to do!)

The docs currently still live in [@caarlos0][caarlos-docs] repository.

## Some useful commands

- `reload!`: reload your shell

## Why not a fork?

This repository is not a fork of @caarlos0 one, because his repository has some
corruption going on:

```
➜ git clone https://github.com/caarlos0/dotfiles
Cloning into 'dotfiles'...
remote: Enumerating objects: 53, done.
remote: Counting objects: 100% (53/53), done.
remote: Compressing objects: 100% (39/39), done.
error: object 3aadee53f1ea498f2e496d63ac24cf28b358b9b7: zeroPaddedFilemode: contains zero-padded file modes
fatal: fsck error in packed object
fatal: index-pack failed
```

(and no, I don't consider deactivating the fsck check a solution to this issue.)

[caarlos-dots]: https://github.com/caarlos0/dotfiles
[caarlos-docs]: https://github.com/caarlos0/dotfiles/tree/master/docs
