## HamlLint/InlineStyles

Tags should not contain inline style attributes.

**Bad**
```haml
%p{ style: 'color: red;' }
```

**Good**
```haml
%p.warning
```

Exceptions may need to be made for dynamic content and email templates.

See [CodeAcademy](https://www.codecademy.com/articles/html-inline-styles) to
learn more.