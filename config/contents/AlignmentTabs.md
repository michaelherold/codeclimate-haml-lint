## HamlLint/AlignmentTabs

Don't use tabs for alignment within a tag.

**Bad**
```haml
%div
  %p		Hello, world
  %span	This is visually aligned with its sibling's content using tabs
```

**Acceptable, though not recommended**
```haml
%div
  %p    Hello, world
  %span This is visually aligned with its sibling's content using spaces
```

**Good**
```haml
%div
  %p Hello, world
  %span This does not worry about alignment of tag text
```