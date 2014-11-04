//
//  BaseGameObjectsClasses.m
//  NewMoonSkater
//
//  Created by Artem on 11/30/12.
//
//

#import "WeaponDescription.h"

@interface WeaponDescription()

@end





@implementation WeaponDescription

@synthesize weight = _weight;
@synthesize fireRateSec = _fireRateSec;
@synthesize bulletDescrName = _bulletDescrName;
@synthesize controlLayerIconName = _controlLayerIconName;

- (id)initWithBulletDescrName:(NSString *)bulletDescrName fireRate:(CGFloat)fireRate weight:(CGFloat)weight controlLayerIcon:(NSString *)controlLayerIcon {
    if (self = [super init]) {
        _bulletDescrName = bulletDescrName;
        _controlLayerIconName = controlLayerIcon;
        _fireRateSec = fireRate;
        _weight = weight;
        
    }
    return self;
}

@end