//
//  DescriptionsSingleton.m
//  NewMoonSkater
//
//  Created by Artem on 12/4/12.
//
//

#import "DescriptionsSingleton.h"
#import "WeaponDescription.h"
#import "BulletDescription.h"
#import "LevelDescription.h"
//#import "GameObjectsBunch.h"
//#import "Moonrock.h"
//#import "Constants.h"
//#import "Bunches.h"


static DescriptionsSingleton *_descriptionsSingleton = nil;


@interface DescriptionsSingleton()

@property (nonatomic, retain) NSMutableDictionary *descrDictionary;

@end





@implementation DescriptionsSingleton

@synthesize descrDictionary = _descrDictionary;


+ (DescriptionsSingleton *)sharedManager
{
    static dispatch_once_t onceTokenDescriptionsSingleton;
    dispatch_once(&onceTokenDescriptionsSingleton, ^{
        if (!_descriptionsSingleton) {
            _descriptionsSingleton = [[DescriptionsSingleton alloc] init];
        }
    });
    return _descriptionsSingleton;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.descrDictionary = [NSMutableDictionary dictionary];
        [self setupBooletDescription];
        [self setupWeaponDescription];
        [self setupBunchesDescriptions];
        [self setupLevelDescriptoin];
    }
    return self;
}


