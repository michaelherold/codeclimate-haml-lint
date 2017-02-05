## HamlLint/LineLength

Option | Description
-------|-----------------------------------------------------------------
`max`  | Maximum number of columns a single line can have. (default `80`)

Wrap lines at 80 characters. You can configure this amount via the `max`
option on the linter, e.g. by adding the following to your `.haml-lint.yml`:

```yaml
linters:
  LineLength:
    max: 100
```

Long lines are harder to read and usually indicative of complexity. You can
avoid them by splitting long attribute hashes on a comma, for example:

```haml
%tag{ attr1: 1,
      attr2: 2,
      attr3: 3 }
```

This significantly improves readability.