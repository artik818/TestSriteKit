//
//  Crater.m
//  NewMoonSkater
//
//  Created by Artem on 12/12/12.
//
//


#import <SpriteKit/SpriteKit.h>

#import "Crater.h"
#import "Constants.h"

@interface Crater()

@end





@implementation Crater

#pragma mark - Life cycle
- (id)initWithObjType:(NSInteger)objType {
	if (self = [super initWithObjType:objType]) {
        [self setupSprite:self withImageNamed:@"crater.png"];
	}
	return self;
}


#pragma mark - CollisionsProtocol
- (void)youAreInCollisionWithObject:(MovableObject *)gameObject {
    //self.isAffectCollisions = NO;
}


@end