- (void)setupLevelDescriptoin {
    NSMutableDictionary *levelDict = [NSMutableDictionary dictionary];
    
    LevelDescription *lDescr;
    
    lDescr = [[LevelDescription alloc] initWithLengthInSec:30];
    [lDescr setupAliensWithCount:20 isAlienShoot:NO alienSimplePercent:100 shootPercent:0];
    [lDescr setupShipWithTimesCount:0 appearenceTime:0 isShoot:NO isDrop:NO shootPercent:0];
    [lDescr addBunchesOfType:BUNCH_TYPE__1_ALIENS_SIMPLE withCount:10];
    [lDescr addBunchesOfType:BUNCH_TYPE__1_ALIENS_COMPLEX withCount:2];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK withCount:2];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK withCount:3];
    [levelDict setObject:lDescr forKey:@"1"];
    
    lDescr = [[LevelDescription alloc] initWithLengthInSec:35];
    [lDescr setupAliensWithCount:30 isAlienShoot:NO alienSimplePercent:90 shootPercent:0];
    [lDescr setupShipWithTimesCount:0 appearenceTime:0 isShoot:NO isDrop:NO shootPercent:0];
    [lDescr addBunchesOfType:BUNCH_TYPE__1_ALIENS_SIMPLE withCount:4];
    [lDescr addBunchesOfType:BUNCH_TYPE__1_ALIENS_COMPLEX withCount:2];
    [lDescr addBunchesOfType:BUNCH_TYPE__2_ALIENS_SIMPLE withCount:9];
    [lDescr addBunchesOfType:BUNCH_TYPE__2_ALIENS_COMPLEX withCount:1];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK withCount:3];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER withCount:2];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK withCount:3];
    [levelDict setObject:lDescr forKey:@"2"];
    
    lDescr = [[LevelDescription alloc] initWithLengthInSec:40];
    [lDescr setupAliensWithCount:30 isAlienShoot:YES alienSimplePercent:80 shootPercent:0.2];
    [lDescr setupShipWithTimesCount:1 appearenceTime:10 isShoot:NO isDrop:NO shootPercent:0.1];
    [lDescr addBunchesOfType:BUNCH_TYPE__2_ALIENS_SIMPLE withCount:2];
    [lDescr addBunchesOfType:BUNCH_TYPE__2_ALIENS_COMPLEX withCount:2];
    [lDescr addBunchesOfType:BUNCH_TYPE__3_ALIENS_SIMPLE withCount:8];
    [lDescr addBunchesOfType:BUNCH_TYPE__3_ALIENS_COMPLEX withCount:3];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK withCount:3];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK withCount:2];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER withCount:3];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK withCount:3];
    [levelDict setObject:lDescr forKey:@"3"];
    
    lDescr = [[LevelDescription alloc] initWithLengthInSec:50];
    [lDescr setupAliensWithCount:40 isAlienShoot:YES alienSimplePercent:70 shootPercent:0.2];
    [lDescr setupShipWithTimesCount:1 appearenceTime:15 isShoot:YES isDrop:YES shootPercent:0.1];
    [lDescr addBunchesOfType:BUNCH_TYPE__3_ALIENS_SIMPLE withCount:2];
    [lDescr addBunchesOfType:BUNCH_TYPE__3_ALIENS_COMPLEX withCount:2];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_SIMPLE withCount:8];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_COMPLEX withCount:3];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK withCount:4];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK withCount:3];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER withCount:5];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK withCount:5];
    [levelDict setObject:lDescr forKey:@"4"];
    
    
    NSInteger count_4_ALIENS_SIMPLE = 4;
    NSInteger count_4_ALIENS_COMPLEX = 4;
    NSInteger count_5_ALIENS_SIMPLE = 4;
    NSInteger count_5_ALIENS_COMPLEX = 4;
    NSInteger count_MOON_ROCKS_2_ALTITUDES_BACK = 2;
    NSInteger count_MOON_ROCKS_3_ALTITUDES = 6;
    NSInteger count_MOON_ROCKS_3_ALTITUDES_BACK = 0;
    NSInteger count_MOON_ROCKS_KUPOL_ROCK = 8;
    NSInteger count_MOON_ROCKS_KUPOL_CRATER = 6;
    
    lDescr = [[LevelDescription alloc] initWithLengthInSec:60];
    [lDescr setupAliensWithCount:50 isAlienShoot:YES alienSimplePercent:60 shootPercent:0.4];
    [lDescr setupShipWithTimesCount:2 appearenceTime:15 isShoot:YES isDrop:YES shootPercent:0.4];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_SIMPLE withCount:count_4_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_COMPLEX withCount:count_4_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_SIMPLE withCount:count_5_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_COMPLEX withCount:count_5_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK withCount:count_MOON_ROCKS_2_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES withCount:count_MOON_ROCKS_3_ALTITUDES];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK withCount:count_MOON_ROCKS_3_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK withCount:count_MOON_ROCKS_KUPOL_ROCK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER withCount:count_MOON_ROCKS_KUPOL_CRATER];
    [levelDict setObject:lDescr forKey:@"5"];
    
    count_4_ALIENS_SIMPLE += 1;
    count_4_ALIENS_COMPLEX += 1;
    count_5_ALIENS_SIMPLE += 1;
    count_5_ALIENS_COMPLEX += 1;
    count_MOON_ROCKS_2_ALTITUDES_BACK += 2;
    count_MOON_ROCKS_3_ALTITUDES += 2;
    //count_MOON_ROCKS_3_ALTITUDES_BACK;
    count_MOON_ROCKS_KUPOL_CRATER += 2;
    count_MOON_ROCKS_KUPOL_ROCK += 2;
    lDescr = [[LevelDescription alloc] initWithLengthInSec:70];
    [lDescr setupAliensWithCount:50 isAlienShoot:YES alienSimplePercent:55 shootPercent:0.4];
    [lDescr setupShipWithTimesCount:2 appearenceTime:20 isShoot:YES isDrop:YES shootPercent:0.1];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_SIMPLE withCount:count_4_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_COMPLEX withCount:count_4_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_SIMPLE withCount:count_5_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_COMPLEX withCount:count_5_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK withCount:count_MOON_ROCKS_2_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES withCount:count_MOON_ROCKS_3_ALTITUDES];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK withCount:count_MOON_ROCKS_3_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK withCount:count_MOON_ROCKS_KUPOL_ROCK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER withCount:count_MOON_ROCKS_KUPOL_CRATER];
    [levelDict setObject:lDescr forKey:@"6"];
    
    count_4_ALIENS_SIMPLE += 0;
    count_4_ALIENS_COMPLEX += 0;
    count_5_ALIENS_SIMPLE += 1;
    count_5_ALIENS_COMPLEX += 1;
    count_MOON_ROCKS_2_ALTITUDES_BACK += 1;
    count_MOON_ROCKS_3_ALTITUDES += 1;
    //count_MOON_ROCKS_3_ALTITUDES_BACK;
    count_MOON_ROCKS_KUPOL_CRATER += 1;
    count_MOON_ROCKS_KUPOL_ROCK += 1;
    lDescr = [[LevelDescription alloc] initWithLengthInSec:80];
    [lDescr setupAliensWithCount:60 isAlienShoot:YES alienSimplePercent:50 shootPercent:0.4];
    [lDescr setupShipWithTimesCount:2 appearenceTime:20 isShoot:YES isDrop:YES shootPercent:0.1];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_SIMPLE withCount:count_4_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_COMPLEX withCount:count_4_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_SIMPLE withCount:count_5_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_COMPLEX withCount:count_5_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK withCount:count_MOON_ROCKS_2_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES withCount:count_MOON_ROCKS_3_ALTITUDES];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK withCount:count_MOON_ROCKS_3_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK withCount:count_MOON_ROCKS_KUPOL_ROCK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER withCount:count_MOON_ROCKS_KUPOL_CRATER];
    [levelDict setObject:lDescr forKey:@"7"];
    
    count_4_ALIENS_SIMPLE -= 1;
    count_4_ALIENS_COMPLEX -= 1;
    count_5_ALIENS_SIMPLE += 1;
    count_5_ALIENS_COMPLEX += 1;
    count_MOON_ROCKS_2_ALTITUDES_BACK += 1;
    count_MOON_ROCKS_3_ALTITUDES += 1;
    count_MOON_ROCKS_3_ALTITUDES_BACK += 1;
    count_MOON_ROCKS_KUPOL_CRATER += 1;
    count_MOON_ROCKS_KUPOL_ROCK += 1;
    lDescr = [[LevelDescription alloc] initWithLengthInSec:90];
    [lDescr setupAliensWithCount:60 isAlienShoot:YES alienSimplePercent:40 shootPercent:0.4];
    [lDescr setupShipWithTimesCount:2 appearenceTime:20 isShoot:YES isDrop:YES shootPercent:0.1];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_SIMPLE withCount:count_4_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_COMPLEX withCount:count_4_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_SIMPLE withCount:count_5_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_COMPLEX withCount:count_5_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK withCount:count_MOON_ROCKS_2_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES withCount:count_MOON_ROCKS_3_ALTITUDES];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK withCount:count_MOON_ROCKS_3_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK withCount:count_MOON_ROCKS_KUPOL_ROCK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER withCount:count_MOON_ROCKS_KUPOL_CRATER];
    [levelDict setObject:lDescr forKey:@"8"];
    
    count_4_ALIENS_SIMPLE -= 1;
    count_4_ALIENS_COMPLEX -= 1;
    count_5_ALIENS_SIMPLE += 2;
    count_5_ALIENS_COMPLEX += 2;
    count_MOON_ROCKS_2_ALTITUDES_BACK += 0;
    count_MOON_ROCKS_3_ALTITUDES += 0;
    count_MOON_ROCKS_3_ALTITUDES_BACK += 0;
    count_MOON_ROCKS_KUPOL_CRATER += 2;
    count_MOON_ROCKS_KUPOL_ROCK += 1;
    lDescr = [[LevelDescription alloc] initWithLengthInSec:100];
    [lDescr setupAliensWithCount:70 isAlienShoot:YES alienSimplePercent:30 shootPercent:0.4];
    [lDescr setupShipWithTimesCount:2 appearenceTime:20 isShoot:YES isDrop:YES shootPercent:0.1];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_SIMPLE withCount:count_4_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_COMPLEX withCount:count_4_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_SIMPLE withCount:count_5_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_COMPLEX withCount:count_5_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK withCount:count_MOON_ROCKS_2_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES withCount:count_MOON_ROCKS_3_ALTITUDES];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK withCount:count_MOON_ROCKS_3_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK withCount:count_MOON_ROCKS_KUPOL_ROCK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER withCount:count_MOON_ROCKS_KUPOL_CRATER];
    [levelDict setObject:lDescr forKey:@"9"];
    
    count_4_ALIENS_SIMPLE += 0;
    count_4_ALIENS_COMPLEX += 0;
    count_5_ALIENS_SIMPLE += 1;
    count_5_ALIENS_COMPLEX += 1;
    count_MOON_ROCKS_2_ALTITUDES_BACK += 0;
    count_MOON_ROCKS_3_ALTITUDES += 0;
    count_MOON_ROCKS_3_ALTITUDES_BACK += 0;
    count_MOON_ROCKS_KUPOL_CRATER += 1;
    count_MOON_ROCKS_KUPOL_ROCK += 2;
    /*
    lDescr = [[[LevelDescription alloc] initWithLengthInSec:10] autorelease]; //!!!!!
    [lDescr setupAliensWithCount:80 isAlienShoot:YES alienSimplePercent:30 shootPercent:0.4];
    [lDescr setupShipWithTimesCount:1 appearenceTime:lDescr.lengthInSec isShoot:YES isDrop:YES shootPercent:0.1];*/
    
    lDescr = [[LevelDescription alloc] initWithLengthInSec:110];
    [lDescr setupAliensWithCount:80 isAlienShoot:YES alienSimplePercent:30 shootPercent:0.4];
    [lDescr setupShipWithTimesCount:1 appearenceTime:lDescr.lengthInSec isShoot:YES isDrop:YES shootPercent:0.1];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_SIMPLE withCount:count_4_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__4_ALIENS_COMPLEX withCount:count_4_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_SIMPLE withCount:count_5_ALIENS_SIMPLE];
    [lDescr addBunchesOfType:BUNCH_TYPE__5_ALIENS_COMPLEX withCount:count_5_ALIENS_COMPLEX];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK withCount:count_MOON_ROCKS_2_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES withCount:count_MOON_ROCKS_3_ALTITUDES];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK withCount:count_MOON_ROCKS_3_ALTITUDES_BACK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK withCount:count_MOON_ROCKS_KUPOL_ROCK];
    [lDescr addBunchesOfType:BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER withCount:count_MOON_ROCKS_KUPOL_CRATER];
    [levelDict setObject:lDescr forKey:@"10"];
    
    [self.descrDictionary setObject:levelDict forKey:DESCR_KEY_LEVELS];
}

