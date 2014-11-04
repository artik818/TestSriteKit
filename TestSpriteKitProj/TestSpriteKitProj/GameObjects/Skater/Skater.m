//
//  Skater.m
//  NewMoonSkater
//
//  Created by Artem on 12/3/12.
//
//


#import <SpriteKit/SpriteKit.h>

#import "Skater.h"
#import "Constants.h"
//#import "WeaponDescription.h"
//#import "BulletDescription.h"
//#import "DescriptionsSingleton.h"
//#import "Weapon.h"
//#import "Bullet.h"
//#import "Crater.h"
//#import "Bang.h"


#define SKATER_JUMP_SPEED               300.0
#define SKATER_FLY_SPEED                70.0
#define SKATER_FIRST_JUMP_HEIGHT        90.0
#define SKATER_SECOND_JUMP_HEIGHT       (SKATER_FIRST_JUMP_HEIGHT + 40)
//#define SKATER_JUMP_UP_DELAY_SEC        0.05


enum ActionTags {
    TAG_ACT_JUMP = 300,
    TAG_ACT_FLIP,
    TAG_ACT_BALANCE,
};

enum ObjectsTags {
    TAG_OBJ_DUST = 500,
};


//--------------------------------------------------------------------------


@interface Skater() {
    BOOL isOnGround;
    //CGFloat groundH;
    NSMutableArray *skaterBalanceFramesArray;
    NSMutableArray *dustAnimFramesArray;
    BOOL flIsDust;                                  // определяет - пускать ли пыль после преземления
    SKSpriteNode *yellowSpot;
}


@property (nonatomic, retain) NSString *currentWeaponType;
@property (nonatomic, retain) Weapon *currentWeapon;


@end




@implementation Skater

@synthesize jumpCounter = _jumpCounter;
@synthesize currIsExtra = _currIsExtra;

@synthesize skaterDelegate = _skaterDelegate;
@synthesize currentWeaponType = _currentWeaponType;
@synthesize currentWeapon = _currentWeapon;
@synthesize currentWeaponBulletsCount = _currentWeaponBulletsCount;

#pragma mark - Life cycle
- (id)initWithObjType:(NSInteger)objType {
	if (self = [super initWithObjType:objType]) {
        self.currentWeaponType = WEAPON_TYPE_ROCKET;
        self.currentWeapon = [[[Weapon alloc] initWithWeaponDescrName:self.currentWeaponType] autorelease];
        
        [self setupSprite:self withImageNamed:[self makeFullPictureNameWith:@"skater" andLastSuffix:@"1"]];
        self.groundH = GROUND_HEIGHT + self.boundingBox.size.height * self.anchorPoint.y;
        
        isOnGround = YES;
        [self setupUnchangableAnimations];
        [self setupSkaterAnimations];
        [self animateBalanceSkater];
        
        [self ceateYellowSpot];
	}
	return self;
}

- (void)dealloc {
    [_currentWeaponType release];
    [_currentWeapon release];
    [skaterBalanceFramesArray release];
    [dustAnimFramesArray release];
    [super dealloc];
}


#pragma mark - Yellow spot
- (void)ceateYellowSpot {
    yellowSpot = [CCSprite spriteWithSpriteFrameName:@"light.png"];
    yellowSpot.position = ccp(self.boundingBox.size.width / 2 + 8, 0);
    [self addChild:yellowSpot];
}


#pragma mark - Setters
/*
- (void)setPosition:(CGPoint)position {
    [super setPosition:position];
    groundH = GROUND_HEIGHT + self.boundingBox.size.height * self.anchorPoint.y;
}
*/
/*
- (void)setStartPosition:(CGPoint)startPosition {
    [super setPosition:startPosition];
    self.groundH = GROUND_HEIGHT + self.boundingBox.size.height * self.anchorPoint.y;
}*/

- (void)setIsActive:(BOOL)isActive {
    [super setIsActive:isActive];
    if (!isActive) { // только когда отключаем активность - меняем активность стрельбы - прекращаем стрельбу
        self.currentWeapon.isShootingNow = NO;
    }
}

- (void)setEnergy:(CGFloat)energy {
    [super setEnergy:energy];
    [self.skaterDelegate skaterEnergyChanged:self.energy];
}

-(void)setCurrentWeaponBulletsCount:(NSInteger)currentWeaponBulletsCount {
    _currentWeaponBulletsCount = currentWeaponBulletsCount;
    self.currentWeapon.bulletsCount = _currentWeaponBulletsCount;
}



#pragma mark - MovableObjectsProtocol implementation
- (void)update:(ccTime)dt {
    [self shootEngineProcessWithWeapon:self.currentWeapon forDt:dt];
    [super update:dt];
}



