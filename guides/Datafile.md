# Datafile

A Datafile consists of three components - filename, template and data.

> Datafiles are stored inside - `~/AarKay/AarKayData/`.

*Examples*
- `File.Greeting.yml`
- `Name.Mux.json`
- `Style.Colors.json`

> You can also use the same name for filename and template.

- `Mux.yml`
- `Colors.json`

## Dot Datafile

A Dot Datafile is a special kind of Datafile which starts with `dot.`.

*Examples*
- `dot.gitignore.yml`
- `dot.swift-version.yml`

## Collection Datafile

A Collection Datafile is also a special kind of Datafile which has contents of type array and defined with a `[]` prefix as following. It is used to generate multiple files of same kind using a template. The value for `name` key in data is used as the filename.

<p align="center"><img src="https://raw.githubusercontent.com/RahulKatariya/AarKay/master/.github/2.png"></p>

- `[].Mux.yml`

> You can also group the collection by providing name to segregate your data as following.

- `[work].Mux.yml`
- `[rk].Mux.yml`
- `[restofire].Mux.yml`
- `[aarkay].Mux.yml`

### Custom Filename

If you want to give a custom filename then you will need to add string with the key `"_fn"` inside your contents.

```yml
_fn: "Mac"
name: "macOS"
root: "RahulKatariya/macOS"
```

### Custom SubDirectory

If you want to give a custom sub directory then you will need to add string with the key `"_dn"` inside your contents.

```yml
_fn: "Mac"
_dn: "{path/to/sub/dir}"
name: "macOS"
root: "RahulKatariya/macOS"
```
