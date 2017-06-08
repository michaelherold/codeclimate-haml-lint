## HamlLint/UnnecessaryStringOutput

Avoid outputting string expressions in Ruby when static text will suffice.

**Bad**
```haml
%tag= "Some #{interpolated} string"
```

**Good: more concise**
```haml
%tag Some #{interpolated} string
```

HAML gracefully handles string interpolation in static text, so you don't need
to work with Ruby strings in order to use interpolation.