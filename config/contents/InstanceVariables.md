## HamlLint/InstanceVariables

Checks that instance variables are not used in the specified type of files.

Option          | Description
----------------|-------------------------------------------------------------
`file_types`    | The class of files to lint (default `partial`)
`matchers`      | The regular expressions to check file names against.

By default, this linter only runs on Rails-style partial views, e.g. files that
have a base name starting with a leading underscore `_`. If you want to ensure
that you don't use any instance variables at all, you can set `file_types` to
`all`.

You can also define your own matchers if you want to enable this linter on
a different subset of your views. For instance, if you want to lint only files
starting with `special_`, you can define the configuration as follows:

```yaml
InstanceVariables:
  enabled: true
  file_types: special
  matchers:
    special: ^special_.*\.haml$
```

To avoid using instance variables in partials, ensure you are passing any needed
variables as local variables. Alternatively, you can use only helper methods to
place data in your views.