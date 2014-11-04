//
//  Bang.h
//  NewMoonSkater
//
//  Created by Artem on 12/17/12.
//
//

#import <Foundation/Foundation.h>
#import "BaseGameObjectsClasses.h"
#import "BulletDescription.h"


@interface Bang : MovableObject

@property (nonatomic, assign) BulletDescription *bulletDescr;

+ (id)nodeWithObjType:(NSInteger)objType bulletDescrName:(NSString *)bulletDescrName;


@end
