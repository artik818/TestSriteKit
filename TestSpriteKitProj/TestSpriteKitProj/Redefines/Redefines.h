//
//  Redefines.h
//  TestSpriteKitProj
//
//  Created by Artem on 11/4/14.
//  Copyright (c) 2014 Artem. All rights reserved.
//

#ifndef TestSpriteKitProj_Redefines_h
#define TestSpriteKitProj_Redefines_h


#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>



#define ccTime CGFloat
#define CCSprite SKSpriteNode
#define CCLayer SKNode
#define spriteWithSpriteFrameName spriteNodeWithImageNamed
#define boundingBox frame
#define ccp CGPointMake

#define autorelease nopAutorelease
#define release nopRelease



static inline CGPoint ccpMult(CGPoint sourcePoint, CGFloat dt)
{
    return (CGPoint){sourcePoint.x * dt, sourcePoint.y * dt};
}

static inline CGPoint ccpAdd(CGPoint sourcePoint, CGPoint dt)
{
    return (CGPoint){sourcePoint.x + dt.x, sourcePoint.y * dt.y};
}


@interface NSObject (Redefines)
- (instancetype)nopAutorelease;
- (void)nopRelease;
@end


#endif
