//
//  BaseGameObjectsClasses.m
//  NewMoonSkater
//
//  Created by Artem on 11/30/12.
//
//

#import "BaseGameObjectsClasses.h"
#import "Constants.h"
#import "GameObjectsUtils.h"


@interface SignalTriggerClass() {
}

@property (nonatomic) BOOL isActiveTrigger;

@end



@implementation SignalTriggerClass

@synthesize isActiveTrigger = _isActiveTrigger;
@synthesize floatVal = _floatVal;

- (id)init {
    if (self = [super init]) {
        _isActiveTrigger = NO;
        _floatVal = -1;
    }
    return self;
}

- (BOOL)isActivated {
    if (self.isActiveTrigger) {
        return YES;
    }
    return NO;
}

- (void)activate {
    [self activateWithFloat:-1];
}

- (void)activateWithFloat:(CGFloat)floatVal {
    self.isActiveTrigger = YES;
    self.floatVal = floatVal;
}

- (void)done {
    self.isActiveTrigger = NO;
}
@end



//-------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------


@interface TriggerDistance() {
    BOOL isMeActivated;
    BOOL isMeSignaled;
    BOOL alreadyTriggered;
    CGFloat currDistance;
}
@end

@implementation TriggerDistance

- (id)init {
    if (self = [super init]) {
        alreadyTriggered = YES;
    }
    return self;
}

- (void)startWithSignalDistance:(CGFloat)distance {
    self.distance = distance;
    isMeSignaled = NO;
    isMeActivated = YES;
    alreadyTriggered = NO;
    currDistance = 0;
}

- (void)updateWithDeltaDistance:(CGFloat)deltaDistance {
    if ((!isMeActivated) || alreadyTriggered) {
        return;
    }
    currDistance += deltaDistance;
    if (currDistance >= self.distance) {
        isMeSignaled = YES;
        alreadyTriggered = YES;
    }
}

- (BOOL)isSignaled {
    return isMeSignaled;
}

- (BOOL)isActivated {
    return isMeActivated;
}

-(void)done {
    isMeSignaled = NO;
}
@end

//-------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------


@interface MovableObject() {
    NSMutableArray *bangBigAnimationFramesArray;
    NSMutableArray *bangSmallAnimationFramesArray;
    
    SignalTriggerClass *signalDistXTrigger;
    SignalTriggerClass *signalDistYTrigger;
    SignalTriggerClass *signalDistXYTrigger;
    SignalTriggerClass *signalAppearOnScreen;
}

@end




@implementation MovableObject

@synthesize groundH = _groundH;

@synthesize objType = _objType;
@synthesize isActive = _isActive;
@synthesize objectsCreationDelegate = _objectsCreationDelegate;
@synthesize maxEnergy = _maxEnergy;
@synthesize energy = _energy;

@synthesize velocity = _velocity;
@synthesize velocityKoef = _velocityKoef;
@synthesize acceleration = _acceleration;
@synthesize toVelocity = _toVelocity;
@synthesize isAcceleration = _isAcceleration;
@synthesize isChangeVelocity = _isChangeVelocity;
@synthesize startPosition = _startPosition;

@synthesize iAmDead = _iAmDead;
@synthesize notToUtilize = _notToUtilize;
@synthesize waitScreanBeforeUtilizeState = _waitScreanBeforeUtilizeState;
@synthesize collisionSideId = _collisionSideId;
@synthesize collisionRect = _collisionRect;
@synthesize isAffectCollisions = _isAffectCollisions;

@synthesize movableObjectsDataSource = _movableObjectsDataSource;

@synthesize objectsSignalDelegate = _objectsSignalDelegate;


+ nodeWithObjType:(NSInteger)objType {
    return [[self alloc] initWithObjType:objType];
}

- (id)initWithObjType:(NSInteger)objType {
    if (self = [super init]) {
        //sigDistX = sigDistY =sigDistXY = -1;
        _collisionSideId = COLLISIONS_NOT_AFFECTED;
        _collisionRect = self.frame;
        _isAcceleration = YES;
        _isAffectCollisions = YES;
        _objType = objType;
        _waitScreanBeforeUtilizeState = WSBU_REGULAR;
        _isActive = YES;
        _isChangeVelocity = YES;
        self.scale = MAIN_SCALE_COEF;
        signalDistXTrigger = [[SignalTriggerClass alloc] init];
        signalDistYTrigger = [[SignalTriggerClass alloc] init];
        signalDistXYTrigger = [[SignalTriggerClass alloc] init];
        signalAppearOnScreen = [[SignalTriggerClass alloc] init];
    }
    return self;
}



#pragma mark - MovableObjectsProtocol
- (void)setStartPosition:(CGPoint)startPosition {
    _startPosition = startPosition;
    self.position = _startPosition;
}

