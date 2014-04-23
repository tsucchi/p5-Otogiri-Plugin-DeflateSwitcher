package Otogiri::Plugin::DeflateSwitcher;
use 5.008005;
use strict;
use warnings;
use parent qw(Otogiri::Plugin);

our $VERSION = "0.01";

our @EXPORT = qw(enable_deflate disable_deflate);

sub enable_deflate {
    my ($self) = @_;
    return if ( !defined $self->{deflate_backup} || defined $self->{deflate} );

    $self->{deflate} = delete $self->{deflate_backup};
}

sub disable_deflate {
    my ($self) = @_;
    if ( defined $self->{deflate} ) {
        $self->{deflate_backup} = delete $self->{deflate};
    }
}


1;
__END__

=encoding utf-8

=head1 NAME

Otogiri::Plugin::DeflateSwitcher - Otogiri plugin to enable/disable deflate

=head1 SYNOPSIS

    use Otogiri;
    use Otogiri::Plugin::DeflateSwitcher;
    my $db = Otogiri->new($connect_info);
    $db->disable_deflate;
    my $row = $db->single(...); # deflate is disabled
    $db->enable_deflate;
    $row = $db->single(...); # deflate is enabled

=head1 DESCRIPTION

Otogiri::Plugin::DeflateSwitcher is plugin for L<Otogiri> to enable or disable deflate feature

=head1 LICENSE

Copyright (C) Takuya Tsuchida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Takuya Tsuchida E<lt>tsucchi@cpan.orgE<gt>

=cut

