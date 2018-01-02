## Neovim for Haskell Development

This setup assumes you are using the Haskell build tool Stack.

To install this configuration including plugins:

```
git clone --recursive git@github.com:johnmendonca/nvim.git ~/.config/nvim
```

Later you can update plugins:

```
cd ~/.config/nvim
git submodule update --recursive --remote
```

### Additional Setup

The expected Haskell tools must be present (if you want to use them):

```
stack install ghc-mod hlint hdevtools hsimport hindent stylish-haskell
```

The vimproc plugin requires a build step, on Linux:

```
cd ~/.config/nvim/bundle/vimproc.vim/
make
```

Deoplete requires a Python3 module:

```
pip3 install neovim
```

There are other system specific settings you may need to adjust.

Please read [the article](https://mendo.zone/fun/neovim-setup-haskell/) for full setup instructions.
