## HamlLint/UnnecessaryInterpolation

Avoid using unnecessary interpolation for inline tag content.

**Bad**
```haml
%tag #{expression}
```

**Good: more concise**
```haml
%tag= expression
```