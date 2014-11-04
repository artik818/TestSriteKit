//
//  Bunches.m
//  NewMoonSkater
//
//  Created by Artem on 12/24/12.
//
//

#import "Bunches.h"
#import "BaseGameObjectsClasses.h"
#import "Constants.h"
#import "GameObjectsUtils.h"



CGPoint deltasArrayPolukrug[] = {
    {0,      0},
    {10,     15},
    {15,     12},
    {18,     8},
    {20,     5},
    {0,      0},
};

CGPoint deltasArrayZigZag[] = {
    {0,      0},
    {20,     20},
    {20,     -20},
    {20,     20},
    {20,     -20},
    {20,     20},
    {20,     -20},
    {20,     20},
    {20,     -20},
    {20,     20},
};

#define delta2LinesX  25
CGPoint deltasArray2Lines[] = {
    {0, 0},
    {0, 20},
    {delta2LinesX, -20},
    {0, 20},
    {delta2LinesX, -20},
    {0, 20},
    {delta2LinesX, -20},
    {0, 20},
    {delta2LinesX, -20},
    {0, 20},
};



@implementation Bunches


#pragma mark - Bunches
+ (GameObjectsBunch *)setupBunchOfObjType:(NSInteger)objType withCount:(NSInteger)objectsCount {
    GameObjectsBunch *res_gob = [GameObjectsBunch nodeWithObjType:OBJ_TYPE_ARRAY_OF_OBJECTS];
    GameObjectsBunch *gob;
    
    //----------------------------------------------------------
    // преобразование неопределенных типов чужих - в определенный
    if (OBJ_TYPE_ALIEN_SIMLE == objType) {
        objType = [GameObjectsUtils getRandomTypeOfAlienFromSimples];
    }
    if (OBJ_TYPE_ALIEN_COMPLEX == objType) {
        objType = [GameObjectsUtils getRandomTypeOfAlienFromComplex];
    }
    
    //----------------------------------------------------------
    CGFloat dObject = 20;
    for (int i=0; i<objectsCount; i++) {
        gob = [GameObjectsBunch nodeWithObjType:objType];
        gob.bunchPosition = CGPointMake(dObject * i, 0);
        [res_gob addChild:gob];
    }
    
    //----------------------------------------------------------
    
    res_gob.bunchLevel = 0;
    res_gob.bunchSize = CGSizeMake(dObject * (objectsCount + 1), 100);
    
    return res_gob;
}


+ (GameObjectsBunch *)setupBunchMoonRockKupol {
    GameObjectsBunch *res_gob = [GameObjectsBunch nodeWithObjType:OBJ_TYPE_ARRAY_OF_OBJECTS];
    GameObjectsBunch *gob;
    CGSize bSize;
    //----------------------------------------------------------
    
    NSInteger count = sizeof(deltasArrayPolukrug) / sizeof(CGPoint);
    
    gob = [self setupBunchOfObjType:OBJ_TYPE_MOONROCK withDeltas:deltasArrayPolukrug withSize:count andDirection:0];
    gob.bunchPosition = CGPointMake(0, 0);
    [res_gob addChild:gob];
    bSize = gob.bunchSize;
    
    gob = [self setupBunchOfObjType:OBJ_TYPE_MOONROCK withDeltas:deltasArrayPolukrug withSize:count andDirection:1];
    gob.bunchPosition = CGPointMake(bSize.width + 20, 0);
    [res_gob addChild:gob];
    
    //----------------------------------------------------------
    
    res_gob.bunchLevel = 0;
    res_gob.bunchSize = CGSizeMake(gob.bunchSize.width * 2 + 20, gob.bunchSize.height);
    
    return res_gob;
}


+ (GameObjectsBunch *)setupBunchMoonrocksInOneByOneOnAltitudes:(CGFloat [])altitudesArray withCount:(NSInteger)elementsCount withDelta:(CGFloat)delta {
    GameObjectsBunch *res_gob = [GameObjectsBunch nodeWithObjType:OBJ_TYPE_ARRAY_OF_OBJECTS];
    GameObjectsBunch *gob;
    CGSize bSize = CGSizeZero;
    
    NSInteger countDeltas = sizeof(deltasArray2Lines) / sizeof(CGPoint);
    
    for (int i=0; i<elementsCount; ++i) {
        gob = [self setupBunchOfObjType:OBJ_TYPE_MOONROCK withDeltas:deltasArray2Lines withSize:countDeltas andDirection:0];
        bSize = gob.bunchSize;
        gob.bunchPosition = CGPointMake((bSize.width + delta) * i, altitudesArray[i] - (bSize.height / 2));
        [res_gob addChild:gob];
    }
    
    res_gob.bunchLevel = 0;
    res_gob.flIsCanCreateObsticlesInCurrentBunch = YES;
    res_gob.bunchSize = CGSizeMake((bSize.width + delta) * elementsCount, bSize.height);
    
    return res_gob;
}

