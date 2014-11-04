//
//  Bunches.h
//  NewMoonSkater
//
//  Created by Artem on 12/24/12.
//
//

#import <Foundation/Foundation.h>

#import "GameObjectsBunch.h"


@interface Bunches : NSObject

+ (GameObjectsBunch *)setupBunchOfObjType:(NSInteger)objType withCount:(NSInteger)objectsCount;
+ (GameObjectsBunch *)setupBunchKupolOnAltitude:(CGFloat)altitude withMiddleObjType:(NSInteger)objType;
+ (GameObjectsBunch *)setupBunchMoonrocksIn3AltitudesOneByOne;
+ (GameObjectsBunch *)setupBunchMoonrocksIn3AltitudesOneByOneBack;
+ (GameObjectsBunch *)setupBunchMoonrocksIn2AltitudesOneByOneBack;

@end
