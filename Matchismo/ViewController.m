//
//  ViewController.m
//  Matchismo
//
//  Created by Alaina Jones on 10/23/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameStateLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchNumberOfCardsToMatch;
@end

@implementation ViewController

-(CardMatchingGame *) game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                          usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (int)numberOfCardsToMatch{
    return [self.switchNumberOfCardsToMatch isOn] ? 3 : 2;
}



- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isChosen;
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.gameStateLabel.text = self.game.gameState;
}

- (IBAction)flipCard:(UIButton *)sender {
    self.game.numberOfCardsToMatch = [self numberOfCardsToMatch];
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    if (self.switchNumberOfCardsToMatch.enabled) self.switchNumberOfCardsToMatch.enabled = NO;
    [self updateUI];
}


- (IBAction)reDeal:(UIButton *)sender {
    self.game = nil;
    self.switchNumberOfCardsToMatch.enabled = YES;
    [self updateUI];
}




@end

