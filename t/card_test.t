#!/usr/bin/perl

use warnings;
use strict;

use Test::More;

use_ok('Card');
use_ok('CardGame');
use_ok('CardGame::Match');

my $testcard = Card->new( 'suit' => 'hearts', 'value' => '1' );

ok( $testcard->suit eq 'hearts',   "suit OK" );
ok( $testcard->value eq '1',       "value OK" );
ok( $testcard->face_name eq 'Ace', "face OK" );

my $testcardgame = CardGame::Match->new();

isa_ok( $testcardgame, 'CardGame' );

my $number_of_decks = 4;
$testcardgame->build_multi_deck($number_of_decks);

my $preshuffle = $testcardgame->deck;
$testcardgame->shuffle_deck;

is_deeply(
    [ sort @{ $testcardgame->deck } ],
    [ sort @{$preshuffle} ],
    "deck survived shuffling!"
);

ok( $testcardgame->winner eq 'No one yet', "winner not yet determined" );
$testcardgame->play(2);

ok( ( $testcardgame->round / 52 ) == $number_of_decks,
    "Right number of cards played" );
ok( $testcardgame->winner eq 'No one yet',
    "winner still not yet determined" );
$testcardgame->determine_winner;

ok( $testcardgame->winner ne 'No one yet', "winner now determined" );
done_testing();
