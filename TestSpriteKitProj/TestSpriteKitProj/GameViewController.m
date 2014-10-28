//
//  GameViewController.m
//  TestSpriteKitProj
//
//  Created by Artem on 10/26/14.
//  Copyright (c) 2014 Artem. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"


@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    SKView *skView = [[SKView alloc] initWithFrame:self.view.frame]; // почему такой маленький фрейм?
    self.view = skView;
    
    // Configure the view.
    skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene sceneWithSize:skView.frame.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
