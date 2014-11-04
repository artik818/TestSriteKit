//
//  GameObjectsUtils.h
//  NewMoonSkater
//
//  Created by Artem on 12/19/12.
//
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

//#import "cocos2d.h"
//#import "Level.h"


@interface GameObjectsUtils : NSObject

+ (GameObjectsUtils *)sharedManager;

+ (void)setupSprite:(SKSpriteNode *)spriteObj withImageNamed:(NSString *)imageName;

+ (id)getObjectFromDictionary:(NSDictionary *)dict byKey:(NSString *)key andSubKey:(NSString *)subKey;
+ (void)setObject:(id)obj forDictionary:(NSDictionary *)dict withKey:(NSString *)key andSubKey:(NSString *)subKey;
+ (Class)getClassOfType:(NSInteger)objType;

// для контроля кол-ва созданных объектов каждого типа
+ (void)incCountObjectsOfType:(NSInteger)objType inDictionary:(NSMutableDictionary *)counterDict;
+ (NSInteger)getCountOfObjectsOfType:(NSInteger)objType inDictionary:(NSMutableDictionary *)counterDict;
+ (void)incCountersInDictionary:(NSMutableDictionary *)counterDictDest byDictionary:(NSMutableDictionary *)counterDictSrc;

+ (NSInteger)getRandomTypeOfAlienFromSimples;
+ (NSInteger)getRandomTypeOfAlienFromComplex;

//+ (Level *)getLevelObjectWithLevelIndex:(NSInteger)levelIndex;

@end
