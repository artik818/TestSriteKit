//
//  GlobalGameDataSingleton.h
//  NewMoonSkater
//
//  Created by Momus on 13.12.12.
//
//

#import <Foundation/Foundation.h>


#define WEAPON_DATA                     @"WEAPON_DATA"              // оружие, которое есть у скейтера - кей. сабкей - название оружия. значение объекта - nsnumber - YES/NO
#define BULLET_DATA                     @"BULLET_DATA"              // пули. сабкей - конкретный тип. значение - nsnumber - кол-во
#define CURRENT_WEAPON_NAME             @"CURRENT_WEAPON_NAME"      // кей - WEAPON_DATA. сабкей CURRENT_WEAPON_NAME - текущее оружие. значение - строка-описатель
#define MOON_ROCKS_DATA                 @"MOON_ROCKS_DATA"          // кей. значение - nsnumber nsinteger - кол-во
#define MAGNETS_DATA                    @"MAGNETS_DATA"             // кей. значение - nsnumber nsinteger - кол-во



@interface GlobalGameDataSingleton : NSObject

@property (nonatomic, retain) NSMutableArray *levelsArray;
@property (nonatomic, retain) NSMutableDictionary *globalDataDictionary;

+ (GlobalGameDataSingleton *)sharedGlobalGameDataSingleton;

- (void)updateLevelDataAtLevelNumber:(int)levelNumber withScore:(int)score andTotalScore:(int)totalScore;

- (BOOL)isFirstLaunch;
- (void)setAlreadyFirstLaunched;

@end
