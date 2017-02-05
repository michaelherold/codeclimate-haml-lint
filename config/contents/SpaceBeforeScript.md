## HamlLint/SpaceBeforeScript

Separate Ruby script indicators (`-`/`=`) from their code with a single space.

**Bad: no space between `=` and `some_expression`**
```haml
=some_expression
```

**Good**
```haml
= some_expression
```

**Good**
```haml
- some_value = 'Hello World'
```

Ensuring space after `-`/`=` enforces a consistency that all HAML tags/script
indicators are separated from their inline content by a space. Since it is
optional to add a space after `-`/`=` but required when writing `%tag` or
similar, the consistency is best enforced via a linter.