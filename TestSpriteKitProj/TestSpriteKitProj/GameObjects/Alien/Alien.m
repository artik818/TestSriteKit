//
//  Alien.m
//  NewMoonSkater
//
//  Created by Artem on 12/6/12.
//
//

#import "Alien.h"
#import "Constants.h"
#import "Skater.h"
#import "Bullet.h"
#import "Bang.h"
#import "EnergyMeter.h"


enum ActionTags {
    TAG_ACT_REGULAR_ANIMATION = 300,
};



@interface Alien() {
    NSMutableArray *animationFramesArray;
    BOOL isAnimatedNow;
    EnergyMeter *energyMeter;
    BOOL isLanded;
}

@property (nonatomic, retain) NSString *currentAlienPrefix;

@end




@implementation Alien

@synthesize currentAlienPrefix = _currentAlienPrefix;

#pragma mark - Life cycle
- (id)initWithObjType:(NSInteger)objType {
	if (self = [super initWithObjType:objType]) {
        _currentAlienPrefix = [[self getAlienPrefixByType:objType] retain];
        [self setupSprite:self withImageNamed:[NSString stringWithFormat:@"%@.png", _currentAlienPrefix]];
        self.groundH = GROUND_HEIGHT + self.boundingBox.size.height * self.anchorPoint.y;
        [self setupAnimations];
        //[self animateAlien];
        [self setupSmallBangAnimation];
	}
	return self;
}

- (void)dealloc {
    [animationFramesArray release];
    [_currentAlienPrefix release];
    [super dealloc];
}



#pragma mark - Setters
- (void)setStartPosition:(CGPoint)startPosition {
    [super setStartPosition:startPosition];
    if (self.startPosition.y > self.groundH) { // похоже нас выбросили откуда-то, например - из тарелки
        [self fallToTheGround];
    }
    else {
        [self landedOnTheGround];
    }
}



#pragma mark - CollisionsProtocol
- (void)youAreInCollisionWithObject:(MovableObject *)gameObject {
    switch (gameObject.objType) {
        case OBJ_TYPE_BANG: {
            Bang *bang = (Bang *)gameObject;
            CGFloat bangEnergy = bang.bulletDescr.damage;
            self.energy -= bangEnergy;
            //!!!!! изменить состояние индикатора (возможно это сделать в сеттере энергии)
            if (self.energy <= 0) {
                self.isAffectCollisions = NO;
                energyMeter.visible = NO;
                [self stopAllActions];
                [self animateSmallBang];
                //[self animateDeathFallDown];
            }
        }
        break;
        case OBJ_TYPE_SKATER: {
            Skater *skater = (Skater *)gameObject;
            if (skater.jumpCounter > 0) {
                self.isAffectCollisions = NO;
                [self animateDeathFallDown];
            }
        }
        break;
    }
}


- (CGRect)collisionRect {
    return CGRectInset([super collisionRect], 10, 0);
}


#pragma mark - Update
- (void)update:(ccTime)dt {
    [super update:dt];
    
    if (!self.isActive)
        return;
    
    if (isLanded) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        LevelDescription *levelDescription = [self.movableObjectsDataSource getLevelDescription];
        if (levelDescription.isAliensShoot) {
            CGFloat distanceX = self.position.x - [self.movableObjectsDataSource getSkaterPos].x;
            if (distanceX > screenSize.width / 3 * 2) {
                if (arc4random_uniform(1000) < (levelDescription.alienShootPercent * 10)) {
                    Bullet *bullet = [Bullet nodeWithObjType:OBJ_TYPE_BULLET_FRITS bulletDescrName:BULLET_TYPE_BASIC];
                    bullet.position = ccpAdd(self.position, ccp(-20, 10 * MAIN_SCALE_COEF));
                    [bullet setupSpeed:bullet.bulletDescr.speed withAngle:180 rotate:YES];
                    bullet.collisionSideId = COLLISIONS_FRITS;
                    bullet.isChangeVelocity = NO;
                    bullet.objectsCreationDelegate = self.objectsCreationDelegate;
                    [self.objectsCreationDelegate createdMovableObject:bullet];
                }
            }
        }
    }
}


#pragma mark - Utils
- (NSString *)getAlienPrefixByType:(NSInteger)objType {
    NSString *retVal = @"alien_green"; // nil;
    switch (objType) {
        case OBJ_TYPE_ALIEN_GREEN:
            retVal = @"alien_green";
            break;
        case OBJ_TYPE_ALIEN_YELLOW:
            retVal = @"alien_yellow";
            break;
        case OBJ_TYPE_ALIEN_HELMLET:
            retVal = @"alien_hemlet";
            break;
        case OBJ_TYPE_ALIEN_BIG_ORANGE:
            retVal = @"alien_big_orange";
            break;
        case OBJ_TYPE_ALIEN_CY_GREEN:
            retVal = @"cyclops_green";
            break;
        case OBJ_TYPE_ALIEN_CY_YELLOW:
            retVal = @"cyclops_yellow";
            break;
        case OBJ_TYPE_ALIEN_CY_BIG_ORANGE:
            retVal = @"cyclops_big_orange";
            break;
    }
    return retVal;
}

