//
//  Bullet.m
//  NewMoonSkater
//
//  Created by Artem on 12/5/12.
//
//

#import "Bullet.h"
#import "DescriptionsSingleton.h"
#import "Constants.h"
#import "Bang.h"
#import "Skater.h"


@interface Bullet()

@end




@implementation Bullet

@synthesize bulletDescr = _bulletDescr;


#pragma mark - Life cycle
+ (id)nodeWithObjType:(NSInteger)objType bulletDescrName:(NSString *)bulletDescrName {
    return [[[self alloc] initWithObjType:objType bulletDescrName:bulletDescrName] autorelease];
}

- (id)initWithObjType:(NSInteger)objType bulletDescrName:(NSString *)bulletDescrName {
    if (self = [super initWithObjType:objType]) {
        _bulletDescr = [[DescriptionsSingleton sharedManager] getObjectByKey:DESCR_KEY_BULLET andSubKey:bulletDescrName];
        [self setupSprite:self withImageNamed:_bulletDescr.imageName];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark - CollisionsProtocol
- (void)youAreInCollisionWithObject:(MovableObject *)gameObject {
    if ((gameObject.objType != OBJ_TYPE_MOONROCK) && (gameObject.objType != OBJ_TYPE_BANG)) { // все, исключая мунроки и взрывы
        if (gameObject.objType == OBJ_TYPE_SKATER) { // фрицная пуля врезалась в нас
            Skater *skater = (Skater *)gameObject;
            if (!skater.currIsExtra) { // не экстра режим
                self.isAffectCollisions = NO;
                self.iAmDead = YES;
                // породить взрыв с радиусом и силой ...
                [self createBang];
            }
        }
        else {
            self.isAffectCollisions = NO;
            self.iAmDead = YES;
            // породить взрыв с радиусом и силой ...
            [self createBang];
        }
    }
}

- (CGRect)collisionRect {
    //return CGRectInset([super collisionRect], 3, 0);
    
    
    CGFloat width = 10;
    CGFloat left = self.position.x - (width / 2);
    return CGRectMake(left, self.position.y, width, 2);
}




#pragma mark - Utils
- (void)createBang {
    Bang *bang = [Bang nodeWithObjType:OBJ_TYPE_BANG bulletDescrName:self.bulletDescr.name];
    bang.collisionSideId = self.collisionSideId;
    //[bang setupSpeed: withAngle:180 rotate:NO];
    bang.position = self.position;
    [self.objectsCreationDelegate createdMovableObject:bang];
}

@end