#pragma mark - Balance
- (void)setupSkaterAnimations {
    [skaterBalanceFramesArray release];
    skaterBalanceFramesArray = [[NSMutableArray alloc] init];
    
    for(int i = 1 ; i <= 3; i++) {
        NSString *pictNumber = [NSString stringWithFormat:@"%i",i];
        NSString  *fileName = [self makeFullPictureNameWith:@"skater" andLastSuffix:pictNumber];
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame *frame = [frameCache spriteFrameByName:fileName];
        [skaterBalanceFramesArray addObject:frame];
    }
}
    
- (void)setupUnchangableAnimations {
    dustAnimFramesArray = [[NSMutableArray alloc] init];
    
    for(int i = 1 ; i <= 4; i++) {
        NSString  *fileName = [NSString stringWithFormat:@"Dust_explode_frame0%i.png",i];
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame *frame = [frameCache spriteFrameByName:fileName];
        
        [dustAnimFramesArray  addObject:frame];
    }
}

- (void)animateBalanceSkater {
    if (![self getActionByTag:TAG_ACT_BALANCE]) { // избежим повторной анимации
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:skaterBalanceFramesArray delay:0.3];
        CCAnimate *animAction = [CCAnimate actionWithAnimation:anim];
        id repeatAction = [CCRepeatForever actionWithAction:animAction];
        [self onTarget:self runAction:repeatAction withTag:TAG_ACT_BALANCE];
    }
}

- (void)stopAnimateBalanceSkater {
    [self stopActionByTag:TAG_ACT_BALANCE];
}



#pragma mark - Dust after jump
- (void)dustAferJump {
    MovableObject *dustObj = [MovableObject nodeWithObjType:OBJ_TYPE_DUST];
    dustObj.isAffectCollisions = NO;
    [dustObj setupSpeed:SPEED_OF_DUST withAngle:180 rotate:NO];
    dustObj.position = CGPointMake(self.position.x, self.position.y - self.boundingBox.size.height/2 + 15);
    dustObj.tag = TAG_OBJ_DUST;
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:dustAnimFramesArray delay:0.1];
    CCAnimate *animAction = [CCSequence actions:
                             [CCAnimate actionWithAnimation:anim],
                             [CCCallFuncN actionWithTarget:self selector:@selector(removeDust)],
                             nil];
    [dustObj runAction:animAction];
    
    [self.objectsCreationDelegate createdMovableObject:dustObj];
}
- (void)removeDust {
    MovableObject *dustObj = (MovableObject *)[self.objectsCreationDelegate getMovableObjectByTag:TAG_OBJ_DUST];
    dustObj.iAmDead = YES;
}



#pragma mark - Jump and fly
- (void)skaterJumpMoveDown {
    if (self.position.y - self.groundH >= SKATER_FIRST_JUMP_HEIGHT) {
        flIsDust = YES;
    }
    [self animateBalanceSkater];
    id jumpAction = [CCSequence actions:
                  [CCMoveTo actionWithDuration:(self.position.y - self.groundH) / SKATER_JUMP_SPEED position:ccp(self.position.x, self.groundH)],
                  [CCCallFuncN actionWithTarget:self selector:@selector(skaterJumpedOnTheGround)],
                  nil];
    [self onTarget:self runAction:jumpAction withTag:TAG_ACT_JUMP];
}

- (void)skaterJumpFlyDown {
    flIsDust = NO;
    [self stopAnimateBalanceSkater];
    [self setupSprite:self withImageNamed:[self makeFullPictureNameWith:@"skater_jump" andLastSuffix:@""]];
    //[self setupSprite:self withImageNamed:@"skater_jump.png"];
    id jumpAction = [CCSequence actions:
                     [CCMoveTo actionWithDuration:(self.position.y - self.groundH) / SKATER_FLY_SPEED position:ccp(self.position.x, self.groundH)],
                     [CCCallFuncN actionWithTarget:self selector:@selector(skaterJumpedOnTheGround)],
                     nil];
    [self onTarget:self runAction:jumpAction withTag:TAG_ACT_JUMP];
}

- (void)skaterJumpedOnTheGround {
    [self animateBalanceSkater];
    if (flIsDust) {
        [self dustAferJump];
        [self skaterScaleAfterJump];
        flIsDust = NO;
    }
    isOnGround = YES;
    _jumpCounter = 0;
    yellowSpot.visible = YES;
}

