[![Build Status](https://travis-ci.org/tsucchi/p5-Otogiri-Plugin-DeflateSwitcher.png?branch=master)](https://travis-ci.org/tsucchi/p5-Otogiri-Plugin-DeflateSwitcher) [![Coverage Status](https://coveralls.io/repos/tsucchi/p5-Otogiri-Plugin-DeflateSwitcher/badge.png?branch=master)](https://coveralls.io/r/tsucchi/p5-Otogiri-Plugin-DeflateSwitcher?branch=master)
# NAME

Otogiri::Plugin::DeflateSwitcher - Otogiri plugin to enable/disable deflate

# SYNOPSIS

    use Otogiri;
    use Otogiri::Plugin::DeflateSwitcher;
    my $db = Otogiri->new($connect_info);
    $db->disable_deflate;
    my $row = $db->insert(...); # deflate is disabled
    $db->enable_deflate;
    $row = $db->insert(...); # deflate is enabled
    # using guard
    my $guard1 = $db->enable_deflate;
    {
        my $guard2 = $db->disable_deflate;
        # deflate is disabled
    } #dismiss $guard2
    # deflate is enabled again

# DESCRIPTION

Otogiri::Plugin::DeflateSwitcher is plugin for [Otogiri](https://metacpan.org/pod/Otogiri) to enable or disable deflate feature

# LICENSE

Copyright (C) Takuya Tsuchida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Takuya Tsuchida <tsucchi@cpan.org>
