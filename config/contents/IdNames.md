## HamlLint/IdNames

Check the naming conventions of id attributes against one of two possible
preferred styles, `lisp_case` (default), `camel_case`, `pascal_case`, or
`snake_case`:

**Bad: inconsistent id names**
```haml
#lisp-case
#camelCase
#PascalCase
#snake_case
```

**With default `lisp_case` style option: require ids in lisp-case-format**
```haml
#lisp-case
```

**With `camel_case` style option: require ids in camelCaseFormat**
```haml
#camelCase
```

**With `pascal_case` style option: require ids in PascalCaseFormat**
```haml
#PascalCase
```

**With `snake_case` style option: require ids in snake_case_format*
```haml
#snake_case
%div{ id: 'snake_case' }
```