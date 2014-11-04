//
//  BooletDescription.h
//  NewMoonSkater
//
//  Created by Artem on 12/4/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define BULLET_TYPE_BASIC                   @"BULLET_TYPE_BASIC"
#define BULLET_TYPE_RAPID                   @"BULLET_TYPE_RAPID"
#define BULLET_TYPE_PLASMA                  @"BULLET_TYPE_PLASMA"
#define BULLET_TYPE_ROCKET                  @"BULLET_TYPE_ROCKET"


@interface BulletDescription: NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic) CGFloat speed;
@property (nonatomic) CGFloat damage;
@property (nonatomic) CGFloat damageRadius;
@property (nonatomic, retain) NSString *imageName;

- (id)initWithName:(NSString *)name speed:(CGFloat)speed damage:(CGFloat)damage damageRadius:(CGFloat)damageRadius imageName:(NSString *)imageName;

@end
