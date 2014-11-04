//
//  Bang.m
//  NewMoonSkater
//
//  Created by Artem on 12/17/12.
//
//

#import "Bang.h"
#import "DescriptionsSingleton.h"
#import "Constants.h"

@implementation Bang

@synthesize bulletDescr = _bulletDescr;


#pragma mark - Life cycle
+ (id)nodeWithObjType:(NSInteger)objType bulletDescrName:(NSString *)bulletDescrName {
    return [[[self alloc] initWithObjType:objType bulletDescrName:bulletDescrName] autorelease];
}

- (id)initWithObjType:(NSInteger)objType bulletDescrName:(NSString *)bulletDescrName {
    if (self = [super initWithObjType:objType]) {
        _bulletDescr = [[DescriptionsSingleton sharedManager] getObjectByKey:DESCR_KEY_BULLET andSubKey:bulletDescrName];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark - CollisionsProtocol
- (void)youAreInCollisionWithObject:(MovableObject *)gameObject {
    if ((gameObject.objType != OBJ_TYPE_MOONROCK) && (gameObject.objType != OBJ_TYPE_BANG)) { // все, исключая мунроки и взрывы
        //self.isAffectCollisions = NO; // закоменчено для того, чтоб пришло всем объектам в радиусе поражения
        self.iAmDead = YES; // и потом уже собралось сборщиком мусора
    }
}

- (CGRect)collisionRect {
    CGFloat width = self.bulletDescr.damageRadius;
    //CGFloat left = self.position.x - (width * 0.2);
    CGFloat left = self.position.x - (width / 2);
    return CGRectMake(left, self.position.y, width, 10);
}



@end
