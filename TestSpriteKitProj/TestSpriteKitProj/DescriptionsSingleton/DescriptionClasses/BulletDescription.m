//
//  BooletDescription.m
//  NewMoonSkater
//
//  Created by Artem on 12/4/12.
//
//

#import "BulletDescription.h"

@interface BulletDescription()

@end





@implementation BulletDescription

@synthesize name = _name;
@synthesize speed = _speed;
@synthesize damage = _damage;
@synthesize damageRadius = _damageRadius;
@synthesize imageName = _imageName;

- (id)initWithName:(NSString *)name speed:(CGFloat)speed damage:(CGFloat)damage damageRadius:(CGFloat)damageRadius imageName:(NSString *)imageName {
    if (self = [super init]) {
        _name = [NSString stringWithString:name];
        _speed = speed;
        _damage = damage;
        _damageRadius = damageRadius;
        self.imageName = imageName;
    }
    return self;
}

@end
