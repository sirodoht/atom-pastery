# Atom Pastery

[![Code Shelter](https://www.codeshelter.co/static/badges/badge-flat.svg)](https://www.codeshelter.co/)

> A package for the sweetest pastebin, pastery.net :cake:

Pastery creates a new paste on the [pastery.net](https://www.pastery.net) pastebin.

If there is text selected, it will post it, otherwise it will post the whole file.

Once it gets posted, it will inject the URL to the clipboard, awaiting to be pasted.

Default shortcut is `ctrl+alt+p`

```sh
apm install pastery
```

## Develop

1. Clone repo
1. Symbolic link it on `~/.atom/packages`
1. Release version with `apm publish {major/minor/patch}`

## License

[MIT](LICENSE.md).
