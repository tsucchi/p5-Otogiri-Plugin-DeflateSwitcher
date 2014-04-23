
# NAME

Otogiri::Plugin::DeflateSwitcher - Otogiri plugin to enable/disable deflate

# SYNOPSIS

    use Otogiri;
    use Otogiri::Plugin::DeflateSwitcher;
    my $db = Otogiri->new($connect_info);
    $db->disable_deflate;
    my $row = $db->single(...); # deflate is disabled
    $db->enable_deflate;
    $row = $db->single(...); # deflate is enabled

# DESCRIPTION

Otogiri::Plugin::DeflateSwitcher is plugin for [Otogiri](https://metacpan.org/pod/Otogiri) to enable or disable deflate feature

# LICENSE

Copyright (C) Takuya Tsuchida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Takuya Tsuchida <tsucchi@cpan.org>
