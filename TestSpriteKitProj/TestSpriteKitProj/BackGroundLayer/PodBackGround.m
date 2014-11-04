//
//  PodBackGround.m
//  NewMoonSkater
//
//  Created by Artem on 12/3/12.
//
//

#import "PodBackGround.h"


@interface PodBackGround()

@property (nonatomic, retain) NSArray *bkgroundSpritesArray;

@end




@implementation PodBackGround

//@synthesize mainSprite = _mainSprite;
@synthesize velocity = _velocity;
@synthesize velocityKoef = _velocityKoef;
@synthesize acceleration = _acceleration;
@synthesize toVelocity = _toVelocity;
@synthesize bkgroundSpritesArray = _bkgroundSpritesArray;
@synthesize isAcceleration = _isAcceleration;
@synthesize isChangeVelocity = _isChangeVelocity;
@synthesize startPosition = _startPosition;

#pragma mark - Life cycle
- (id)initWithSpritesArray:(NSArray *)spritesArray velocity:(CGPoint)velocity velocityKoef:(CGPoint)velocityKoef {
    if (self = [super init]) {
        self.bkgroundSpritesArray = [NSArray arrayWithArray:spritesArray];
        self.velocity = velocity;
        self.velocityKoef = velocityKoef;
        [self normalizeSpritesArray:spritesArray];
    }
    return self;
}

- (id)initWithSpritesArray:(NSArray *)spritesArray {
    if (self = [self initWithSpritesArray:spritesArray velocity:CGPointZero velocityKoef:ccp(1,1)]) {
    }
    return self;
}

- (void)dealloc {
    [_bkgroundSpritesArray release];
}


#pragma mark - Utils
- (void)normalizeSpritesArray:(NSArray *)spritesArray {
    for (CCSprite *curBkGroundSprite in spritesArray) {
        curBkGroundSprite.position = CGPointMake(curBkGroundSprite.boundingBox.origin.x, curBkGroundSprite.boundingBox.origin.y);
        curBkGroundSprite.anchorPoint = CGPointZero;
    }
}

- (void)connectAfterSprite:(CCSprite *)sprite01 otherSprite:(CCSprite *)sprite02 {
    /*
    // позиция = правая часть спрайта 01 от точки_привязки + левая часть спрайта 02 от точки привязки + позиция 01
    //CGFloat right01 = (1.0 - sprite01.anchorPoint.x) * sprite01.contentSize.width;
    CGFloat right01 = (1.0 - sprite01.anchorPoint.x) * sprite01.boundingBox.size.width;
    CGFloat left02 = sprite02.anchorPoint.x * sprite02.boundingBox.size.width;
    sprite02.position = CGPointMake(sprite01.position.x + right01 + left02, sprite02.position.y);*/
    
    sprite02.position = ccp(sprite01.boundingBox.origin.x + sprite01.boundingBox.size.width - 2, sprite02.position.y);
}



#pragma mark - MovableObjectsProtocol implementation
- (void)update:(ccTime)dt {
    NSInteger bkSpritesCount = self.bkgroundSpritesArray.count;
    // кол-во спрайтов должно быть больше 1
    if (bkSpritesCount <= 1) {
        return;
    }
    
    if (self.acceleration.x || self.acceleration.y) {
        CGPoint deltasAcceleration = ccpMult(self.acceleration, dt);
        self.velocity = ccpAdd(self.velocity, deltasAcceleration);
        if (((self.acceleration.x < 0) && (self.velocity.x <= self.toVelocity.x)) || ((self.acceleration.x > 0) && (self.velocity.x >= self.toVelocity.x))) {
            self.acceleration = CGPointZero;
            self.velocity = self.toVelocity;
        }
    }
    
    
    //CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGPoint deltaMoveXY = CGPointMake(self.velocity.x * dt * self.velocityKoef.x, self.velocity.y * dt * self.velocityKoef.y);
    
    // подвинем все спрайты
    for (CCSprite *tmp_bkGroundSprite in self.bkgroundSpritesArray) {
        tmp_bkGroundSprite.position = ccpAdd(tmp_bkGroundSprite.position, deltaMoveXY);
    }
    
    // если спрайт убежал вперед - зацепим его справа
    NSInteger currSpriteIndex = 0;
    for (CCSprite *tmp_bkGroundSprite in self.bkgroundSpritesArray) {
        // если спрайт вышел справа за границу экрана, то поцепить его самым последним
        if (tmp_bkGroundSprite.boundingBox.origin.x + tmp_bkGroundSprite.boundingBox.size.width < 0) {
            // самый последний == спрайт с индексом tmp_bkGroundSprite - 1
            NSInteger lastSpriteIndex = currSpriteIndex-1;
            if (lastSpriteIndex < 0) {
                lastSpriteIndex = bkSpritesCount - 1;
            }
            CCSprite *lastSprite = [self.bkgroundSpritesArray objectAtIndex:lastSpriteIndex];
            [self connectAfterSprite:lastSprite otherSprite:tmp_bkGroundSprite];
        }
        
        currSpriteIndex++;
    }
}

- (void)setupSpeed:(CGFloat)speed withAngle:(CGFloat)angle rotate:(BOOL)rotate {
    
}

- (void)setupSpeed:(CGFloat)speed withAngleToPoint:(CGPoint)point rotate:(BOOL)rotate {
    
}

- (void)changeVelocityTo:(CGPoint)newVelocityPixSec forTimeSec:(CGFloat)timeInSec {
    self.acceleration = [self calcAccelerationPerSecFromVelocity:self.velocity toVelocity:newVelocityPixSec forTimeSec:timeInSec];
    self.toVelocity = newVelocityPixSec;
}

- (CGPoint)calcAccelerationPerSecFromVelocity:(CGPoint)fromVelocity toVelocity:(CGPoint)toVelocity forTimeSec:(CGFloat)timeInSec {
    return ccp((toVelocity.x - fromVelocity.x) / timeInSec, (toVelocity.y - fromVelocity.y) / timeInSec);
}


@end