/*
- (void)update:(ccTime)dt {
    if (self.isAcceleration) {
        if (self.acceleration.x || self.acceleration.y) {
            CGPoint deltasAcceleration = ccpMult(self.acceleration, dt);
            self.velocity = ccpAdd(self.velocity, deltasAcceleration);
            if (((self.acceleration.x < 0) && (self.velocity.x <= self.toVelocity.x)) || ((self.acceleration.x > 0) && (self.velocity.x >= self.toVelocity.x))) {
                self.acceleration = CGPointZero;
                self.velocity = self.toVelocity;
            }
        }
    }
    
    if (self.velocity.x || self.velocity.y) {
        CGPoint deltas = ccpMult(self.velocity, dt);
        self.position = ccpAdd(self.position, deltas);
    }
    
    [self updateSignals];
}
*/

- (void)setupSpeed:(CGFloat)speed withAngle:(CGFloat)angle rotate:(BOOL)rotate {
    CGFloat speedX = speed * sin(SK_DEGREES_TO_RADIANS(angle+90));
    CGFloat speedY = speed * cos(SK_DEGREES_TO_RADIANS(angle+90));
    self.velocity = CGPointMake(speedX, speedY);
    if (rotate) {
        self.zRotation = angle;
    }
}

- (void)setupSpeed:(CGFloat)speed withAngleToPoint:(CGPoint)point rotate:(BOOL)rotate {
    CGFloat speedX = (point.x - self.position.x);
    CGFloat speedY = (point.y - self.position.y);
    CGFloat angle = SK_RADIANS_TO_DEGREES(atanf(speedX/speedY)) + 90;
    //[self setupSpeed:speed withAngle:angle rotate:rotate];
    
    
    CGFloat k = speed / ccpDistance(point, self.position);
    speedX = (point.x - self.position.x) * k;
    speedY = (point.y - self.position.y) * k;
    self.velocity = CGPointMake(speedX, speedY);
    
    if (rotate) {
        self.zRotation = angle;
    }
}



#pragma mark - UtilizationProtocol
- (void)removeYourselfFromSuper {
//    [self stopAllActions];
//    [self removeFromParentAndCleanup:YES];
    [self removeFromParent];
}


#pragma mark - CollisionsProtocol
- (BOOL)isInCollisionWithObject:(MovableObject *)gameObject {
    BOOL retVal = NO;
    // условия, когда проверяем
    BOOL if0 = (self.isAffectCollisions && gameObject.isAffectCollisions);
    BOOL if1 = ((COLLISIONS_NOT_AFFECTED != self.collisionSideId) && (COLLISIONS_NOT_AFFECTED != [gameObject collisionSideId])); // оба поддаются коллизиям
    BOOL if2 = ((COLLISIONS_EVERY_OBJ == self.collisionSideId) || (COLLISIONS_EVERY_OBJ == [gameObject collisionSideId])); // если хотя бы один из них - коллизийный со всеми
    BOOL if3 = (self.collisionSideId != [gameObject collisionSideId]); // разные стороны
    if (if0 && (if1 && (if2 || if3))) {
        if (CGRectIntersectsRect(self.collisionRect, [gameObject collisionRect])) {
            retVal = YES;
        }
    }
    return retVal;
}

- (void)youAreInCollisionWithObject:(MovableObject *)gameObject {
    
}

- (CGRect)collisionRect {
    return [self makeCollisionRectWithSprite:self];
}


#pragma mark - AccelerationProtocol
- (void)changeVelocityTo:(CGPoint)newVelocityPixSec forTimeSec:(CGFloat)timeInSec { //!!!!! только если объект поддается изменению скорости - ввести флаг
    if (self.isChangeVelocity) {
        self.acceleration = [self calcAccelerationPerSecFromVelocity:self.velocity toVelocity:newVelocityPixSec forTimeSec:timeInSec];
        self.toVelocity = newVelocityPixSec;
    }
}


#pragma mark - ObjectsSignalProtocol
- (void)signalWhenDistanceX:(CGFloat)distance {
    [signalDistXTrigger activateWithFloat:distance];
}

- (void)signalWhenDistanceY:(CGFloat)distance {
    [signalDistYTrigger activateWithFloat:distance];
}

- (void)signalWhenDistanceXY:(CGFloat)distance {
    [signalDistXYTrigger activateWithFloat:distance];
}

- (void)signalWhenAppearOnTheScreen {
    [signalAppearOnScreen activate];
}


