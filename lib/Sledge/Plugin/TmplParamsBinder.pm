package Sledge::Plugin::TmplParamsBinder;
use strict;
use warnings;
our $VERSION = '0.01';

use PadWalker qw//;

{
    package Sledge::Template;

    sub bind {
        my $self = shift;

        my %hash;
        my $h = PadWalker::peek_my(1);
        while (my ($key, $val) = each %$h) {
            next if $key eq '$self';

            $key =~ s/[\$\@\%]//;

            if (ref $val eq 'SCALAR' || ref $val eq 'REF') {
                 # scalarref, arrayref, hashref
                 $hash{$key} = $$val;
            } else {
                 $hash{$key} = $val;
            }
        }
        $self->param(%hash);
    }
}

1;
__END__

=head1 NAME

Sledge::Plugin::TmplParamsBinder - bind dispatcher's lexical variables to template

=head1 SYNOPSIS

    package Your::Pages;
    use Sledge::Plugin::TmplParamsBinder;
    sub dispatch_foo {
        my $self = shift;
        my $scalar    = 'blah blah';
        my $array_ref = [qw(1 2 3)];
        my $hash_ref  = {a => 'b'};
        my @array     = qw(a b c);
        my %hash      = (aa => 11, bb => 12);
        $self->tmpl->bind;
    }

    # This code is equivalent to:
    sub dispatch_foo {
        my $self = shift;
        $self->tmpl->param(
            scalar    => 'blah blah',
            array_ref => [qw(1 2 3)],
            hash_ref  => {a => 'b'},
            array     => [qw(a b c)],
            hash      => {aa => 11, bb => 12},
        );
    }

=head1 DESCRIPTION

Sledge::Plugin::TmplParamsBinder binds lexical variables to template parameter.

=head1 AUTHOR

MATSUNO Tokuhiro E<lt>tokuhiro at mobilefactory.jpE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<PadWalker>, L<Catalyst::Controller::BindLex>

=cut

