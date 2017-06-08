## HamlLint/Indentation

Check that spaces are used for indentation instead of hard tabs.

Option          | Description
----------------|-------------------------------------------------------------
`character`     | Character to use for indentation. `space` or `tab` (default `space`)
`width`         | Number of spaces to use for `space` indentation. (default 2)

**Bad: indentation is 1 space**
```haml
%button
 Hit me
```

**Bad: indentation is 4 spaces**
```haml
%button
    Hit me
```

**Good: indentation is 2 spaces**
```haml
%button
  Hit me
```

**Note:** `width` is ignored when `character` is set to `tab`.