//
//  PodBackGround.h
//  NewMoonSkater
//
//  Created by Artem on 12/3/12.
//
//

#import <Foundation/Foundation.h>

#import "GameObjectsProtocols.h"
#import "Redefines.h"



@interface PodBackGround : NSObject <MovableObjectsProtocol>

- (id)initWithSpritesArray:(NSArray *)spritesArray velocity:(CGPoint)velocity velocityKoef:(CGPoint)velocityKoef;
- (id)initWithSpritesArray:(NSArray *)spritesArray;

@end
