//
//  GameScene.m
//  IntroToSpriteKit
//
//  Created by Thomas Elliott on 11/7/15.
//  Copyright (c) 2015 Tom Elliott. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

@property (nonatomic) SKLabelNode *startLabel;
@property (nonatomic) SKLabelNode *scoreLabel;

@property (nonatomic) NSInteger score;

@property (nonatomic) SKSpriteNode *pacMan;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    
    self.startLabel = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    self.startLabel.text = @"Tap to start";
    self.startLabel.fontSize = 45;
    self.startLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:self.startLabel];

    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    self.scoreLabel.text = @"Score: 0";
    self.scoreLabel.fontSize = 24;
    self.scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    self.scoreLabel.position = CGPointMake(20,
                                           CGRectGetHeight(self.frame) - 50);
    [self addChild:self.scoreLabel];

}

- (void) startGame {
    self.startLabel.hidden = YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(self.pacMan == nil){
        [self startGame];
        return;
    }

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void) setScore:(NSInteger)score {
    _score = score;
    [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %lu", score]];
}

@end
