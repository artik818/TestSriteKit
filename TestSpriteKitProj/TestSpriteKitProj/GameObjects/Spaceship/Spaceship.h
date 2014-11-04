//
//  Spaceship.h
//  NewMoonSkater
//
//  Created by Artem on 12/19/12.
//
//

#import "BaseGameObjectsClasses.h"

@interface Spaceship : MovableObject

@property (nonatomic) BOOL isToDropAliens;
@property (nonatomic) BOOL isToShoot;

- (void)appearInPoint:(CGPoint)endPOint;
- (void)appearForTime:(CGFloat)timeSec inPoint:(CGPoint)endPOint;
- (void)dropAlienOfType:(NSInteger)objType;
- (void)shipGoAway;

@end
