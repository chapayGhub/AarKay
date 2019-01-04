# Templatefile

A Templatefile consists of three components — Name, Extension and a [Stencil](https://github.com/kylef/Stencil) template template.

```
Hello {{name}}
```

Breaking down the above Tempaltefile — **Greeting.txt.stencil**
- **Greeting** — This is a unique name of the template.
- **txt** — This is the extension for all Generatedfiles.
- **Hello {{name}}** — This is the Stencil template.

> Templatefiles Directory — ~/AarKay/AarKayTemplates/AarKay/.

All the templates should be created inside Templatefiles Directory.

## AarKayEnd

AarKay allows you to add custom code after the mark `\n(.*)AarKayEnd`. Anything after this mark would not be overridden

```swift
Hello {{name}}

// AarKayEnd

This line will always remain same even if the template changes
```

## Template Placeholders

AarKay also allows you to have custom code inside your template by using placeholders blocks.

```swift
class SomeClass {

// <aarkay id>
Here (id) is unique identifier for this block. This block would not be overridden.
// </aarkay>

// <aarkay name>
Here (name) is unique identifier for this block. This block would not be overridden.
// </aarkay>

}
```
