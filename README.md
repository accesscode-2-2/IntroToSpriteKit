# Introduction to SpriteKit

## Key Concepts

* Scenes (SKScene)
* Nodes (SKSpriteNode)
* Actions (SKAction)
* Physics (SKPhysicsBody, SKPhysicsContact)

## Objectives

> A challenger has appeared!

* Get comfortable with the basic concepts of SpriteKit
* Start building a simple game

## Starter Project

> It's dangerous to go alone, take this

Open **IntroToSpriteKit/IntroToSpriteKit.xcodeproj**

This project contains skeleton code for the following steps along with all the necessary image and audio resources.

**Important:** Before moving on, add the following to the `GameViewController`'s `viewDidLoad` method:

    scene.size = skView.frame.size;

This will make sure that the size of the scene matches the size of the view, and makes placement of sprites much simpler.

## Sprites

### Add a Pacman Sprite

> Reticulating splines

On a tap, add a Pacman sprite to the center of the screen. Use *PacmanFrame2* as the default texture.

## Actions

### Animate Pacman on a tap

> Wakka wakka

On the next tap run an action to animate the Pacman sprite through *PacmanFrame1*, *PacmanFrame2*, and *PacmanFrame3*. Finish on frame 2.

Play the audio *wakka.mp3* along with the animation.

### Add moving walls

> Get over here!

Add an action to create a wall every 5 seconds. A wall will consist of an upper and lower section.

Each wall will perform a regular action to move it to the left.

## Physics

### Add physics for gravity and "flapping"

> Do a barrel roll

Add a physics body to the Pacman sprite. Add mass and set the gravity for the scene to -2.

Apply an impulse to Pacman on a tap, which will give the sprite upward velocity.

### Handle collisions with walls

> C-c-c-combo breaker!

Make GameScene the contact delegate for its physics world.

Set categories on wall segments and a contact bit mask on the Pacman sprite.

Implement `didBeginContact:` to end the current game on any collision between Pacman and a wall.

### Implement Scoring

> It's super effective!

The score label and setter are already implemented, so all you need to do to change the score is update `self.score`.

Add a clear sprite to the combined wall sprite to mark the end of wall boundary.

Set the boundary's category and apply to Pacman's contact mask.

Add a check to `didBeginContact:` to distinguish between a wall and the boundary and increment the score when the boundary is hit.

## Extra Challenges

> Thank you, Mario! But our princess is in another castle

1. Add a "high score" label to show the user's best score so far
2. Randomize the spacing of walls and the height of the gap.
4. Experiment with changing gravity and other values to make the game more or less difficult.
4. Add extra sounds for scoring and the end of the game (included are *pacman_eatfruit.wav* and *pacman_death.wav*).
5. Add a boundary to the game world to end the game if Pacman goes off the bottom of the screen