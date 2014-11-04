//
//  LevelDescription.m
//  NewMoonSkater
//
//  Created by Artem on 12/26/12.
//
//

#import "LevelDescription.h"
//#import "GameObjectsBunch.h"
#import "DescriptionsSingleton.h"
#import "GameObjectsUtils.h"
#import "BaseGameObjectsClasses.h"

@interface LevelDescription()

@end





@implementation LevelDescription

- (id)initWithLengthInSec:(CGFloat)lengthInSec {
    if (self = [super init]) {
        _lengthInSec = lengthInSec;
        _bunches = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [_bunches release];
    [super dealloc];
}



- (void)setupMoonrocksWithCount:(NSInteger)moonrocksCount {
    self.moonrocksCount = moonrocksCount;
}

- (void)setupAliensWithCount:(NSInteger)count isAlienShoot:(BOOL)isAlienShoot alienSimplePercent:(CGFloat)simplePercent shootPercent:(CGFloat)shootPercent {
    self.aliensCount = count;
    self.isAliensShoot = isAlienShoot;
    self.alienSimplePercent = simplePercent;
    self.alienShootPercent = shootPercent;
}

- (void)setupShipWithTimesCount:(NSInteger)timesCount appearenceTime:(CGFloat)spaceshipTimeSec isShoot:(BOOL)isShoot isDrop:(BOOL)isDrop shootPercent:(CGFloat)shootPercent {
    self.spaceshipTimesCount = timesCount;
    self.spaceshipTimeSec = spaceshipTimeSec;
    self.isSpaceshipShoot = isShoot;
    self.isSpaceshipDropAliens = isDrop;
    self.spaceshipShootPercent = shootPercent;
}

- (void)addBunchesOfType:(NSString *)bunchType withCount:(NSInteger)count {
    if (count > 0) {
        for (int i=0; i<count; ++i) {
            NSString *tmp_bunchType = [NSString stringWithString:bunchType];
            [self.bunches addObject:tmp_bunchType];
        }
    }
}

- (void)printCountsOfObjectsOfTypes {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (NSString *bunchName in self.bunches) {
        GameObjectsBunch *gob = [[DescriptionsSingleton sharedManager] getObjectByKey:DESCR_KEY_BUNCHES andSubKey:bunchName];
        [GameObjectsUtils incCountersInDictionary:dict byDictionary:gob.objectCounterDict];
    }
    
    
    NSString *resStr = [NSString string];
    NSNumber *count = [dict objectForKey:[NSString stringWithFormat:@"%i", OBJ_TYPE_ALIEN_GREEN]];
    if (count) {
        NSString *currStr = [NSString stringWithFormat:@"OBJ_TYPE_ALIEN_GREEN == %@ | ", count];
        resStr = [resStr stringByAppendingString:currStr];
    }
}

@end