- (void)setupBooletDescription {
    NSMutableDictionary *booletDict = [NSMutableDictionary dictionary];
    
    BulletDescription *bDescr;
    
    bDescr = [[BulletDescription alloc] initWithName:BULLET_TYPE_BASIC speed:400 damage:1 damageRadius:16 imageName:@"soplya.png"];
    [booletDict setObject:bDescr forKey:bDescr.name];
    
    bDescr = [[BulletDescription alloc] initWithName:BULLET_TYPE_RAPID speed:400 damage:1 damageRadius:16 imageName:@"soplya.png"];
    [booletDict setObject:bDescr forKey:bDescr.name];
    
    bDescr = [[BulletDescription alloc] initWithName:BULLET_TYPE_PLASMA speed:400 damage:10 damageRadius:16 imageName:@"soplya2.png"];
    [booletDict setObject:bDescr forKey:bDescr.name];
    
    bDescr = [[BulletDescription alloc] initWithName:BULLET_TYPE_ROCKET speed:400 damage:10 damageRadius:200 imageName:@"shooted_rocket.png"];
    [booletDict setObject:bDescr forKey:bDescr.name];
    
    [self.descrDictionary setObject:booletDict forKey:DESCR_KEY_BULLET];
}

- (void)setupWeaponDescription {
    NSMutableDictionary *weaponDict = [NSMutableDictionary dictionary];
    
    WeaponDescription *wDescr;
    
    wDescr = [[WeaponDescription alloc] initWithBulletDescrName:BULLET_TYPE_BASIC fireRate:0.8 weight:0 controlLayerIcon:@"laser_indicator.png"];
    [weaponDict setObject:wDescr forKey:WEAPON_TYPE_BASIC];
    
    wDescr = [[WeaponDescription alloc] initWithBulletDescrName:BULLET_TYPE_RAPID fireRate:0.4 weight:0 controlLayerIcon:@"laser_indicator.png"];
    [weaponDict setObject:wDescr forKey:WEAPON_TYPE_RAPID];
    
    wDescr = [[WeaponDescription alloc] initWithBulletDescrName:BULLET_TYPE_PLASMA fireRate:0.5 weight:0 controlLayerIcon:@"plasma_indicator.png"];
    [weaponDict setObject:wDescr forKey:WEAPON_TYPE_PLASMA];
    
    wDescr = [[WeaponDescription alloc] initWithBulletDescrName:BULLET_TYPE_ROCKET fireRate:0.5 weight:0 controlLayerIcon:@"rocketluncher_indicator.png"];
    [weaponDict setObject:wDescr forKey:WEAPON_TYPE_ROCKET];
    
    [self.descrDictionary setObject:weaponDict forKey:DESCR_KEY_WEAPON];
}



