## HamlLint/SpaceInsideHashAttributes

Check the style of hash attributes against one of two possible preferred
styles, `space` (default) or `no_space`:

**Bad: inconsistent spacing inside hash attributes braces**
```haml
%tag{ foo: bar}
%tag{foo: bar }
%tag{  foo: bar }
```

**With default `space` style option: require a single space inside
hash attributes braces**
```haml
%tag{ foo: bar }
```

**With `no_space` style option: require no space inside
hash attributes braces**
```haml
%tag{foo: bar}
```

This offers the ability to ensure consistency of Haml hash
attributes style with ruby hash literal style (compare with
the Style/SpaceInsideHashLiteralBraces cop in Rubocop).