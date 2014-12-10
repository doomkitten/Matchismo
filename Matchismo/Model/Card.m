//
//  Card.m
//  Matchismo
//
//  Created by Alaina Jones on 10/24/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards){
        if ([card.contents isEqualToString:self.contents]){
            score++;
        }
    }
    return score;
}

@end
