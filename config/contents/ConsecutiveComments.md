## HamlLint/ConsecutiveComments

Option            | Description
------------------|-------------------------------------------------------------
`max_consecutive` | Maximum number of consecutive comments allowed before warning (default `1`)

Consecutive comments should be condensed into a single multiline comment.

**Bad**
```haml
-# A collection
-# of many
-# consecutive comments
```

**Good**
```haml
-#
  A multiline comment
  is much more clean
  and concise
```