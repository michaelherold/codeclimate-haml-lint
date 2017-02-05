## HamlLint/MultilineScript

Don't span Ruby script over multiple lines using operators.

**Bad**
```haml
- if condition ||
-    other_condition
  Display something!
```

**Good**
```haml
- if condition || other_condition
  Display something!
```

While writing code this way may sometimes work, it is actually a result of a
quirk in how HAML generates code from a template. While the following code
will compile and run:

```haml
- if condition ||
-    other_condition
  Display something!
```

...this code will fail with a parse error:

```haml
- if condition ||
-    other_condition
  Display something!
- else
  Otherwise display this!
```

Thus it's best to stay away from writing code this way.