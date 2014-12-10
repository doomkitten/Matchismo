//
//  PlayingCard.m
//  Matchismo
//
//  Created by Alaina Jones on 10/24/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    return [self match:otherCards against:self];
}

- (int)match:(NSArray *) otherCards against:(Card *)card{
    int score = 0;
    if ([otherCards count] == 0)
        return score;
    else {
        for (PlayingCard *card in otherCards)
        {
            if (card.rank == self.rank){
                score = score + 4;
            }else if (card.suit == self.suit){
                score = score + 1;
            }
        }
        return score + [otherCards[0] match:[otherCards subarrayWithRange:NSMakeRange(1, otherCards.count-1)]];
    }
}
- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

-(void)setSuit: (NSString *) suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
        _suit = suit;
}

+ (NSArray *)validSuits
{
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}
+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"J", @"Q", @"K"];
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank { return [[self rankStrings] count]-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
} }

@end

