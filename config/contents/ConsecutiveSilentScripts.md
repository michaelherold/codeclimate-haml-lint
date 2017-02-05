## HamlLint/ConsecutiveSilentScripts

Option            | Description
------------------|-------------------------------------------------------------
`max_consecutive` | Maximum number of consecutive scripts allowed before warning (default `2`)

Avoid writing multiple lines of Ruby using silent script markers (`-`).

**Bad**
```haml
- expression_one
- expression_two
- expression_three
```

**Better**
```haml
:ruby
  expression_one
  expression_two
  expression_three
```

In general, large blocks of Ruby code in HAML templates are a smell, and this
check serves to warn you of that. However, for the cases where having the code
inline can improve readability, you can signal your intention by using a
`:ruby` filter block instead.