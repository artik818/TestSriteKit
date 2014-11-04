//
//  GameObjectsUtils.m
//  NewMoonSkater
//
//  Created by Artem on 12/19/12.
//
//

#import "GameObjectsUtils.h"
#import "Constants.h"
#import "BaseGameObjectsClasses.h"
//#import "Alien.h"
//#import "Stone.h"
#import "Crater.h"
//#import "Moonrock.h"
//#import "Spaceship.h"
//#import "TutorialConsts.h"
//#import "GlobalGameDataSingleton.h"


static GameObjectsUtils *_gameObjectsUtils = nil;


@interface GameObjectsUtils()

@end




@implementation GameObjectsUtils


+ (GameObjectsUtils *)sharedManager
{
    static dispatch_once_t onceTokenGameObjectsUtils;
    dispatch_once(&onceTokenGameObjectsUtils, ^{
        if (!_gameObjectsUtils) {
            _gameObjectsUtils = [[GameObjectsUtils alloc] init];
        }
    });
    return _gameObjectsUtils;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


//+ (void)setupSprite:(CCSprite *)spriteObj withImageNamed:(NSString *)imageName {
//    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
//    CCSpriteFrame *frame = [frameCache spriteFrameByName:imageName];
//    [spriteObj setDisplayFrame: frame];
//}



#pragma mark - Interface funcs
+ (id)getObjectFromDictionary:(NSDictionary *)dict byKey:(NSString *)key andSubKey:(NSString *)subKey {
    id retVal = nil;
    if (key && subKey) {
        NSDictionary *subKeysDict = [dict objectForKey:key];
        if (subKeysDict) {
            retVal = [subKeysDict objectForKey:subKey];
        }
    }
    return retVal;
}

+ (void)setObject:(id)obj forDictionary:(NSDictionary *)dict withKey:(NSString *)key andSubKey:(NSString *)subKey {
    if (key && subKey && obj) {
        NSMutableDictionary *subKeysDict = [dict objectForKey:key];
        if (!subKeysDict) {
            subKeysDict = [NSMutableDictionary dictionary];
        }
        [subKeysDict setObject:obj forKey:subKey];
    }
}


// для того, чтоб объект создавался из createFritzMovableObjectOfType - его нужно прописать в эту функцию
+ (Class)getClassOfType:(NSInteger)objType {
    Class retVal;// = [MovableObject class];
    
    switch (objType) {
            //case OBJ_TYPE_ALIEN:
        case OBJ_TYPE_ALIEN_GREEN:
        case OBJ_TYPE_ALIEN_YELLOW:
        case OBJ_TYPE_ALIEN_HELMLET:
        case OBJ_TYPE_ALIEN_BIG_ORANGE:
        case OBJ_TYPE_ALIEN_CY_GREEN:
        case OBJ_TYPE_ALIEN_CY_YELLOW:
        case OBJ_TYPE_ALIEN_CY_BIG_ORANGE:
//            retVal = [Alien class];
            break;
        case OBJ_TYPE_CRATER:
            retVal = [Crater class];
            break;
        case OBJ_TYPE_MOONROCK:
//            retVal = [Moonrock class];
            break;
        case OBJ_TYPE_STONE:
//            retVal = [Stone class];
            break;
        case OBJ_TYPE_SPACESHIP:
        case OBJ_TYPE_SPACESHIP_BIG:
//            retVal = [Spaceship class];
            break;
            
        default:
            retVal = [MovableObject class];
            break;
    }
    return retVal;
}


// для контроля кол-ва созданных объектов каждого типа
+ (void)incCountObjectsOfType:(NSInteger)objType inDictionary:(NSMutableDictionary *)counterDict {
    NSString *key = [NSString stringWithFormat:@"%ld", objType];
    NSNumber *currVal = [counterDict objectForKey:key];
    NSInteger currCount = [currVal integerValue];
    currCount++;
    [counterDict setObject:[NSNumber numberWithInteger:currCount] forKey:key];
}

+ (NSInteger)getCountOfObjectsOfType:(NSInteger)objType inDictionary:(NSMutableDictionary *)counterDict {
    NSString *key = [NSString stringWithFormat:@"%ld", objType];
    NSNumber *currVal = [counterDict objectForKey:key];
    return [currVal integerValue];
}

+ (void)incCountersInDictionary:(NSMutableDictionary *)counterDictDest byDictionary:(NSMutableDictionary *)counterDictSrc {
    for (NSString *key in counterDictSrc) {
        NSNumber *currSrcVal = [counterDictSrc objectForKey:key];
        NSNumber *currDestVal = [counterDictDest objectForKey:key];
        NSInteger currSrcCount = [currSrcVal integerValue];
        NSInteger currDestCount = [currDestVal integerValue];
        currDestCount += currSrcCount;
        [counterDictDest setObject:[NSNumber numberWithInteger:currDestCount] forKey:key];
    }
}

+ (NSInteger)getRandomTypeOfAlienFromSimples {
    // 4 simple
    NSInteger retVal = OBJ_TYPE_ALIEN_GREEN;
    switch (arc4random_uniform(4)) {
        case 1:
            retVal = OBJ_TYPE_ALIEN_YELLOW;
            break;
        case 2:
            retVal = OBJ_TYPE_ALIEN_CY_GREEN;
            break;
        case 3:
            retVal = OBJ_TYPE_ALIEN_CY_YELLOW;
            break;
    }
    return retVal;
}

+ (NSInteger)getRandomTypeOfAlienFromComplex {
    // 4 simple
    NSInteger retVal = OBJ_TYPE_ALIEN_HELMLET;
    switch (arc4random_uniform(3)) {
        case 1:
            retVal = OBJ_TYPE_ALIEN_BIG_ORANGE;
            break;
        case 2:
            retVal = OBJ_TYPE_ALIEN_CY_BIG_ORANGE;
            break;
    }
    return retVal;
}

//+ (Level *)getLevelObjectWithLevelIndex:(NSInteger)levelIndex {
//    return [[GlobalGameDataSingleton sharedGlobalGameDataSingleton].levelsArray objectAtIndex:levelIndex-1];
//}


@end
