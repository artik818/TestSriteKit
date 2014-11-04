//
//  GameObjectsBunch.m
//  NewMoonSkater
//
//  Created by Artem on 12/14/12.
//
//

#import "GameObjectsBunch.h"
#import "GameObjectsUtils.h"

@interface GameObjectsBunch()

@end




@implementation GameObjectsBunch

@synthesize elementsArray = _elementsArray;
@synthesize bunchSize = _bunchSize;
@synthesize bunchPosition = _bunchPosition;
@synthesize bunchLevel = _bunchLevel;
@synthesize objType = _objType;
@synthesize flIsCanCreateObsticlesInCurrentBunch = _flIsCanCreateObsticlesInCurrentBunch;
@synthesize objectCounterDict = _objectCounterDict;
@synthesize afterBunchDistance = _afterBunchDistance;


#pragma mark - Life cycle
+ (id)nodeWithObjType:(NSInteger)objType {
    return [[[self alloc] initWithObjType:objType] autorelease];
}

- (id)initWithObjType:(NSInteger)objType {
    if (self = [super init]) {
        _objType = objType;
        _elementsArray = [[NSMutableArray alloc] init];
        _objectCounterDict = [[NSMutableDictionary alloc] init];
        _afterBunchDistance = 150;
        [GameObjectsUtils incCountObjectsOfType:objType inDictionary:_objectCounterDict];
    }
    return self;
}

- (void)dealloc {
    [_elementsArray release];
    [_objectCounterDict release];
    [super dealloc];
}


- (void)addChild:(GameObjectsBunch *)child {
    [self.elementsArray addObject:child];
    [GameObjectsUtils incCountersInDictionary:self.objectCounterDict byDictionary:child.objectCounterDict];
}

@end
