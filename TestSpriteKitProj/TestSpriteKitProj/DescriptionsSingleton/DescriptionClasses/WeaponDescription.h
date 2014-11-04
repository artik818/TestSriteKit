//
//  BaseGameObjectsClasses.h
//  NewMoonSkater
//
//  Created by Artem on 11/30/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define WEAPON_TYPE_BASIC                   @"WEAPON_TYPE_BASIC"
#define WEAPON_TYPE_RAPID                   @"WEAPON_TYPE_RAPID"
#define WEAPON_TYPE_PLASMA                  @"WEAPON_TYPE_PLASMA"
#define WEAPON_TYPE_ROCKET                  @"WEAPON_TYPE_ROCKET"


@interface WeaponDescription: NSObject

@property (nonatomic) CGFloat weight;
@property (nonatomic) CGFloat fireRateSec;          // время в секундах до следующего выстрела
@property (nonatomic, retain) NSString *bulletDescrName;
@property (nonatomic, retain) NSString *controlLayerIconName;

- (id)initWithBulletDescrName:(NSString *)bulletDescrName fireRate:(CGFloat)fireRate weight:(CGFloat)weight controlLayerIcon:(NSString *)controlLayerIcon;

@end




