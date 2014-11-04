//
//  GameObjectsProtocols.h
//  NewMoonSkater
//
//  Created by Artem on 11/30/12.
//
//

//@required
//@optional

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

#import "Redefines.h"


//#import "LevelDescription.h"

enum CollisionSideIDs {
    COLLISIONS_NOT_AFFECTED = 0,        // not affected collisions with any object
    COLLISIONS_EVERY_OBJ,               // affect collision with every object except previous one
    COLLISIONS_RUSSIAN,                 // our side
    COLLISIONS_FRITS,                   // enemy side
    COLLISIONS_USER_DEFINED,            // from this number + 1 you can define your own collision side number
};


@class MovableObject;

#pragma mark - CollisionsProtocol
@protocol CollisionsProtocol <NSObject>
@required

@property (nonatomic) int collisionSideId;              // from enum - CollisionSideIDs
@property (nonatomic) CGRect collisionRect;             // because object may have collision rect smaller then its boundingBox. if not initialized? == boundingBox
@property (nonatomic) BOOL isAffectCollisions;

- (BOOL)isInCollisionWithObject:(MovableObject *)gameObject;
- (void)youAreInCollisionWithObject:(MovableObject *)gameObject;

@end

//-------------------------------------------------------------------------------------------



#pragma mark - MovableObjectsProtocol
@protocol MovableObjectsProtocol <NSObject>
@required

@property (nonatomic) CGPoint velocity;                 // скорость (точек в секунду) по разным осям
@property (nonatomic) CGPoint velocityKoef;
@property (nonatomic) CGPoint acceleration;
@property (nonatomic) CGPoint toVelocity;
@property (nonatomic) BOOL isAcceleration;              // будет ли влиять на объект ускорение
@property (nonatomic) BOOL isChangeVelocity;            // будет ли меняться скорость ф-ей changeVelocityTo
@property (nonatomic) CGPoint startPosition;            // начальная позиция элемента

- (void)update:(ccTime)dt;
- (void)setupSpeed:(CGFloat)speed withAngle:(CGFloat)angle rotate:(BOOL)rotate;
- (void)setupSpeed:(CGFloat)speed withAngleToPoint:(CGPoint)point rotate:(BOOL)rotate;
- (void)changeVelocityTo:(CGPoint)newVelocityPixSec forTimeSec:(CGFloat)timeInSec;

//@property (nonatomic, assign) CCSprite *mainSprite;

@end


@protocol MovableObjectsDataSource <NSObject>
- (CGPoint)getSkaterPos;
- (BOOL)isMagnetOn;
- (NSInteger)getCurrentLevel;
//- (LevelDescription *)getLevelDescription;
@end


//-------------------------------------------------------------------------------------------


#pragma mark - ObjectsCreationDelegate
@protocol ObjectsCreationDelegate <NSObject>
@required

//- (void)createdMovableObject:(CCNode *)createdObject withObjType:(NSInteger)objType;
- (void)createdMovableObject:(SKNode *)createdObject;
- (SKNode *)getMovableObjectByTag:(NSInteger)tag;
// если layer == nil, то просто создает объект и инициализирует его, без привязки к слою
//- (MovableObject *)createFritzMovableObjectOfType:(NSInteger)movableObjectType onLayer:(CCLayer *)layer inPosition:(CGPoint)position;

@end

//-------------------------------------------------------------------------------------------

enum VALS_WaitScreanBeforeUtilize_Count {
    WSBU_REGULAR = 0,
    WSBU_WAIT_SCREEN,
};

#pragma mark - UtilizationProtocol
@protocol UtilizationProtocol <NSObject>
@required
@property (nonatomic) BOOL iAmDead; // if object want to dead - it is set in YES
// хитровы св-во:
// если 0 - то утилизировать как только вне экрана - даже если было создано за экраном
// если 1 - то не утилизировать до тех пор, пока не появится на экране
// если стоит флаг iAmDead, то на пропертю забъем болта!
@property (nonatomic) NSInteger waitScreanBeforeUtilizeState;
@property (nonatomic) BOOL notToUtilize; // по умолчанию инициализируется 0 - NO. если ДА, то не утилизировать объект, даже если он имплементит протокол утилизирования

- (void)removeYourselfFromSuper;

@optional

@end

//-------------------------------------------------------------------------------------------

#pragma mark - DistanceSignalDelegate
@protocol ObjectsSignalDelegate <NSObject>
@required

- (void)signaledDistanceXByObject:(MovableObject *)movableObject;
- (void)signaledDistanceYByObject:(MovableObject *)movableObject;
- (void)signaledDistanceXYByObject:(MovableObject *)movableObject;
- (void)signaledAppearedOnScreenByObject:(MovableObject *)movableObject;

@end

#pragma mark - DistanceSignalProtocol
@protocol ObjectsSignalProtocol <NSObject>
@required

- (void)signalWhenDistanceX:(CGFloat)distance;
- (void)signalWhenDistanceY:(CGFloat)distance;
- (void)signalWhenDistanceXY:(CGFloat)distance;
- (void)signalWhenAppearOnTheScreen;

@end



