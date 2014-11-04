//
//  Skater.h
//  NewMoonSkater
//
//  Created by Artem on 12/3/12.
//
//

#import <Foundation/Foundation.h>

#import "BaseGameObjectsClasses.h"
//#import "WeaponDescription.h"



@protocol SkaterControlProtocol <NSObject>

- (void)jumpButtonPressed:(BOOL)isPressDown;
- (void)shootButtonPressed:(BOOL)isPressDown;
- (void)changeWeaponTypeTo:(NSString *)newWeaponType;
- (void)changeExtraToState:(BOOL)isExtra;

@end



@protocol SkaterDelegate <NSObject>

- (void)skaterBeginToDeath;
- (void)skaterDied;
- (void)skaterEnergyChanged:(CGFloat)newEnergy;
- (void)skaterShootedWithBulletName:(NSString *)bulletName;

@end




@interface Skater : MovableObject <SkaterControlProtocol>

@property (nonatomic, assign) id<SkaterDelegate> skaterDelegate;
@property (nonatomic, readonly) NSInteger jumpCounter;
@property (nonatomic, readonly) BOOL currIsExtra;                               // есть ли сейчас у скейтера режим Экстра
@property (nonatomic) NSInteger currentWeaponBulletsCount;


@end
