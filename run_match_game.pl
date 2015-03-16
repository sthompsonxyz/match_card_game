#!/usr/bin/perl

use strict;
use warnings;

use aliased 'CardGame::Match';

#use Match;
use Carp;
use List::Util 'any';

# Match Card Game

# Ask:
# 1 how many decks
print "A game of matching cards; how many decks to use?\n:";

my $decks = <>;
chomp $decks;

# 2 which match condition: i) face value, ii) suit, iii) both
print "Please select the match condition:\n
 		\t1) Face value match.\n
		\t2) Suit match\n
		\t3) Both must match\n:";

my $match_type = <>;
chomp $match_type;

# Must be valid match type
my @options = ( 1, 2, 3 );
croak "needs to be match condition 1, 2 or 3!"
    unless any { $_ == $match_type } @options;

# Create card game object and build "multi deck"
my $match_game = Match->new();
$match_game->build_multi_deck($decks);

# shuffle cards
$match_game->shuffle_deck;

# Run main game logic!
$match_game->play($match_type);

# Any remaining dealt cards ignored
# winner has most cards
$match_game->determine_winner;

print "Player 1\'s cards: " . scalar @{ $match_game->player_1_cards } . "\n";
print "Player 2\'s cards: " . scalar @{ $match_game->player_2_cards } . "\n";
print "Cards still on pile: " . scalar @{ $match_game->pile } . "\n";
print "Total cards played: " . $match_game->round . "\n";
print $match_game->winner() . "\n";

