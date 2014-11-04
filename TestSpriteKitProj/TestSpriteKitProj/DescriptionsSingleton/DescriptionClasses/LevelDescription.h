//
//  LevelDescription.h
//  NewMoonSkater
//
//  Created by Artem on 12/26/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LevelDescription : NSObject

@property (nonatomic) CGFloat lengthInSec;                  // длина зоны в секундах
@property (nonatomic) NSInteger moonrocksCount;             // предполагаемое количество мунроков на зону
@property (nonatomic) NSInteger aliensCount;                // предполагаемое количество алиенов
@property (nonatomic) BOOL isAliensShoot;                   // стреляют ли А-ы
@property (nonatomic) CGFloat alienShootPercent;            // вероятность выстрела А-ом
@property (nonatomic) CGFloat alienSimplePercent;           // процент появления простых (с одного выстрела) А-ов ! процент трехочковых А-ов = 100 - alienSimplePercent
@property (nonatomic) NSInteger spaceshipTimesCount;        // кол-во раз, которые космический корабль должен появиться на зоне
@property (nonatomic) CGFloat spaceshipTimeSec;             // время, на которое КК появляется в секундах
@property (nonatomic) BOOL isSpaceshipShoot;                // стреляет ли КК
@property (nonatomic) BOOL isSpaceshipDropAliens;           // дропает ли КК А-ов
@property (nonatomic) CGFloat spaceshipShootPercent;        // вероятность выстрела КК
@property (nonatomic, retain) NSMutableArray *bunches;      // банчи, которые должны быть на зоне и их количество


- (id)initWithLengthInSec:(CGFloat)lengthInSec;
- (void)setupMoonrocksWithCount:(NSInteger)moonrocksCount;
- (void)setupAliensWithCount:(NSInteger)count isAlienShoot:(BOOL)isAlienShoot alienSimplePercent:(CGFloat)simplePercent shootPercent:(CGFloat)shootPercent;
- (void)setupShipWithTimesCount:(NSInteger)timesCount appearenceTime:(CGFloat)spaceshipTimeSec isShoot:(BOOL)isShoot isDrop:(BOOL)isDrop shootPercent:(CGFloat)shootPercent;
- (void)addBunchesOfType:(NSString *)bunchType withCount:(NSInteger)count;
- (void)printCountsOfObjectsOfTypes;

@end
