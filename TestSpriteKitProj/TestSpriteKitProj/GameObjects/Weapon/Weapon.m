//
//  Weapon.m
//  NewMoonSkater
//
//  Created by Artem on 12/5/12.
//
//

#import "Weapon.h"
#import "DescriptionsSingleton.h"

@interface Weapon()

@end




@implementation Weapon

@synthesize weaponDescr = _weaponDescr;
@synthesize bulletDescr = _bulletDescr;
@synthesize lastShootDuration = _lastShootDuration;
@synthesize isShootingNow = _isShootingNow;
@synthesize canShoot = _canShoot;
@synthesize bulletsCount = _bulletsCount;
@synthesize weaponDescrName = _weaponDescrName;

#pragma mark - Life cycle
- (id)initWithWeaponDescrName:(NSString *)weaponDescrName {
    if (self = [super init]) {
        _weaponDescr = [[DescriptionsSingleton sharedManager] getObjectByKey:DESCR_KEY_WEAPON andSubKey:weaponDescrName];;
        _bulletDescr = [[DescriptionsSingleton sharedManager] getObjectByKey:DESCR_KEY_BULLET andSubKey:_weaponDescr.bulletDescrName];
        _canShoot = YES;
        _bulletsCount = 0;
        _weaponDescrName = [weaponDescrName retain];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
