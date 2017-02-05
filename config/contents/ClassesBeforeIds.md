## HamlLint/ClassesBeforeIds

Whether classes or ID attributes should be listed first in tags.

### EnforcedStyle: 'class' (default)

**Bad: ID before class**
```haml
%tag#id.class
```

**Good**
```haml
%tag.class#id
```

These attributes should be listed in order of their specificity. Since the tag
name (if specified) always comes first and has the lowest specificity, classes
and then IDs should follow.

### EnforcedStyle: 'id'

**Bad: Class before ID**
```haml
%tag.class#id
```

**Good**
```haml
%tag#id.class
```

As IDs are more significant than classes to the element they represent, IDs
should be listed first and then classes should follow. This gives a more
consistent vertical alignment of IDs.