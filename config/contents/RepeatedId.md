## HamlLint/RepeatedId

The `id` attribute [must be unique] on the page since is intended to be a unique
identifier. Repeating an `id` is an error in the HTML specification.

**Bad**
```haml
#my-id
#my-id
```

**Better**
```haml
#my-id
#my-id-2
```

[must be unique]: https://www.w3.org/TR/html5/dom.html#the-id-attribute