//
//  Stone.m
//  NewMoonSkater
//
//  Created by Artem on 12/11/12.
//
//

#import "Stone.h"
#import "Constants.h"
#import "Bang.h"

@interface Stone()

@end





@implementation Stone

#pragma mark - Life cycle
- (id)initWithObjType:(NSInteger)objType {
	if (self = [super initWithObjType:objType]) {
        [self setupSprite:self withImageNamed:@"stone_big.png"];
        [self setupSmallBangAnimation];
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark - CollisionsProtocol
- (void)youAreInCollisionWithObject:(MovableObject *)gameObject {
    switch (gameObject.objType) {
        case OBJ_TYPE_BANG: {
            Bang *bang = (Bang *)gameObject;
            if ([bang.bulletDescr.name isEqualToString:BULLET_TYPE_PLASMA] || [bang.bulletDescr.name isEqualToString:BULLET_TYPE_ROCKET]) {
                self.isAffectCollisions = NO;
                //self.iAmDead = YES;
                [self animateSmallBang];
            }
        }
        break;
    }
}


@end
