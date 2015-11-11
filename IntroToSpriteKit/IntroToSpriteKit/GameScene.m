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

@property (nonatomic) SKAction *wakka;

// ADDED: This keeps track of the walls so we can delete them on ending the game
@property (nonatomic) NSMutableArray *walls;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    
    self.physicsWorld.gravity = CGVectorMake(0.0,-2);
    self.physicsWorld.contactDelegate = self;
    
    self.wakka = [SKAction playSoundFileNamed:@"wakka.mp3" waitForCompletion:NO];
    
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
    
    // ADDED: Create an empty array for our walls
    self.walls = [NSMutableArray array];
    
    self.pacMan = [SKSpriteNode spriteNodeWithImageNamed:@"PacmanFrame2"];
    self.pacMan.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:self.pacMan];
    
    self.pacMan.physicsBody =
        [SKPhysicsBody bodyWithCircleOfRadius:self.pacMan.size.width/2];
    self.pacMan.physicsBody.mass = 1.0;
    self.pacMan.physicsBody.collisionBitMask = 0;
    self.pacMan.physicsBody.contactTestBitMask = kWallCategory | kBorderCategory;
    
    SKAction *addWall = [SKAction runBlock:^{
        [self addWall];
    }];
    SKAction *pause = [SKAction waitForDuration:5];
    
    SKAction *addAndPause = [SKAction group:@[addWall,pause]];
    [self runAction:[SKAction repeatActionForever:addAndPause] withKey:@"wallKey"];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    if(contact.bodyA.categoryBitMask == kWallCategory){
        [self endGame];
    } else {
        self.score++;
    }
}

-(void) endGame {
    self.startLabel.hidden = NO;
    [self removeActionForKey:@"wallKey"];
    [self.pacMan removeFromParent];
    self.pacMan = nil;
    
    // ADDED: Remove all of the walls from this game
    for (SKSpriteNode *wall in self.walls) {
        [wall removeFromParent];
    }
    
    // ADDED: Reset the score
    self.score = 0;
}

const int kWallCategory = 1;
const int kBorderCategory = 2;

- (void) addWall {
    
    CGFloat separation = self.pacMan.size.height * 2;
    
    SKSpriteNode *bottomWall = [SKSpriteNode spriteNodeWithImageNamed:@"Wall"];
    bottomWall.position = CGPointMake(0,-bottomWall.size.height/2 - separation/2);
    
    bottomWall.physicsBody = [SKPhysicsBody bodyWithTexture:bottomWall.texture size:bottomWall.size];
    bottomWall.physicsBody.affectedByGravity = NO;
    bottomWall.physicsBody.dynamic = NO;
    bottomWall.physicsBody.categoryBitMask = kWallCategory;
    
    SKSpriteNode *topWall = [SKSpriteNode spriteNodeWithImageNamed:@"Wall"];
    topWall.position = CGPointMake(0,topWall.size.height/2 + separation/2);
    topWall.yScale = -1;
    
    topWall.physicsBody = [SKPhysicsBody bodyWithTexture:topWall.texture size:topWall.size];
    topWall.physicsBody.affectedByGravity = NO;
    topWall.physicsBody.dynamic = NO;
    topWall.physicsBody.categoryBitMask = kWallCategory;
    
    SKSpriteNode *scoreLine = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(1,CGRectGetHeight(self.frame))];
    scoreLine.position = CGPointMake(topWall.size.width/2,0);
    scoreLine.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:scoreLine.size];
    scoreLine.physicsBody.categoryBitMask = kBorderCategory;
    scoreLine.physicsBody.affectedByGravity = NO;
    scoreLine.physicsBody.dynamic = NO;
    
    SKSpriteNode *wall = [SKSpriteNode node];
    wall.position = CGPointMake(CGRectGetWidth(self.frame),CGRectGetMidY(self.frame));
    [self addChild:wall];
    
    [wall addChild:scoreLine];
    [wall addChild:bottomWall];
    [wall addChild:topWall];
    
    // ADDED: Put this wall in our walls array so we can remove it later
    [self.walls addObject:wall];
    
    SKAction *moveWall = [SKAction moveByX:-10 y:0 duration:0.1];
    [wall runAction:[SKAction repeatActionForever:moveWall]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(self.pacMan == nil){
        [self startGame];
        return;
    }

    SKTexture *frame1 = [SKTexture textureWithImageNamed:@"PacmanFrame1"];
    SKTexture *frame2 = [SKTexture textureWithImageNamed:@"PacmanFrame2"];
    SKTexture *frame3 = [SKTexture textureWithImageNamed:@"PacmanFrame3"];
    SKAction *animation = [SKAction animateWithTextures:@[frame1,frame2,frame3,frame2] timePerFrame:0.1];
    [self.pacMan runAction:animation];
    
    [self runAction:self.wakka];
    
    [self.pacMan.physicsBody applyImpulse:CGVectorMake(0.0,-self.pacMan.physicsBody.velocity.dy + 150)];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void) setScore:(NSInteger)score {
    _score = score;
    [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %lu", score]];
}

@end
