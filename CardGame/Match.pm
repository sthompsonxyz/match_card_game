package CardGame::Match;

use Card;
use Math::Round 'round';
use Moose;
use namespace::autoclean;

extends 'CardGame';

sub play {
    my $self       = shift;
    my $match_type = shift;

    # Remember previous card
    my $last_card;

    # While deck has cards, deal from top of deck
    while ( $self->deal_one_card ) {

        $self->round( $self->round + 1 );
        my $current_card = $self->pile->[-1];

        # If two matching are played sequentially then random player takes the
        # dealt cards and adds to their own hand.
        if ( $last_card
            && ( _match( $current_card, $last_card, $match_type ) ) )
        {
            print "Round: " . $self->round . "\n";
            print $last_card->face_name . " of "
                . $last_card->suit
                . " matches ";
            print $current_card->face_name . " of "
                . $current_card->suit . "\n";

            if ( round(rand) == 1 ) {
                push @{ $self->player_1_cards }, @{ $self->pile };
                @{ $self->pile } = ();
            }
            else {
                push @{ $self->player_2_cards }, @{ $self->pile };
                @{ $self->pile } = ();
            }

            # Reset previous card
            $last_card = 0;

        }
        else {
            $last_card = $current_card;
        }
    }

}

sub _match {
    my $card_1     = shift;
    my $card_2     = shift;
    my $match_type = shift;

    if ( $match_type == 1 ) {
        if ( $card_1->value eq $card_2->value ) {
            return 1;
        }
        else {
            return 0;
        }
    }
    elsif ( $match_type == 2 ) {
        if ( $card_1->suit eq $card_2->suit ) {
            return 1;
        }
        else {
            return 0;
        }

    }
    else {
        if (   ( $card_1->value eq $card_2->value )
            && ( $card_1->suit eq $card_2->suit ) )
        {
            return 1;
        }
        else {
            return 0;
        }

    }
}

sub determine_winner {
    my $self = shift;

    if (scalar @{ $self->player_1_cards }
        > scalar @{ $self->player_2_cards } )
    {
        $self->winner('Player 1 won!');
    }
    elsif (
        scalar @{ $self->player_1_cards }
        < scalar @{ $self->player_2_cards } )
    {
        $self->winner('Player 2 won!');
    }
    else {
        $self->winner("It\'s a Draw!");
    }
}

__PACKAGE__->meta->make_immutable;

