//
//  EnergyMeter.h
//  NewMoonSkater
//
//  Created by Artem on 12/19/12.
//
//

enum EnergyMeterSides {
    EN_METER_TOP,
    EN_METER_BOTTOM,
};



@interface EnergyMeter : SKSpriteNode

+ (id)nodeWithMaxVal:(NSInteger)maxVal currVal:(NSInteger)currVal isBig:(BOOL)isBig;

- (void)updateWithCurrentVal:(CGFloat)currVal;

@end
