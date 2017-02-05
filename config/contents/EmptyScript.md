## HamlLint/EmptyScript

Don't write empty scripts.

**Bad: script marker with no code**
```haml
-
```

**Good**
```haml
- some_expression
```

These serve no purpose and are usually left behind by mistake.