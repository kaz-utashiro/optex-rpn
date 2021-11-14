# NAME

rpn - Reverse Polish Notation calculation

# SYNOPSIS

    optex -Mrpn command ...

# DESCRIPTION

**rpn** is a filter module for **optex** command which detect command
arguments which look like Reverse Polish Notation, and replace it by
the result of calculation.

See [Math::RPN](https://metacpan.org/pod/Math::RPN) for Reverse Polish Noatation detail.

# EXAMPLE

Prevent macOS to suspend for 5 hours.

    $ optex -Mrpn caffeinate -d -t '3600,5,*'

# INSTALL

cpanm https://github.com/kaz-utashiro/optex-rpn.git

# SEE ALSO

[App::optex](https://metacpan.org/pod/App::optex), [https://github.com/kaz-utashiro/optex](https://github.com/kaz-utashiro/optex)

[App::optex::rpn](https://metacpan.org/pod/App::optex::rpn), [https://github.com/kaz-utashiro/optex-rpn](https://github.com/kaz-utashiro/optex-rpn)

[https://qiita.com/kaz-utashiro/items/2df8c7fbd2fcb880cee6](https://qiita.com/kaz-utashiro/items/2df8c7fbd2fcb880cee6)

[Math::RPN](https://metacpan.org/pod/Math::RPN)

# AUTHOR

Kazumasa Utashiro

# LICENSE

Copyright 2021 Kazumasa Utashiro.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
