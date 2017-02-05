## HamlLint/EmptyObjectReference

Empty object references are no-ops and can safely be removed.

**Bad**
```haml
%tag[]
```

**Good**
```haml
%tag
```

These serve no purpose and are usually left behind by mistake.