- (void)skaterJump:(NSInteger)jumpNumber {
    yellowSpot.visible = NO;
    CGFloat jumpHeight = SKATER_FIRST_JUMP_HEIGHT;
    if (jumpNumber == 2) {
        jumpHeight = SKATER_SECOND_JUMP_HEIGHT;
        flIsDust = YES;
    }
    CGFloat dist = jumpHeight * 2 + (self.position.y - self.groundH);
    id jumpAction = [CCSequence actions:
                     [CCJumpTo actionWithDuration:dist / SKATER_JUMP_SPEED position:ccp(self.position.x, self.groundH) height:jumpHeight jumps:1],
                     [CCCallFuncN actionWithTarget:self selector:@selector(skaterJumpMoveDown)], // для того, чтоб отработал код по приземлению (даже если скейтер уже на земле)
                     nil];
    [self onTarget:self runAction:jumpAction withTag:TAG_ACT_JUMP];
    
    if (jumpNumber == 2) {
        id flipAction = [CCRotateBy actionWithDuration:0.5 angle:360];
        [self onTarget:self runAction:flipAction withTag:TAG_ACT_FLIP];
    }
}

- (void)skaterScaleAfterJump {
    CGFloat minScaleKoef = 0.93;
    CGFloat nowScale = self.scale;
    CGFloat minScaleY = nowScale * minScaleKoef;
    CGFloat timeScaleMin = 0.03;
    CGFloat timeScaleMax = 0.2;
    id act = [CCSequence actions:
              [CCScaleTo actionWithDuration:timeScaleMin scaleX:nowScale scaleY:minScaleY],
              [CCScaleTo actionWithDuration:timeScaleMax scaleX:nowScale scaleY:nowScale],
              nil];
    [self runAction:act];
}


#pragma mark - ScaterControlProtocol implementation
- (void)jumpButtonPressed:(BOOL)isPressDown {
    if (!self.isActive)
        return;

    if (isPressDown) {
        if (_jumpCounter < 3) {
            _jumpCounter++;
        }
        
        if (_jumpCounter <= 2) { // прыжок
            [self skaterJump:_jumpCounter];
        }
        else { // полет вниз
            [self skaterJumpFlyDown];
        }
    }
    else {
        if (_jumpCounter == 3) {
            [self skaterJumpMoveDown];
        }
    }
}

- (void)shootButtonPressed:(BOOL)isPressDown {
    if (!self.isActive)
        return;
    
    self.currentWeapon.isShootingNow = isPressDown;
}

- (void)changeWeaponTypeTo:(NSString *)newWeaponType {
    if (!self.isActive)
        return;
    
    self.currentWeaponType = newWeaponType;
    self.currentWeapon = [[[Weapon alloc] initWithWeaponDescrName:self.currentWeaponType] autorelease];
    [self setupSkaterAnimations];
    [self stopAnimateBalanceSkater];
    [self animateBalanceSkater];
}

- (void)changeExtraToState:(BOOL)isExtra {
    if (!self.isActive)
        return;
    
    _currIsExtra = isExtra;
    //self.isAffectCollisions = !currIsExtra;
    GLubyte currOpacity = _currIsExtra?150:255;
    [self setOpacity:currOpacity];
}


#pragma mark - Shoot
- (void)shootEngineProcessWithWeapon:(Weapon *)weapon forDt:(ccTime)dt {
    if (weapon.isShootingNow) {
        if (weapon.canShoot) {
            if ((weapon.bulletsCount > 0) || ([weapon.weaponDescrName isEqualToString:WEAPON_TYPE_BASIC])) {
                if (weapon.bulletsCount > 0) {
                    weapon.bulletsCount--;
                }
                weapon.canShoot = NO;
                weapon.lastShootDuration = 0;
                NSString *bulletName = self.currentWeapon.weaponDescr.bulletDescrName;
                Bullet *bullet = [Bullet nodeWithObjType:OBJ_TYPE_BULLET_RUSSIAN bulletDescrName:bulletName];
                bullet.position = ccpAdd(self.position, ccp(20, 21 * MAIN_SCALE_COEF));
                [bullet setupSpeed:bullet.bulletDescr.speed withAngle:0 rotate:YES];
                bullet.collisionSideId = COLLISIONS_RUSSIAN;
                bullet.isChangeVelocity = NO;
                bullet.objectsCreationDelegate = self.objectsCreationDelegate;
                [self.objectsCreationDelegate createdMovableObject:bullet];
                [self.skaterDelegate skaterShootedWithBulletName:bulletName];
            }
        }
    }
    
    weapon.lastShootDuration += dt;
    if (weapon.lastShootDuration >= weapon.weaponDescr.fireRateSec) {
        weapon.lastShootDuration = 0;
        weapon.canShoot = YES;
    }
}




