//
//  Redefines.m
//  TestSpriteKitProj
//
//  Created by Artem on 11/4/14.
//  Copyright (c) 2014 Artem. All rights reserved.
//

#import <Foundation/Foundation.h>


@implementation NSObject (Redefines)
- (instancetype)nopAutorelease
{
    return self;
}

- (void)nopRelease
{
}

@end
