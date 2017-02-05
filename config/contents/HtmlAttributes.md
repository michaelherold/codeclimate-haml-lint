## HamlLint/HtmlAttributes

Don't use the
[HTML-style attributes](http://haml.info/docs/yardoc/file.REFERENCE.html#htmlstyle_attributes_)
syntax to define attributes for an element.

**Bad**
```haml
%tag(lang=en)
```

**Good**
```haml
%tag{ lang: 'en' }
```

While the HTML-style attributes syntax can be terser, it introduces additional
complexity to your templates as there are now two different ways to define
attributes. Standardizing on when to use HTML-style versus hash-style adds
greater cognitive load when writing templates. Using one style makes this
easier.