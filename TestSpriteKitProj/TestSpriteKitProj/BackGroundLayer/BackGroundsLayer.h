//
//  BackGroundsLayer.h
//  NewMoonSkater
//
//  Created by Artem on 12/3/12.
//
//

#import <Foundation/Foundation.h>

#import "PodBackGround.h"
#import "Redefines.h"


@interface BackGroundsLayer : CCLayer <MovableObjectsProtocol>

@property (nonatomic) CGPoint velocity;

- (void)update:(ccTime)dt;

@end
