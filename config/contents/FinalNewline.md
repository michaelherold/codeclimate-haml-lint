## HamlLint/FinalNewline

Files should always have a final newline. This results in better diffs when
adding lines to the file, since SCM systems such as `git` won't think that you
touched the last line if you append to the end of a file.

You can customize whether or not a final newline exists with the `present`
option.

Configuration Option | Description
---------------------|---------------------------------------------------------
`present`            | Whether a final newline should be present (default `true`)