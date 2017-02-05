## HamlLint/TagName

Tag names should not contain uppercase letters.

**Bad**
```haml
%BODY
```

**Good**
```haml
%body
```

This is a _de facto_ standard in writing HAML documents as well as HTML in
general, as it is easier to type and matches the convention of many developer
tools. If you are writing HAML to output XML documents, however, it is a strict
requirement.