- (void)fallToTheGround {
    // время падения = расстояние / скорость
    ccTime actionTime = (self.position.y - self.groundH) / ALIENS_FALL_SPEED;
    CGPoint groundPoint = ccp(self.position.x, self.groundH);
    id fallAction = [CCSequence actions:
                     [CCMoveTo actionWithDuration:actionTime position:groundPoint],
                     [CCCallFunc actionWithTarget:self selector:@selector(landedOnTheGround)],
                     nil];
    [self runAction:fallAction];
}

- (void)landedOnTheGround {
    [self animateAlien];
    isLanded = YES;
}


#pragma mark - Animations
- (void)setupAnimations {
    animationFramesArray = [[NSMutableArray alloc] init];
    
    for(int i = 1 ; i <= 6; i++) {
        //NSString  *fileName = [NSString stringWithFormat:@"alien_stands_%i.png",i];
        NSString  *fileName = [NSString stringWithFormat:@"%@_walk%i.png", self.currentAlienPrefix, i];
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame *frame = [frameCache spriteFrameByName:fileName];
        [animationFramesArray addObject:frame];
    }
}

- (void)animateAlien {
    if (isAnimatedNow) {
        return;
    }
    if (![self getActionByTag:TAG_ACT_REGULAR_ANIMATION]) { // избежим повторной анимации
        isAnimatedNow = YES;
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animationFramesArray delay:0.1];
        CCAnimate *animAction = [CCAnimate actionWithAnimation:anim];
        id repeatAction = [CCRepeatForever actionWithAction:animAction];
        [self onTarget:self runAction:repeatAction withTag:TAG_ACT_REGULAR_ANIMATION];
    }
}

- (void)stopAnimateAlien {
    [self stopActionByTag:TAG_ACT_REGULAR_ANIMATION];
}




#pragma mark - Death
- (void)animateDeathFlyOut {
    [self stopAnimateAlien];
    [self stopAllActions];
    self.isActive = NO;
    
    ccBezierConfig bezierActionPars;
    bezierActionPars.controlPoint_1 = ccp(50, 100);
    bezierActionPars.controlPoint_2 = ccp(100, 100);
    bezierActionPars.endPosition = ccp(150, 0);
    
    id bezierAction;
    bezierAction = [CCSequence actions:
                    [CCSpawn actions:
                     [CCRotateBy actionWithDuration:1.7 angle:360*3],
                     [CCBezierBy actionWithDuration:1.7 bezier:bezierActionPars],
                     nil],
                    [CCCallFunc actionWithTarget:self selector:@selector(doIAmDied)],
                    nil];
    [self runAction:bezierAction];
}

- (void)animateDeathFallDown {
    CGFloat alienH = self.boundingBox.size.height;
    CGFloat dist1 = alienH * 0.9;
    CGFloat fallTime = 0.1;
    
    [self stopAnimateAlien];
    [self stopAllActions];
    self.isActive = NO;
    
    //[self correctAnchorPointOfSprite:self toPoint:ccp(0.5, 0.5)];
    
    ccBezierConfig bezierActionPars;
    bezierActionPars.controlPoint_1 = ccp(0, 0);
    bezierActionPars.controlPoint_2 = ccp(dist1 / 2, 0);
    bezierActionPars.endPosition = ccp(dist1,-30);
    
    id bezierAction;
    bezierAction = [CCSequence actions:
                    [CCSpawn actions:
                     [CCRotateBy actionWithDuration:fallTime angle:90],
                     [CCBezierBy actionWithDuration:fallTime bezier:bezierActionPars],
                     nil],
                    [CCDelayTime actionWithDuration:1.0],
                    [CCCallFunc actionWithTarget:self selector:@selector(doIAmDied)],
                    nil];
    [self runAction:bezierAction];
}

- (void)doIAmDied {
    self.visible = NO;
    self.iAmDead = YES;
}


#pragma mark - Energy meter
- (void)setEnergy:(CGFloat)energy {
    [super setEnergy:energy];
    [energyMeter updateWithCurrentVal:self.energy];
    if (self.energy < self.maxEnergy) {
        energyMeter.visible = YES;
    }
}

- (void)setMaxEnergy:(CGFloat)maxEnergy {
    [super setMaxEnergy:maxEnergy];
    if (!energyMeter) {
        [self initEnergyMeterWithMaxVal:maxEnergy currVal:self.energy atSide:EN_METER_TOP isBig:NO];
        energyMeter.visible = NO;
    }
}

- (void)initEnergyMeterWithMaxVal:(NSInteger)maxVal currVal:(NSInteger)currVal atSide:(NSInteger)side isBig:(BOOL)isBig {
    energyMeter = [EnergyMeter nodeWithMaxVal:maxVal currVal:currVal isBig:isBig];
    
    CGFloat dY = -10;
    if (EN_METER_TOP == side) {
        dY = self.boundingBox.size.height / self.scale + 10;
    }
    CGPoint meterPos = ccp(self.boundingBox.size.width/2, dY);
    energyMeter.position = meterPos;
    [self addChild:energyMeter];
    
    //energyMeter.visible = NO;
}



@end
