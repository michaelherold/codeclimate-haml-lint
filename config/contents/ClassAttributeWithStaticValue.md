## HamlLint/ClassAttributeWithStaticValue

Prefer static class attributes over hash attributes with static values.

**Bad**
```haml
%tag{ class: 'my-class' }
```

**Good**
```haml
%tag.my-class
```

Unless you are assigning a dynamic value to the class attribute, it is terser
to use the inline tag syntax to specify the class(es) an element should be
assigned.