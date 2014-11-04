//
//  Spaceship.m
//  NewMoonSkater
//
//  Created by Artem on 12/19/12.
//
//

#import "Spaceship.h"
#import "Bang.h"
#import "Alien.h"
#import "Bullet.h"
#import "Constants.h"
#import "GameObjectsUtils.h"
#import "EnergyMeter.h"

@interface Spaceship() {
    BOOL shipIsCame;
    EnergyMeter *energyMeter;
}

@end





@implementation Spaceship

@synthesize isToDropAliens = _isToDropAliens;
@synthesize isToShoot = _isToShoot;


#pragma mark - Life cycle
- (id)initWithObjType:(NSInteger)objType {
	if (self = [super initWithObjType:objType]) {
        [self setupSprite:self withImageNamed:@"ship.png"];
        _isToDropAliens = NO;
        _isToShoot = NO;
        [self setupBigBangAnimation];
        [self setupSmallBangAnimation];
        if (OBJ_TYPE_SPACESHIP_BIG == objType) {
            self.scale = 1;
        }
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark - CollisionsProtocol
- (void)youAreInCollisionWithObject:(MovableObject *)gameObject {
    switch (gameObject.objType) {
        case OBJ_TYPE_BANG: {
            Bang *bang = (Bang *)gameObject;
            if ([bang.bulletDescr.name isEqualToString:BULLET_TYPE_ROCKET]) {
            //if ([bang.bulletDescr.name isEqualToString:BULLET_TYPE_PLASMA] || [bang.bulletDescr.name isEqualToString:BULLET_TYPE_ROCKET]) {
                //[self animateSmallBang];
                CGFloat bangEnergy = bang.bulletDescr.damage;
                self.energy -= bangEnergy;
                //!!!!! изменить состояние индикатора (возможно это сделать в сеттере энергии)
                if (self.energy <= 0) {
                    self.isAffectCollisions = NO;
                    energyMeter.visible = NO;
                    [self stopAllActions];
                    [self animateBigBang];
                }
            }
        }
        break;
    }
}


#pragma mark - Interface
- (void)appearInPoint:(CGPoint)endPOint {
    CGFloat comeTime = 1;
    id appearAction = [CCSequence actions:
                       [CCMoveTo actionWithDuration:comeTime position:endPOint],
                       [CCCallFunc actionWithTarget:self selector:@selector(passiveFlyAnimation)],
                       nil];
    [self runAction:appearAction];
}

- (void)appearForTime:(CGFloat)timeSec inPoint:(CGPoint)endPOint {
    [self appearInPoint:endPOint];
    
    id delayAction = [CCSequence actions:
                      [CCDelayTime actionWithDuration:timeSec],
                      [CCCallFunc actionWithTarget:self selector:@selector(shipGoAway)],
                      nil];
    [self runAction:delayAction];
}

- (void)dropAlienOfType:(NSInteger)objType {
    CGPoint pos = self.position;
    Alien *alien = (Alien *)[self.objectsCreationDelegate createFritzMovableObjectOfType:objType onLayer:nil inPosition:ccp(pos.x, pos.y-20)];
    [self.objectsCreationDelegate createdMovableObject:alien];
}


#pragma mark - Utils
- (void)shipGoAway {
    shipIsCame = NO;
    CGPoint endPoint = ccp(self.position.x + 300, self.position.y + 40);
    
    id goAwayAction = [CCMoveTo actionWithDuration:1 position:endPoint];
    [self runAction:goAwayAction];
    
    /*
    shipIsCame = NO;
    [self stopAllActions];
    [self setupSpeed:0 withAngle:180 rotate:NO];
    [self changeVelocityTo:ccp(300, 0) forTimeSec:1];*/
}



#pragma mark - Animations
- (void)passiveFlyAnimation {
    shipIsCame = YES;
    ccTime flyTime = 1.0;
    CGFloat delta = 20;
    id flyAction = [CCSequence actions:
                    [CCMoveBy actionWithDuration:flyTime position:ccp(0, -delta)],
                    [CCMoveBy actionWithDuration:flyTime position:ccp(0, +delta)],
                    nil];
    id retVal = [CCRepeatForever actionWithAction:flyAction];
    [self runAction:retVal];
}



#pragma mark - Game algorithms
- (void)dropAlienIf_WithDeltaTime:(ccTime)dt {
    if (!self.isActive) {
        return;
    }
    
    LevelDescription *levelDescription = [self.movableObjectsDataSource getLevelDescription];
    if (levelDescription.isSpaceshipDropAliens) {
        NSInteger randVal = arc4random_uniform(200);
        if (randVal == 1) {
            BOOL isSimple = (arc4random_uniform(1000) < levelDescription.alienSimplePercent * 10);
            NSInteger alienRandType = OBJ_TYPE_ALIEN_GREEN;
            if (isSimple) {
                alienRandType = [GameObjectsUtils getRandomTypeOfAlienFromSimples];
            }
            else {
                alienRandType = [GameObjectsUtils getRandomTypeOfAlienFromComplex];
            }
            //NSInteger alienRandType = OBJ_TYPE_ALIEN_GREEN + arc4random_uniform(7);
            [self dropAlienOfType:alienRandType];
        }
    }
}


- (void)shootIf {
    if (!self.isActive) {
        return;
    }
    
    LevelDescription *levelDescription = [self.movableObjectsDataSource getLevelDescription];
    if (levelDescription.isSpaceshipShoot) {
        CGPoint skaterPoint = [self.movableObjectsDataSource getSkaterPos];
        if (arc4random_uniform(1000) < (levelDescription.spaceshipShootPercent * 10)) {
            Bullet *bullet = [Bullet nodeWithObjType:OBJ_TYPE_BULLET_FRITS bulletDescrName:BULLET_TYPE_BASIC];
            bullet.position = ccpAdd(self.position, ccp(-20, 10 * MAIN_SCALE_COEF));
            [bullet setupSpeed:bullet.bulletDescr.speed withAngleToPoint:skaterPoint rotate:YES];
            bullet.collisionSideId = COLLISIONS_FRITS;
            bullet.isChangeVelocity = NO;
            bullet.objectsCreationDelegate = self.objectsCreationDelegate;
            [self.objectsCreationDelegate createdMovableObject:bullet];
        }
    }
}



#pragma mark - Update
- (void)update:(ccTime)dt {
    [super update:dt];
    
    if (shipIsCame) {
        [self dropAlienIf_WithDeltaTime:dt];
        [self shootIf];
    }
}


#pragma mark - Energy meter
- (void)setEnergy:(CGFloat)energy {
    [super setEnergy:energy];
    [energyMeter updateWithCurrentVal:self.energy];
}

- (void)setMaxEnergy:(CGFloat)maxEnergy {
    [super setMaxEnergy:maxEnergy];
    if (!energyMeter) {
        [self initEnergyMeterWithMaxVal:maxEnergy currVal:self.energy atSide:EN_METER_BOTTOM isBig:YES];
        energyMeter.visible = YES;
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
