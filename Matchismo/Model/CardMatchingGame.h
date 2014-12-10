//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Alaina Jones on 11/18/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) int score;
@property (nonatomic) int numberOfCardsToMatch;
@property (nonatomic, readonly) NSString *gameState;
@end
