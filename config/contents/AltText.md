## HamlLint/AltText

`img` tags should have an accompanying `alt` attribute containing alternate
text.

**Bad**
```haml
%img{ src: 'my-photo.jpg' }
```

**Good**
```haml
%img{ alt: 'Photo of me', src: 'my-photo.jpg' }
```

Include `alt` attributes is important for making your site more accessible.
See the
[W3C guidelines](http://www.w3.org/TR/2008/REC-WCAG20-20081211/#text-equiv-all)
for details.