//
//  EnergyMeter.m
//  NewMoonSkater
//
//  Created by Artem on 12/19/12.
//
//

#import "EnergyMeter.h"
#import "GameObjectsUtils.h"

@interface EnergyMeter() {
    CCSprite *energyMeterRed;
}

@property (nonatomic) CGFloat maxVal;
@property (nonatomic) CGFloat currVal;

@end




@implementation EnergyMeter

@synthesize  maxVal = _maxVal;
@synthesize currVal = _currVal;


#pragma mark - Life cycle

+ (id)nodeWithMaxVal:(NSInteger)maxVal currVal:(NSInteger)currVal isBig:(BOOL)isBig {
    return [[[self alloc] initWithMaxVal:maxVal currVal:currVal isBig:isBig] autorelease];
}

- (id)initWithMaxVal:(NSInteger)maxVal currVal:(NSInteger)currVal isBig:(BOOL)isBig {
    if (self = [super init]) {
        _maxVal = maxVal;
        _currVal = _currVal;
        
        NSString *imageName;
        
        imageName = (isBig)?@"boss_health_back.png":@"alien_big_health_back.png";
        [GameObjectsUtils setupSprite:self withImageNamed:imageName];
        
        energyMeterRed = [CCSprite node];
        imageName = (isBig)?@"boss_health_redline.png":@"alien_big_health_redline.png";
        [GameObjectsUtils setupSprite:energyMeterRed withImageNamed:imageName];
        energyMeterRed.anchorPoint = ccp(0, 0.5);
        energyMeterRed.position = ccp(2, energyMeterRed.boundingBox.size.height / 2 + 1);
        
        [self addChild:energyMeterRed];
    }
    return self;
}

- (void)updateWithCurrentVal:(CGFloat)currVal {
    self.currVal = currVal;
    if (self.currVal <= 0) {
        energyMeterRed.visible = NO;
        //energyMeterRed.scaleX = 0;
    }
    else {
        CGFloat currV = self.currVal;
        energyMeterRed.scaleX = (currV / self.maxVal);
    }
}

@end
