# Code Climate Haml-Lint Engine

[![Build Status](https://travis-ci.org/michaelherold/codeclimate-haml_lint.svg)][travis]
[![Code Climate](https://codeclimate.com/github/michaelherold/codeclimate-haml_lint/badges/gpa.svg)][codeclimate]
[![Inline docs](http://inch-ci.org/github/michaelherold/codeclimate-haml_lint.svg?branch=master)][inch]

[codeclimate]: https://codeclimate.com/github/michaelherold/codeclimate-haml_lint
[inch]: http://inch-ci.org/github/michaelherold/codeclimate-haml_lint
[travis]: https://travis-ci.org/michaelherold/codeclimate-haml_lint

Have you ever wanted to know exactly how good you are at writing consistent Haml? Well look no more! By using this Code Climate engine, you can harness the power of [Haml-Lint] to score your code.

[Haml-Lint]: https://github.com/brigade/haml-lint

## Want to Help?

Awesome! We strive to be welcoming to everyone. Check out the [contributing guide] and make sure to read our [code of conduct].

[contributing guide]: https://github.com/michaelherold/codeclimate-haml_lint/blob/master/CONTRIBUTING.md
[code of conduct]: https://github.com/michaelherold/codeclimate-haml_lint/blob/master/CODE_OF_CONDUCT.md

## Need Some Help?

For help with Haml-Lint, [check out their documentation].

If you're running into a Code Climate issue, first check out our [engine documentation][#usage] and look over any existing [issues][issues], as your question may have already been covered. If not, please [open an issue][open-issue] and we'll see what we can do to help.

[check out their documentation]: https://github.com/brigade/haml-lint
[issues]: https://github.com/michaelherold/codeclimate-haml_lint/issues
[open-issue]: https://github.com/michaelherold/codeclimate-haml_lint/issues/new

## Installation

Since this isn't a publicly released engine yet, you will have to build the engine from this repository. You will need the Code Climate CLI installed, as well as the `git` and `make` commands.

1. If you haven't already, [install the Code Climate CLI].
2. If you do not have Git, install it.
3. If you do not have `make`, install it. On a Mac, you can get it with XCode. On Linux, you can get it in your package manager (the `build-essential` package in Ubuntu or `base-devel` package on Arch linux). On Windows, you probably need Cygwin or the Linux Subsystem for Windows.
4. Make the engine's Docker container with `make`.

If the container fails to build, [file an issue][open-issue].

You should now be able to use the engine through the Code Climate CLI as
a development-level engine. To use it on your project, first navigate to your
project's directory. Then use the following command:

    $ codeclimate analyze -e haml_lint --dev

[install the Code Climate CLI]: https://github.com/codeclimate/codeclimate

## Usage

Like other Code Climate engines, you configure this one through the use of a `.codeclimate.yml` file in your project's root directory. If you don't already have one, you can use the `codeclimate engines:enable haml_lint` command to generate a basic `.codeclimate.yml` file with the engine enabled.

If you don't care to tweak your configuration, you should now be able to run the engine with the analyze command:

    $ codeclimate analyze

To tweak the linters that Haml-Lint will run, follow this pattern in the configuration file:

```yaml
engines:
  haml_lint:
    enabled: true
    config:
      file: my_custom_haml_lint.yml
    checks:
      HamlLint/AltText:
        enabled: false
      HamlLint/RuboCop:
        include:
          - lib/project_name/**/*.rb
        exclude:
          - spec/**/*.rb
exclude_paths:
  - ignored_directory/
```

Most of the configuration lives under the `engines.haml_lint` key. The options are as follows:

* `config.file` - The Haml-Lint configuration file you want to use as a base.
* `checks.<LINTER_NAME>` - Configuration for the linter given by `<LINTER_NAME>`. You can pass any of the configuration options for the linter in the base Haml-Lint format. See [the Haml-Lint documentation] for more information.
* Global configuration like `exclude_paths` is also included in the engine's configuration. See the [Code Climate documentation] for more information.

[the Haml-Lint documentation]: https://github.com/brigade/haml-lint#configuration
[Code Climate documentation]: https://docs.codeclimate.com/docs/configuring-your-code-climate-analysis

## Versioning

This engine is versioned based on the versioning scheme of Haml-Lint. It uses
the version of the Haml-Lint gem that is installed as the base version and then
adds a build number. For example, the first time the engine is built and
released for the `0.23.1` version of HamlLint, the engine's version is
`0.23.1-1`. If there are any bugs that are fixed in the engine without updating
the Haml-Lint version, the build number will be incremented (e.g. to
`0.23.1-2`).

## License

The gem is available as open source under the terms of the [MIT License][license].

[license]: http://opensource.org/licenses/MIT.
