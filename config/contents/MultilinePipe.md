## HamlLint/MultilinePipe

Don't span multiple lines using the multiline pipe (`|`) syntax.

**Bad**
```haml
%p= 'Some' + |
    'long' + |
    'string' |
```

**Good: use helpers to generate long dynamic strings**
```haml
%p= generate_long_string
```

**Good: split long method calls on commas**
```haml
%p= some_helper_method(some_value,
                       another_value,
                       yet_another_value)
```

**Good: split attribute definitions/hashes on commas**
```haml
%p{ data: { value: value,
            name: name } }
```

The multiline bar was
[made awkward intentionally](http://haml.info/docs/yardoc/file.REFERENCE.html#multiline).
`haml-lint` takes this a step further by discouraging its use entirely, as it
almost always suggests an unnecessarily complicated template that should have
its logic extracted into a helper.