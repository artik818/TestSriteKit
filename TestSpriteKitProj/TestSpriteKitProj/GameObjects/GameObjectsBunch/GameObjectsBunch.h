//
//  GameObjectsBunch.h
//  NewMoonSkater
//
//  Created by Artem on 12/14/12.
//
//

#import <Foundation/Foundation.h>

@interface GameObjectsBunch : NSObject

@property (nonatomic, readonly, retain) NSMutableArray *elementsArray;         // массив, где элемент: или объект или такой же класс (набор_объектов)
@property (nonatomic) CGSize bunchSize;
@property (nonatomic) CGPoint bunchPosition;
@property (nonatomic) NSInteger bunchLevel;
@property (nonatomic, readonly) NSInteger objType;
@property (nonatomic) BOOL flIsCanCreateObsticlesInCurrentBunch;
@property (nonatomic, retain) NSMutableDictionary *objectCounterDict;
@property (nonatomic) CGFloat afterBunchDistance;

+ (id)nodeWithObjType:(NSInteger)objType;
- (void)addChild:(GameObjectsBunch *)child;

@end
