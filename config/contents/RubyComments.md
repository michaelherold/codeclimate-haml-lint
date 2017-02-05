## HamlLint/RubyComments

Prefer HAML's built-in comment over ad hoc comments in Ruby code.

**Bad: Space after `#` means comment is actually treated as Ruby code**
```haml
- # A Ruby comment
```

**Good**
```haml
-# A HAML comment
```

While both comment types will result in nothing being output, HAML comments
are a little more flexible in that you can have them span multiple lines, e.g.

```haml
-# This is a multi-line
   HAML comment
```