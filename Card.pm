package Card;

use Moose;
use namespace::autoclean;

# use enum?
has 'suit' => (
    is  => 'rw',
    isa => 'Str',
);

has 'value' => (
    is  => 'rw',
    isa => 'Int',
);

sub face_name {
    my $self = shift;

    my $faces = {
        '1'  => 'Ace',
        '2'  => '2',
        '3'  => '3',
        '4'  => '4',
        '5'  => '5',
        '6'  => '6',
        '7'  => '7',
        '8'  => '8',
        '9'  => '9',
        '10' => '10',
        '11' => 'Jack',
        '12' => 'Queen',
        '13' => 'King',
    };
    return $faces->{ $self->{'value'} };
}

__PACKAGE__->meta->make_immutable;

