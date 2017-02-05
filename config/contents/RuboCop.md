## HamlLint/RuboCop

Option         | Description
---------------|--------------------------------------------
`ignored_cops` | Array of RuboCop cops to ignore.

This linter integrates with [RuboCop](https://github.com/bbatsov/rubocop)
(a static code analyzer and style enforcer) to check the actual Ruby code in
your templates. It will respect any RuboCop-specific configuration you have
set in `.rubocop.yml` files, but will explicitly ignore some checks that
don't make sense in the context of HAML documents (like
`Style/BlockAlignment`).

```haml
-# example.haml
- name = 'James Brown'
- unused_variable = 42

%p Hello #{name}!
```

**Output from `haml-lint`**
```
example.haml:3 [W] Useless assignment to variable - unused_variable
```

You can customize which RuboCop warnings you want to ignore by modifying
the `ignored_cops` option (see [`config/default.yml`](/config/default.yml)
for the full list of ignored cops).

You can also explicitly set which RuboCop configuration to use via the
`HAML_LINT_RUBOCOP_CONF` environment variable. This is intended to be used
by external tools which run the linter on files in temporary directories
separate from the directory where the HAML template originally resided (and
thus where the normal `.rubocop.yml` would be picked up).

### Displaying Cop Names

You can display the name of the cop by adding the following to your
`.rubocop.yml` configuration:

```yaml
AllCops:
  DisplayCopNames: true
```