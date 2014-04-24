package Otogiri::Plugin::DeflateSwitcher;
use 5.008005;
use strict;
use warnings;
use parent qw(Otogiri::Plugin);

use Scope::Guard;

our $VERSION = "0.01";

our @EXPORT = qw(enable_deflate disable_deflate);

sub enable_deflate {
    my ($self) = @_;

    my $current_status = $self->{deflate_enable};
    $self->{deflate_enable} = 1;
    if ( defined $self->{deflate_backup} ) {
        $self->{deflate} = delete $self->{deflate_backup};
    }
    if ( defined wantarray() ) {
        return Scope::Guard->new( sub { $current_status ? $self->enable_deflate : $self->disable_deflate } );
    }

}

sub disable_deflate {
    my ($self) = @_;

    my $current_status = $self->{deflate_enable};
    $self->{deflate_enable} = 0;
    if ( defined $self->{deflate} ) {
        $self->{deflate_backup} = delete $self->{deflate};
    }
    if ( defined wantarray() ) {
        return Scope::Guard->new( sub { $current_status ? $self->enable_deflate : $self->disable_deflate } );
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



=head1 DESCRIPTION

Otogiri::Plugin::DeflateSwitcher is plugin for L<Otogiri> to enable or disable deflate feature

=head1 LICENSE

Copyright (C) Takuya Tsuchida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Takuya Tsuchida E<lt>tsucchi@cpan.orgE<gt>

=cut