+ (GameObjectsBunch *)setupBunchMoonrocksIn3AltitudesOneByOne {
    GameObjectsBunch *res_gob;
    
    CGFloat altitudesArray[] = {
        MOON_ROCK_ALTITUDE01, MOON_ROCK_ALTITUDE11, MOON_ROCK_ALTITUDE21,
    };
    NSInteger countAltitudes = sizeof(altitudesArray) / sizeof(altitudesArray[0]);
    
    CGFloat delta = 30;
    res_gob = [self setupBunchMoonrocksInOneByOneOnAltitudes:altitudesArray withCount:countAltitudes withDelta:delta];
    
    return res_gob;
}

+ (GameObjectsBunch *)setupBunchMoonrocksIn3AltitudesOneByOneBack {
    GameObjectsBunch *res_gob;
    
    CGFloat altitudesArray[] = {
        MOON_ROCK_ALTITUDE21, MOON_ROCK_ALTITUDE11, MOON_ROCK_ALTITUDE01,
    };
    NSInteger countAltitudes = sizeof(altitudesArray) / sizeof(altitudesArray[0]);
    
    CGFloat delta = 30;
    res_gob = [self setupBunchMoonrocksInOneByOneOnAltitudes:altitudesArray withCount:countAltitudes withDelta:delta];
    
    return res_gob;
}

+ (GameObjectsBunch *)setupBunchMoonrocksIn2AltitudesOneByOneBack {
    GameObjectsBunch *res_gob;
    
    CGFloat altitudesArray[] = {
        MOON_ROCK_ALTITUDE21, MOON_ROCK_ALTITUDE11,
    };
    NSInteger countAltitudes = sizeof(altitudesArray) / sizeof(altitudesArray[0]);
    
    CGFloat delta = 150;
    res_gob = [self setupBunchMoonrocksInOneByOneOnAltitudes:altitudesArray withCount:countAltitudes withDelta:delta];
    
    return res_gob;
}


+ (GameObjectsBunch *)setupBunchKupolOnAltitude:(CGFloat)altitude withMiddleObjType:(NSInteger)objType {
    GameObjectsBunch *res_gob = [GameObjectsBunch nodeWithObjType:OBJ_TYPE_ARRAY_OF_OBJECTS];
    GameObjectsBunch *gob;
    
    CGSize bSize;
    CGFloat bHeight;
    
    // kupol
    gob = [self setupBunchMoonRockKupol];
    CGFloat bYPos = altitude - (gob.bunchSize.height / 2);
    gob.bunchPosition = ccp(0, bYPos);
    [res_gob addChild:gob];
    
    bSize = gob.bunchSize;
    bHeight = altitude + (gob.bunchSize.height / 2);
    
    // crater
    gob = [GameObjectsBunch nodeWithObjType:objType];
    gob.bunchPosition = CGPointMake(bSize.width / 2, 0);
    [res_gob addChild:gob];
    
    // res
    res_gob.bunchLevel = 0;
    res_gob.bunchSize = CGSizeMake(bSize.width, bHeight);
    
    return res_gob;
}



+ (CGSize)getBunchSizeFromDeltas:(CGPoint [])deltas withSize:(NSInteger)deltasSize {
    CGFloat resH = 0;
    CGFloat resW = 0;
    CGFloat currH = 0;
    CGFloat currW = 0;
    
    for (int i=0; i<deltasSize; ++i) {
        currH += deltas[i].y;
        currW += deltas[i].x;
        if (currH > resH) {
            resH = currH;
        }
        if (currW > resW) {
            resW = currW;
        }
    }
    return CGSizeMake(resW, resH);
}


+ (GameObjectsBunch *)setupBunchOfObjType:(NSInteger)objType withDeltas:(CGPoint [])deltas withSize:(NSInteger)deltasSize andDirection:(NSInteger)leftOrRight {
    GameObjectsBunch *res_gob = [GameObjectsBunch nodeWithObjType:OBJ_TYPE_ARRAY_OF_OBJECTS];
    GameObjectsBunch *gob;
    
    CGFloat x = 0, y = 0;
    CGSize bSize = [self getBunchSizeFromDeltas:deltas withSize:deltasSize];
    if (leftOrRight) {
        y = bSize.height;
        
        for (int t=deltasSize; t>0; t--) {
            x += deltas[t].x;
            y -= deltas[t].y;
            
            gob = [GameObjectsBunch nodeWithObjType:objType];
            gob.bunchPosition = CGPointMake(x, y);
            [res_gob addChild:gob];
        }
    }
    else {
        for (int t=0; t<deltasSize; t++) {
            x += deltas[t].x;
            y += deltas[t].y;
            
            gob = [GameObjectsBunch nodeWithObjType:objType];
            gob.bunchPosition = CGPointMake(x, y);
            [res_gob addChild:gob];
        }
    }
    res_gob.bunchLevel = 0;
    res_gob.bunchSize = CGSizeMake(bSize.width, bSize.height);
    return res_gob;
}


@end