#pragma mark - CollisionsProtocol
- (void)youAreInCollisionWithObject:(MovableObject *)gameObject {
    if (_currIsExtra) {
        return;
    }
    
    switch (gameObject.objType) {
        //case OBJ_TYPE_BULLET_FRITS:
        case OBJ_TYPE_BANG: {
            Bang *bang = (Bang *)gameObject;
            CGFloat bangEnergy = bang.bulletDescr.damage;
            self.energy -= bangEnergy;
            [self.skaterDelegate skaterEnergyChanged:self.energy];
            //!!!!! изменить состояние индикатора (возможно это сделать в сеттере энергии)
            if (self.energy <= 0) {
                self.isAffectCollisions = NO;
                [self.skaterDelegate skaterBeginToDeath];
                [self animateDeath];
            }
        }
        break;
        //case OBJ_TYPE_ALIEN:
        case OBJ_TYPE_ALIEN_GREEN:
        case OBJ_TYPE_ALIEN_YELLOW:
        case OBJ_TYPE_ALIEN_HELMLET:
        case OBJ_TYPE_ALIEN_BIG_ORANGE:
        case OBJ_TYPE_ALIEN_CY_GREEN:
        case OBJ_TYPE_ALIEN_CY_YELLOW:
        case OBJ_TYPE_ALIEN_CY_BIG_ORANGE:
            if (0 == _jumpCounter) {
                self.isAffectCollisions = NO;
                [self.skaterDelegate skaterBeginToDeath];
                [self animateDeath];
            }
        break;
        case OBJ_TYPE_STONE:
            self.isAffectCollisions = NO;
            [self.skaterDelegate skaterBeginToDeath];
            [self animateDeath];
        break;
        case OBJ_TYPE_CRATER:
            self.isAffectCollisions = NO;
            [self.skaterDelegate skaterBeginToDeath];
            Crater *crater = (Crater *)gameObject;
            [self animateCraterDeath:crater];
        break;
    }
}

- (CGRect)collisionRect {
    CGRect collRect = CGRectInset([super collisionRect], 10, 0);
    /*if (isFly) {
        collRect = CGRectInset(collRect, 0, 20);
    }*/
    return collRect;
}



#pragma mark - Death
- (void)animateDeath {
    [self stopAllActions];
    
    yellowSpot.visible = NO;
    
    ccBezierConfig bezierActionPars;
    bezierActionPars.controlPoint_1 = ccp(60, 30);
    bezierActionPars.controlPoint_2 = ccp(130, 80);
    bezierActionPars.endPosition = ccp(220, 400);
    
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

- (void)animateCraterDeath:(Crater *)crater {
    [self stopAllActions];
    
    yellowSpot.visible = NO;
    
    ccBezierConfig bezierActionPars;
    CGFloat craterCenterX = crater.boundingBox.origin.x - 20; // так как кратер сдвинется на половину себя в процессе остановки сцены
    CGFloat selfX = self.position.x;
    CGFloat controlPointH = 100;
    CGFloat stepX = (craterCenterX - selfX) / 3;
    
    bezierActionPars.controlPoint_1 = ccp(stepX, controlPointH);
    bezierActionPars.controlPoint_2 = ccp(stepX*2, controlPointH);
    bezierActionPars.endPosition = ccp(stepX*3, -5);
    
    CGFloat durationD = 1.1;
    id bezierAction;
    bezierAction = [CCSequence actions:
                    [CCSpawn actions:
                     [CCScaleTo actionWithDuration:durationD scale:0.5],
                     [CCRotateBy actionWithDuration:durationD angle:360*3],
                     [CCBezierBy actionWithDuration:durationD bezier:bezierActionPars],
                     nil],
                    [CCCallFunc actionWithTarget:self selector:@selector(doIAmDied)],
                    nil];
    [self runAction:bezierAction];
}




#pragma mark - Utils
- (void)doIAmDied {
    self.visible = NO;
    [self.skaterDelegate skaterDied];
}


- (NSString *)makeFullPictureNameWith:(NSString *)baseName andLastSuffix:(NSString *)lastSuffix {
    NSString *resStr;
    
    NSString *weaponSuffix;
    
    if ([self.currentWeapon.weaponDescrName isEqualToString:WEAPON_TYPE_BASIC]) {
        weaponSuffix = @"_laser";
    }
    else if ([self.currentWeapon.weaponDescrName isEqualToString:WEAPON_TYPE_RAPID]) {
        weaponSuffix = @"_laser";
    }
    else if ([self.currentWeapon.weaponDescrName isEqualToString:WEAPON_TYPE_PLASMA]) {
        weaponSuffix = @"_plasma";
    }
    else {
        weaponSuffix = @"_rocket";
    }
    
    resStr = [NSString stringWithFormat:@"%@%@%@.png", baseName, weaponSuffix, lastSuffix];
    return resStr;
}

@end



