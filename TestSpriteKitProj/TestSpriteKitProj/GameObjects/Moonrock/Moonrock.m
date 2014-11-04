//
//  Moonrock.m
//  NewMoonSkater
//
//  Created by Artem on 12/12/12.
//
//

#import "Moonrock.h"
#import "Constants.h"

@interface Moonrock() {
    BOOL doletelDoSkeytera;
}

@end





@implementation Moonrock

@synthesize endPoint = _endPoint;
//@synthesize dataSourceMoonrock = _dataSourceMoonrock;


#pragma mark - Life cycle
- (id)initWithObjType:(NSInteger)objType {
	if (self = [super initWithObjType:objType]) {
        [self setupSprite:self withImageNamed:@"moon_rock.png"];
        self.scale = 1;
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}



#pragma mark - CollisionsProtocol
- (void)youAreInCollisionWithObject:(MovableObject *)gameObject {
    switch (gameObject.objType) {
        case OBJ_TYPE_SKATER:
            self.isAffectCollisions = NO;
            doletelDoSkeytera = YES;
            [self collectMoonRockWithEndPoint:self.endPoint];
        break;
    }
}



#pragma mark - MovableObjectsProtocol implementation
- (void)update:(ccTime)dt {
    if (self.isActive) {
        // магнит
        if (!doletelDoSkeytera) {
            if ([self.movableObjectsDataSource isMagnetOn]) {
                CGPoint skaterPos = [self.movableObjectsDataSource getSkaterPos];
                if (ccpDistance(skaterPos, self.position) <= MAGNET_RADIUS) {
                    [self setupSpeed:MOON_ROCK_MAGNET_SPEED withAngleToPoint:skaterPos rotate:NO];
                }
            }
        }
    }
    [super update:dt];
}



- (void)collectMoonRockWithEndPoint:(CGPoint)endPoint {
    [self stopAllActions];
    
    self.velocity = CGPointZero;
    CGFloat collectionTimeSec = ccpDistance(self.position, endPoint) / MOON_ROCK_COLLECTION_SPEED;
    CCAction *act = [CCSequence actions:
                     [CCMoveTo actionWithDuration:collectionTimeSec position:endPoint],
                     [CCCallFunc actionWithTarget:self selector:@selector(moonRockCollected)],
                     nil];
    [self runAction:act];
}

- (void)moonRockCollected {
    [self.delegateMoonrock moonRockCollected];
    self.iAmDead = YES;
}


@end
