//
//  GlobalGameDataSingleton.m
//  NewMoonSkater
//
//  Created by Momus on 13.12.12.
//
//

#import "GlobalGameDataSingleton.h"
#import "Constants.h"

@implementation GlobalGameDataSingleton

@synthesize levelsArray = _levelsArray;

#pragma mark Initialization

static GlobalGameDataSingleton *sharedGlobalGameDataSingleton = nil;

+ (GlobalGameDataSingleton *)sharedGlobalGameDataSingleton {
    static dispatch_once_t onceGlobalGameDataSingletonToken;

    dispatch_once(&onceGlobalGameDataSingletonToken, ^{
        if (!sharedGlobalGameDataSingleton) {
            sharedGlobalGameDataSingleton = [[GlobalGameDataSingleton alloc] init];
        }
    });
    return sharedGlobalGameDataSingleton;
}

- (id)init {
    if (self = [super init]) {
        self.levelsArray = [self getLevelsMutableArrayFromNSDefaults];
        _globalDataDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [self saveLevelsArrayToNsDefaults:self.levelsArray];
    [_levelsArray release];
    [_globalDataDictionary release];
    [super dealloc];
}


#pragma mark - First Launch
- (BOOL)isFirstLaunch {
    NSString *isNotFirst = [[NSUserDefaults standardUserDefaults] objectForKey:NSDEFAULTS_IS_NOT_FIRST_LAUNCH];
    if (isNotFirst) {
        return NO;
    }
    return YES;
}

- (void)setAlreadyFirstLaunched {
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:NSDEFAULTS_IS_NOT_FIRST_LAUNCH];
}


#pragma mark - Levels Data work
- (void)initLevelsDictionary {
    NSMutableArray *internalLevels = [NSMutableArray arrayWithCapacity:NUMBER_OF_LEVELS_TOTAL];
    for (int i = 1; i <= NUMBER_OF_LEVELS_TOTAL; i++) {
        // create Levels with initial settings
        Level *currLevel = [Level levelWithLevelNumber:i];
        if (i == 1) {
            [currLevel openLevel];
        }
        [internalLevels addObject:currLevel];
    }
    [self saveLevelsArrayToNsDefaults:internalLevels];
}

- (void)saveLevelsArrayToNsDefaults:(NSMutableArray *)levelsForSave {
    // serialize - cause NSDefaults won't get custom clasess as objects
    NSData *myEncodedLevels = [NSKeyedArchiver archivedDataWithRootObject:levelsForSave];
    // save serialized object
    [[NSUserDefaults standardUserDefaults] setObject:myEncodedLevels forKey:NSDEFAULTS_LEVELS_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableArray *)getLevelsMutableArrayFromNSDefaults {
    // get serialazed NSArray
    NSData *decodedDefaultsLevels = [[NSUserDefaults standardUserDefaults] objectForKey:NSDEFAULTS_LEVELS_ARRAY];
    // if we haven't levels in UserDefaults - we initialise it and put to NSDefaults (probably first launch)
    if (!decodedDefaultsLevels) {
        [self initLevelsDictionary];
        decodedDefaultsLevels = [[NSUserDefaults standardUserDefaults] objectForKey:NSDEFAULTS_LEVELS_ARRAY];
    }
    // deserialise NsArray
    NSArray *defaultsLevels = [NSKeyedUnarchiver unarchiveObjectWithData:decodedDefaultsLevels];
    NSMutableArray *res = [NSMutableArray arrayWithArray:defaultsLevels];
    return res;
}

- (void)updateLevelDataAtLevelNumber:(int)levelNumber withScore:(int)score andTotalScore:(int)totalScore {
    // update level with level number (NSArray indexed from zeor - so dec levelNumber)
    Level *currLevel = [self.levelsArray objectAtIndex:levelNumber - 1];
    [currLevel completeLevelWithScore:score andTotalScore:totalScore];
    
    // replace updated level in array
    [self.levelsArray replaceObjectAtIndex:levelNumber withObject:currLevel];
}



#pragma mark -




@end
