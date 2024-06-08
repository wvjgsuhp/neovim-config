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

[splash]: https://github.com/wvjgsuhp/neovim-config/assets/20987347/63172b0c-ff9b-4042-8e6f-4482f7c96e62
[cmp]: https://github.com/wvjgsuhp/neovim-config/assets/20987347/855d9a42-484e-4749-9c79-dd0b27b95fee
