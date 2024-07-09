# Neovim Configuration

A Neovim configuration you can tweak with.

![splash][splash]

![cmp][cmp]

## Prerequisites

1.  [CMake][cmake]
2.  [GCC][gcc]
3.  `make`
4.  [`curl`][curl] for [Supermaven][supermaven]
5.  [`ripgrep`][ripgrep]
6.  [`jsregexp`][jsregexp] (optional for LuaSnip)

## Try It Out

<details><summary>On your local machine</summary>

Back up your current configuration if there is.

```sh
mv ~/.config/nvim ~/.config/nvim.bak
```

```sh
git clone https://github.com/wvjgsuhp/neovim-config.git ~/.config/nvim
cd ~/.config/nvim
nvim
```

</details>

<details><summary>With Docker</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git curl neovim ripgrep alpine-sdk --update
  git clone https://github.com/wvjgsuhp/neovim-config.git ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<!-- TODO: add detail for tweaking -->
<!-- TODO: add common mappings -->

<!--external-->

[cmake]: https://cmake.org/
[gcc]: https://gcc.gnu.org/
[curl]: https://curl.se/
[jsregexp]: https://github.com/kmarius/jsregexp
[supermaven]: https://github.com/supermaven-inc/supermaven-nvim
[ripgrep]: https://github.com/BurntSushi/ripgrep

<!--images-->

[splash]: https://github.com/wvjgsuhp/neovim-config/assets/20987347/95c95384-91f5-4f75-84a3-1c1a14d78114
[cmp]: https://github.com/wvjgsuhp/neovim-config/assets/20987347/a407a955-6732-459b-8c16-24d96ebb1795
