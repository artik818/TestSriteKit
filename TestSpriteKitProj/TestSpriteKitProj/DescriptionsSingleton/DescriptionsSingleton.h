//
//  DescriptionsSingleton.h
//  NewMoonSkater
//
//  Created by Artem on 12/4/12.
//
//

#import <Foundation/Foundation.h>

#define DESCR_KEY_LEVELS                @"LEVELS_DESCR"
#define DESCR_KEY_WEAPON                @"WEAPON_DESCR"
#define DESCR_KEY_BULLET                @"BULLET_DESCR"
#define DESCR_KEY_BUNCHES               @"BUNCHES_DESCR"
#define BUNCHES_DESCR_BY_LEVELS         @"BUNCHES_DESCR_BY_LEVELS"



#define BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK                           @"BUNCH_TYPE__MOON_ROCKS_KUPOL_ROCK"
#define BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER                         @"BUNCH_TYPE__MOON_ROCKS_KUPOL_CRATER"
#define BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES                          @"BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES"
#define BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK                     @"BUNCH_TYPE__MOON_ROCKS_3_ALTITUDES_BACK"
#define BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK                     @"BUNCH_TYPE__MOON_ROCKS_2_ALTITUDES_BACK"

#define BUNCH_TYPE__5_GREEN_ALIENS                                        @"BUNCH_TYPE__5_GREEN_ALIENS"
#define BUNCH_TYPE__4_GREEN_ALIENS                                        @"BUNCH_TYPE__4_GREEN_ALIENS"
#define BUNCH_TYPE__3_GREEN_ALIENS                                        @"BUNCH_TYPE__3_GREEN_ALIENS"
#define BUNCH_TYPE__2_GREEN_ALIENS                                        @"BUNCH_TYPE__2_GREEN_ALIENS"
#define BUNCH_TYPE__1_GREEN_ALIENS                                        @"BUNCH_TYPE__1_GREEN_ALIENS"

#define BUNCH_TYPE__5_ALIENS_SIMPLE                                       @"BUNCH_TYPE__5_ALIENS_SIMPLE"
#define BUNCH_TYPE__4_ALIENS_SIMPLE                                       @"BUNCH_TYPE__4_ALIENS_SIMPLE"
#define BUNCH_TYPE__3_ALIENS_SIMPLE                                       @"BUNCH_TYPE__3_ALIENS_SIMPLE"
#define BUNCH_TYPE__2_ALIENS_SIMPLE                                       @"BUNCH_TYPE__2_ALIENS_SIMPLE"
#define BUNCH_TYPE__1_ALIENS_SIMPLE                                       @"BUNCH_TYPE__1_ALIENS_SIMPLE"

#define BUNCH_TYPE__5_ALIENS_COMPLEX                                      @"BUNCH_TYPE__5_ALIENS_COMPLEX"
#define BUNCH_TYPE__4_ALIENS_COMPLEX                                      @"BUNCH_TYPE__4_ALIENS_COMPLEX"
#define BUNCH_TYPE__3_ALIENS_COMPLEX                                      @"BUNCH_TYPE__3_ALIENS_COMPLEX"
#define BUNCH_TYPE__2_ALIENS_COMPLEX                                      @"BUNCH_TYPE__2_ALIENS_COMPLEX"
#define BUNCH_TYPE__1_ALIENS_COMPLEX                                      @"BUNCH_TYPE__1_ALIENS_COMPLEX"




@interface DescriptionsSingleton : NSObject

+ (DescriptionsSingleton *)sharedManager;

- (id)getObjectByKey:(NSString *)key andSubKey:(NSString *)subKey;

@end
