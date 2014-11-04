//
//  BaseGameObjectsClasses.h
//  NewMoonSkater
//
//  Created by Artem on 11/30/12.
//
//

#import <Foundation/Foundation.h>

#import "GameObjectsProtocols.h"

// ! Добавил объект - обнови описатели в функции getClassOfType (если надо чтоб объект появлялся на экране из банчей)
enum ObjectTypes {
    OBJ_TYPE_NONE = 200,
    OBJ_TYPE_BULLET_RUSSIAN,
    OBJ_TYPE_BULLET_FRITS,
    OBJ_TYPE_BANG,
    OBJ_TYPE_SKATER,
    //OBJ_TYPE_ALIEN,
    OBJ_TYPE_ALIEN_GREEN,
    OBJ_TYPE_ALIEN_YELLOW,
    OBJ_TYPE_ALIEN_HELMLET,
    OBJ_TYPE_ALIEN_BIG_ORANGE,
    OBJ_TYPE_ALIEN_CY_GREEN,
    OBJ_TYPE_ALIEN_CY_YELLOW,
    OBJ_TYPE_ALIEN_CY_BIG_ORANGE,
    OBJ_TYPE_STONE,
    OBJ_TYPE_CRATER,
    OBJ_TYPE_MOONROCK,
    OBJ_TYPE_SPACESHIP,
    OBJ_TYPE_SPACESHIP_BIG,
    OBJ_TYPE_DUST,
    OBJ_TYPE_ARRAY_OF_OBJECTS,  // для банчей - указать что банч не элемент а нода с описателями элементов
    OBJ_TYPE_ALIEN_SIMLE,       // означает что должен быть один вариант из простых А-ов
    OBJ_TYPE_ALIEN_COMPLEX,     // один вариант из сложных А-ов
};


//-------------------------------------------------------------------------------------------

@interface SignalTriggerClass : NSObject
@property (nonatomic) CGFloat floatVal;
// проверить - взведен ли
- (BOOL)isActivated;
// взвести триггер
- (void)activate;
- (void)activateWithFloat:(CGFloat)floatVal;
// сработать триггер
- (void)done;
@end


//-------------------------------------------------------------------------------------------

@interface TriggerDistance : NSObject
@property (nonatomic) CGFloat distance;
// взвести триггер
- (void)startWithSignalDistance:(CGFloat)distance;
// проапдейтить
- (void)updateWithDeltaDistance:(CGFloat)deltaDistance;
// проверить сработку
- (BOOL)isSignaled;
// проверить - взведен ли
- (BOOL)isActivated;
// развести триггер
- (void)done;
@end


//-------------------------------------------------------------------------------------------

@interface MovableObject: SKSpriteNode <MovableObjectsProtocol, UtilizationProtocol, CollisionsProtocol, ObjectsSignalProtocol>

@property (nonatomic) NSInteger objType;
@property (nonatomic) BOOL isActive;
@property (nonatomic, assign) id<ObjectsCreationDelegate> objectsCreationDelegate;
@property (nonatomic) CGFloat maxEnergy;
@property (nonatomic) CGFloat energy;
@property (nonatomic) CGFloat groundH;
@property (nonatomic, assign) id<MovableObjectsDataSource> movableObjectsDataSource;
@property (nonatomic, assign) id<ObjectsSignalDelegate> objectsSignalDelegate;


+ nodeWithObjType:(NSInteger)objType;
- (id)initWithObjType:(NSInteger)objType;

- (CGRect)makeCollisionRectWithSprite:(SKSpriteNode *)sprite;
- (void)setupSprite:(SKSpriteNode *)spriteObj withImageNamed:(NSString *)imageName;
- (CGPoint)calcAccelerationPerSecFromVelocity:(CGPoint)fromVelocity toVelocity:(CGPoint)toVelocity forTimeSec:(CGFloat)timeInSec;
- (void)correctAnchorPointOfSprite:(SKSpriteNode *)sprite toPoint:(CGPoint)newAnchorPoint;
- (void)onTarget:(id)target runAction:(id)action withTag:(NSInteger)tag;

- (void)setupBigBangAnimation;
- (void)setupSmallBangAnimation;
- (void)animateBigBang;
- (void)animateSmallBang;

@end