- (void)setupBunchesDescriptions {
    NSMutableDictionary *bunchesDict = [NSMutableDictionary dictionary];
    
    GameObjectsBunch *res_gob;
    
    res_gob = [Bunches setupBunchKupolOnAltitude:MOON_ROCK_ALTITUDE11 withMiddleObjType:OBJ_TYPE_STONE];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK];
    
    res_gob = [Bunches setupBunchKupolOnAltitude:MOON_ROCK_ALTITUDE21 withMiddleObjType:OBJ_TYPE_CRATER];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER];
    
    res_gob = [Bunches setupBunchMoonrocksIn3AltitudesOneByOne];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES];
    
    res_gob = [Bunches setupBunchMoonrocksIn3AltitudesOneByOneBack];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK];
    
    res_gob = [Bunches setupBunchMoonrocksIn2AltitudesOneByOneBack];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK];
    
    
    // ----- Aliens
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_GREEN withCount:5];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__5_GREEN_ALIENS];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_GREEN withCount:4];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__4_GREEN_ALIENS];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_GREEN withCount:3];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__3_GREEN_ALIENS];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_GREEN withCount:2];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__2_GREEN_ALIENS];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_GREEN withCount:1];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__1_GREEN_ALIENS];
    
    
    // ----- simple Aliens
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_SIMLE withCount:5];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__5_ALIENS_SIMPLE];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_SIMLE withCount:4];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__4_ALIENS_SIMPLE];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_SIMLE withCount:3];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__3_ALIENS_SIMPLE];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_SIMLE withCount:2];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__2_ALIENS_SIMPLE];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_SIMLE withCount:1];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__1_ALIENS_SIMPLE];
    
    
    // ----- complex Aliens
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_COMPLEX withCount:5];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__5_ALIENS_COMPLEX];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_COMPLEX withCount:4];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__4_ALIENS_COMPLEX];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_COMPLEX withCount:3];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__3_ALIENS_COMPLEX];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_COMPLEX withCount:2];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__2_ALIENS_COMPLEX];
    
    res_gob = [Bunches setupBunchOfObjType:OBJ_TYPE_ALIEN_COMPLEX withCount:1];
    [bunchesDict  setObject:res_gob forKey:BUNCH_TYPE__1_ALIENS_COMPLEX];
    
    
    
    [self.descrDictionary setObject:bunchesDict forKey:DESCR_KEY_BUNCHES];
}


#pragma mark - Interface funcs
- (id)getObjectByKey:(NSString *)key andSubKey:(NSString *)subKey {
    id retVal = nil;
    if (key && subKey) {
        NSDictionary *subKeysDict = [self.descrDictionary objectForKey:key];
        if (subKeysDict) {
            retVal = [subKeysDict objectForKey:subKey];
        }
    }
    return retVal;
}

@end


