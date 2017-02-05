## HamlLint/ImplicitDiv

Avoid writing `%div` when it would otherwise be implicit.

**Bad: `div` is unnecessary when class/ID is specified**
```haml
%div.button
```

**Good: `div` is required when no class/ID is specified**
```haml
%div
```

**Good**
```haml
.button
```

HAML was designed to be concise, and not embracing this philosophy makes the
tool less useful.