//
//  BackGroundsLayer.m
//  NewMoonSkater
//
//  Created by Artem on 12/3/12.
//
//

#import "BackGroundsLayer.h"
//#import "GraphicController.h"
#import "PodBackGround.h"



@interface BackGroundsLayer() {
    NSArray *podBkGroundsArray;
}



@end




@implementation BackGroundsLayer

//@synthesize mainSprite = _mainSprite;
@synthesize velocity = _velocity;
@synthesize velocityKoef = _velocityKoef;
@synthesize acceleration = _acceleration;
@synthesize toVelocity = _toVelocity;
@synthesize isAcceleration = _isAcceleration;
@synthesize isChangeVelocity = _isChangeVelocity;
@synthesize startPosition = _startPosition;


#pragma mark - Life cycle
- (id)init {
	if (self = [super init]) {
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[[GraphicController sharedController] extendForCurrentDeviceName:@"GamePlayBacks.plist"]];
//        CGSize screenSize = [CCDirector sharedDirector].winSize;
        CGSize screenSize = CGSizeMake(320, 400);
      
        NSMutableArray *bkGroundSpritesArray;
        CCSprite *backGround;
        CGPoint bkVelocityKoef;
        
        // --- bk01
        bkGroundSpritesArray = [NSMutableArray array];
        
        backGround = [CCSprite spriteWithSpriteFrameName:@"sky_1.png"];
        backGround.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:backGround];
        [bkGroundSpritesArray addObject:backGround];
        
        backGround = [CCSprite spriteWithSpriteFrameName:@"sky_2.png"];
        backGround.position = ccp(screenSize.width + screenSize.width/2, screenSize.height/2);
        [self addChild:backGround];
        [bkGroundSpritesArray addObject:backGround];
        
        bkVelocityKoef = ccp(0.04, 1);
        PodBackGround *podBk01 = [[[PodBackGround alloc] initWithSpritesArray:bkGroundSpritesArray velocity:self.velocity velocityKoef:bkVelocityKoef] autorelease];
        
        // --- bk02
        CGFloat deltaMountBg = -5;
        bkGroundSpritesArray = [NSMutableArray array];
        
        backGround = [CCSprite spriteWithSpriteFrameName:@"mounts_1.png"];
        backGround.position = ccp(screenSize.width/2, screenSize.height/2 + deltaMountBg);
        [self addChild:backGround];
        [bkGroundSpritesArray addObject:backGround];
        
        backGround = [CCSprite spriteWithSpriteFrameName:@"mounts_2.png"];
        backGround.position = ccp(screenSize.width + screenSize.width/2, screenSize.height/2 + deltaMountBg);
        [self addChild:backGround];
        [bkGroundSpritesArray addObject:backGround];
        
        bkVelocityKoef = ccp(0.15, 1);
        PodBackGround *podBk02 = [[[PodBackGround alloc] initWithSpritesArray:bkGroundSpritesArray velocity:self.velocity velocityKoef:bkVelocityKoef] autorelease];
        
        // --- bk03
        bkGroundSpritesArray = [NSMutableArray array];
        
        backGround = [CCSprite spriteWithSpriteFrameName:@"earth.png"];
        backGround.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:backGround];
        [bkGroundSpritesArray addObject:backGround];
        
        backGround = [CCSprite spriteWithSpriteFrameName:@"earth.png"];
        backGround.position = ccp(screenSize.width + screenSize.width/2, screenSize.height/2);
        [self addChild:backGround];
        [bkGroundSpritesArray addObject:backGround];
        
        bkVelocityKoef = ccp(1, 1);
        PodBackGround *podBk03 = [[[PodBackGround alloc] initWithSpritesArray:bkGroundSpritesArray velocity:self.velocity velocityKoef:bkVelocityKoef] autorelease];
        
        // --- 
        podBkGroundsArray = [[NSArray alloc] initWithObjects:podBk01, podBk02, podBk03, nil];
	}
	return self;
}


#pragma mark - Setters
- (void)setVelocity:(CGPoint)velocity {
    _velocity = velocity;
    for (PodBackGround *curBkGround in podBkGroundsArray) {
        curBkGround.velocity = velocity;
    }
}


#pragma mark - MovableObjectsProtocol implementation
- (void)update:(ccTime)dt {
    for (PodBackGround *curBkGround in podBkGroundsArray) {
        [curBkGround update:dt];
    }
}

- (void)setupSpeed:(CGFloat)speed withAngle:(CGFloat)angle rotate:(BOOL)rotate {
    
}

-(void)setupSpeed:(CGFloat)speed withAngleToPoint:(CGPoint)point rotate:(BOOL)rotate {
    
}

- (void)changeVelocityTo:(CGPoint)newVelocityPixSec forTimeSec:(CGFloat)timeInSec {
    for (PodBackGround *curBkGround in podBkGroundsArray) {
        [curBkGround changeVelocityTo:newVelocityPixSec forTimeSec:timeInSec];
    }
}

@end