/*
#pragma mark - Interface
- (void)setupBigBangAnimation {
    bangBigAnimationFramesArray = [[NSMutableArray alloc] init];
    
    for(int i = 1 ; i <= 11; i++) {
        NSString  *fileName = [NSString stringWithFormat:@"ship_exploded%i.png",i];
//        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
//        CCSpriteFrame *frame = [frameCache spriteFrameByName:fileName];
//        [bangBigAnimationFramesArray addObject:frame];
    }
}

- (void)setupSmallBangAnimation {
    bangSmallAnimationFramesArray = [[NSMutableArray alloc] init];
    
    for(int i = 1 ; i <= 8; i++) {
        NSString  *fileName = [NSString stringWithFormat:@"alien_explode%i.png",i];
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame *frame = [frameCache spriteFrameByName:fileName];
        [bangSmallAnimationFramesArray addObject:frame];
    }
}

- (void)animateBigBang {
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:bangBigAnimationFramesArray delay:0.1];
    CCAnimate *animAction = [CCSequence actions:
                             [CCAnimate actionWithAnimation:anim],
                             [CCCallFunc actionWithTarget:self selector:@selector(animationBangComplete)],
                             nil];
    [self onTarget:self runAction:animAction withTag:10];
}

- (void)animateSmallBang {
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:bangSmallAnimationFramesArray delay:0.1];
    CCAnimate *animAction = [CCSequence actions:
                             [CCAnimate actionWithAnimation:anim],
                             [CCCallFunc actionWithTarget:self selector:@selector(animationBangComplete)],
                             nil];
    [self onTarget:self runAction:animAction withTag:10];
}
*/

- (void)animationBangComplete {
    self.iAmDead = YES;
}



#pragma mark - Utils
- (void)setupSprite:(SKSpriteNode *)spriteObj withImageNamed:(NSString *)imageName {
//    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
//    CCSpriteFrame *frame = [frameCache spriteFrameByName:imageName];
//    [spriteObj setDisplayFrame: frame];
    [self setTexture:[SKTexture textureWithImageNamed:imageName]];
}



- (CGRect)makeCollisionRectWithSprite:(SKSpriteNode *)sprite {
    CGFloat percentFromWidth = 0.9;
    CGFloat width = sprite.frame.size.width * percentFromWidth;
    CGFloat height = sprite.frame.size.height * percentFromWidth;
    CGFloat left = self.position.x - width * sprite.anchorPoint.x;
    CGFloat bottom = self.position.y - height * sprite.anchorPoint.y;
    
    return CGRectMake(left, bottom, width, height);
}

- (CGPoint)calcAccelerationPerSecFromVelocity:(CGPoint)fromVelocity toVelocity:(CGPoint)toVelocity forTimeSec:(CGFloat)timeInSec {
    return CGPointMake((toVelocity.x - fromVelocity.x) / timeInSec, (toVelocity.y - fromVelocity.y) / timeInSec);
}

- (void)correctAnchorPointOfSprite:(SKSpriteNode *)sprite toPoint:(CGPoint)newAnchorPoint {
    CGFloat left = sprite.position.x - (sprite.frame.size.width * sprite.anchorPoint.x);
    CGFloat bottom = sprite.position.y - (sprite.frame.size.height * sprite.anchorPoint.y);
    sprite.anchorPoint = newAnchorPoint;
    sprite.position = CGPointMake(left + sprite.frame.size.width * sprite.anchorPoint.x, bottom + sprite.frame.size.height * sprite.anchorPoint.y);
}

- (void)onTarget:(id)target runAction:(id)action withTag:(NSInteger)tag {
//    [target stopActionByTag:tag];
    [action setTag:tag];
    [target runAction:action];
}


- (void)updateSignals {
    if ([signalDistXTrigger isActivated]) {
        if (abs([self.movableObjectsDataSource getSkaterPos].x - self.position.x) <= signalDistXTrigger.floatVal) {
            [self.objectsSignalDelegate signaledDistanceXByObject:self];
            [signalDistXTrigger done];
        }
    }
    
    if ([signalDistYTrigger isActivated]) {
        if (abs([self.movableObjectsDataSource getSkaterPos].y - self.position.y) <= signalDistYTrigger.floatVal) {
            [self.objectsSignalDelegate signaledDistanceYByObject:self];
            [signalDistYTrigger done];
        }
    }
    
    if ([signalDistXYTrigger isActivated]) {
        if (ccpDistance([self.movableObjectsDataSource getSkaterPos], self.position) <= signalDistXYTrigger.floatVal) {
            [self.objectsSignalDelegate signaledDistanceXYByObject:self];
            [signalDistXYTrigger done];
        }
    }
    
//    if ([signalAppearOnScreen isActivated]) {
//        CGSize screenSize = [CCDirector sharedDirector].winSize;
//        CGPoint leftBottom = self.boundingBox.origin;
//        CGPoint rightTop = ccp(self.boundingBox.origin.x + self.boundingBox.size.width, self.boundingBox.origin.y + self.boundingBox.size.height);
//        if ((leftBottom.x < 0) || (leftBottom.y < 0) || (rightTop.x > screenSize.width) || (rightTop.y > screenSize.height)) {
//        }
//        else {
//            [self.objectsSignalDelegate signaledAppearedOnScreenByObject:self];
//            [signalAppearOnScreen done];
//        }
//    }
}


@end

