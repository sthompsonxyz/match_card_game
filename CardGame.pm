package CardGame;

use Moose;
use namespace::autoclean;

use Card;

#deck
has 'deck' => (
    is  => 'rw',
    isa => 'ArrayRef[Card]',
);

has 'no_of_decks' => (
    is  => 'rw',
    isa => 'Int',
);

##each player's cards
has 'player_1_cards' => (
    is  => 'rw',
    isa => 'ArrayRef[Card]',
);

has 'player_2_cards' => (
    is  => 'rw',
    isa => 'ArrayRef[Card]',
);

##pile of dealt cards
has 'pile' => (
    is  => 'rw',
    isa => 'ArrayRef[Card]',
);

##general game flags
has 'winner' => (
    is      => 'rw',
    isa     => 'Str',
    default => 'No one yet',
);

has 'round' => (
    is      => 'rw',
    isa     => 'Int',
    default => '0',
);

sub BUILD {
    my $self = shift;

    $self->build_multi_deck( $self->no_of_decks );
    $self->pile(           [] );
    $self->player_1_cards( [] );
    $self->player_2_cards( [] );
}

sub build_one_deck {
    my $self = shift;

    my @suits = ( 'Hearts', 'Diamonds', 'Clubs', 'Spades' );
    my @deck;

    for my $suit (@suits) {

        for ( 1 .. 13 ) {
            my $card = Card->new( suit => $suit, value => $_ );
            push @deck, $card;
        }
    }

    return @deck;

}

sub build_multi_deck {
    my $self            = shift;
    my $number_of_decks = shift;

    $number_of_decks ||= 1;

    my @multi_deck;

    while ( $number_of_decks-- > 0 ) {
        push @multi_deck, build_one_deck($number_of_decks);
    }

    $self->deck( \@multi_deck );
}

sub shuffle_deck {
    my $self = shift;

    use List::Util qw(shuffle);

    @{ $self->deck } = shuffle @{ $self->deck };
}

sub deal_one_card {
    my $self = shift;

    if ( @{ $self->deck } ) {
        push @{ $self->pile }, pop @{ $self->deck };
        return 1;
    }
    else {
        return 0;
    }
}

##show pile
sub show_pile {
    my $self   = shift;
    my $return = '';
    $return .= "Current pile:\n";
    foreach ( @{ $self->pile } ) {
        $return .= $_->face_name() . " of " . $_->suit . "  ";
    }
    $return .= "\n";

    return $return;
}

__PACKAGE__->meta->make_immutable;
