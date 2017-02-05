## HamlLint/ObjectReferenceAttributes

Don't use the
[object reference syntax](http://haml.info/docs/yardoc/file.REFERENCE.html#object_reference_)
to set the class/id of an element.

**Bad**
```haml
%li[@user]
  = @user.name
```

**Good**
```haml
%li.user{ id: "user_#{@user.id}" }
  = @user.name
```

The object reference syntax is a bit magical, and makes it difficult to find
where in your code a particular class attribute is defined. It is also tied
directly to the class names of the objects you pass to it, creating an
unnecessary coupling which can make refactoring your models affect your
views.