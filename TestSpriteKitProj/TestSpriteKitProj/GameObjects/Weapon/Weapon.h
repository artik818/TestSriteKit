//
//  Weapon.h
//  NewMoonSkater
//
//  Created by Artem on 12/5/12.
//
//

#import <Foundation/Foundation.h>

#import "WeaponDescription.h"
#import "BulletDescription.h"



@interface Weapon : NSObject

@property (nonatomic) CGFloat lastShootDuration;
@property (nonatomic, assign) WeaponDescription *weaponDescr;
@property (nonatomic, assign) BulletDescription *bulletDescr;
@property (nonatomic) BOOL isShootingNow;
@property (nonatomic) BOOL canShoot;
@property (nonatomic) NSInteger bulletsCount;
@property (nonatomic, retain) NSString *weaponDescrName;

- (id)initWithWeaponDescrName:(NSString *)weaponDescrName;

@end

