# edgeframe (v0.1.0)

Custom margins and other components for page setup or layout.

## Usage

Add the package with the following code. Remember to add the asterisk `: *` at the end.

```typ
#include "@preview/edgeframe:0.2.0": *
```

```typ
#set page(margin: margin.normal)
```

> Parameters with `x` and `y` should to be used together
>
> ```
> #set page(margin: (x: margin.moderate-x, y: margin.moderate-y))
> ```

```typ
#show: doc => ef-document(
  header: ("Head L", "Head C", "Head R"),
  header-alignment: center; // ignored when there are more than one two headings
  doc,
)
```
