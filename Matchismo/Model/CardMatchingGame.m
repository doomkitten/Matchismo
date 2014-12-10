//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Alaina Jones on 11/18/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic, readwrite) NSString *gameState;

@end


@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (!card){
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2



- (Card *)cardAtIndex:(NSUInteger)index{
    return (index < self.cards.count) ? self.cards[index] : nil;
}


- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if (!card.isChosen){
            int matchScore = [self scoreChosenCardsAgainstCard:card];
            self.score += matchScore;
        }
        self.score -= FLIP_COST;
        card.chosen = !card.isChosen;
    }

}



- (int) scoreChosenCardsAgainstCard:(Card *) card{
    
    int matchscore = 0;
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];

    self.gameState = card.contents;

    for (Card *otherCard in self.cards){
        if (otherCard.isChosen && !otherCard.isMatched) {
            [chosenCards addObject:otherCard];
            self.gameState = [self.gameState stringByAppendingString:otherCard.contents];
        }
    }
    
    if ([chosenCards count] == self.numberOfCardsToMatch-1){
        matchscore = [card match:chosenCards]*MATCH_BONUS;
        if (matchscore) {
            for (Card *otherCard in chosenCards){
                otherCard.matched = YES;
            }
            card.matched = YES;
            self.gameState = [self.gameState stringByAppendingString:[NSString stringWithFormat:@" match for %d points!",matchscore]];
        }else{
            for (Card *otherCard in chosenCards){
                otherCard.chosen = NO;
            }
            matchscore -= MISMATCH_PENALTY;
            self.gameState = [self.gameState stringByAppendingString:[NSString stringWithFormat:@" mismatch! %d penalty!",matchscore]];
        }
    }else {
        self.gameState = [@"Flipped up " stringByAppendingString:card.contents];
    }
    return matchscore;
}

@end

