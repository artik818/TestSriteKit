//
//  Moonrock.h
//  NewMoonSkater
//
//  Created by Artem on 12/12/12.
//
//

#import "BaseGameObjectsClasses.h"


@protocol MoonrockDelegate <NSObject>
- (void)moonRockCollected;
@end




@interface Moonrock : MovableObject

@property (nonatomic) CGPoint endPoint; // точка, в которую будут слетаться все мунроки при коллекционировании
@property (nonatomic, assign) id<MoonrockDelegate> delegateMoonrock;

@end
