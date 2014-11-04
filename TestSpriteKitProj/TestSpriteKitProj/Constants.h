
#ifndef moonskater_Constants_h
#define moonskater_Constants_h


#pragma mark - Position constants

#define DELTA_PERCENT_MAIN_MENU_BORDERS     1

#define NUMBER_OF_LEVELS_TOTAL              10
#define NUMBER_OF_LEVELS_IN_LINE            5

#define iPad    UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define iDevicePictureScale         (iPad ? 2 : 1)

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)

#define IPAD_IPHONE_MULT_VERT   (768/320) //2.133333
#define IPAD_IPHONE_MULT_HORIZ  (1024/480)

#pragma mark - Social constants

#define FACEBOOK_POST(points)        ([NSString stringWithFormat:@"I am playing Moon Skater and just scored %.0f points. Can you beat my score?" ,points])

#define FACEBOOK_URL_SCHEME         (PRO_VERSION == 1) ? @"pro" : @"free"

#define FACEBOOK_URL                @"http://facebook.com/moonskatergame"
#define TWITTER_URL                 @"https://twitter.com/3guysapps"

#define SERVER_UPGRADE_URL          @"http://itunes.apple.com/us/app/moon-skater-pro-version/id556848316?l=ru&ls=1&mt=8"

#pragma mark - NSDefaults Pathes constants

#define NSDEFAULTS_LEVELS_ARRAY     @"LevelsArray"
#define NSDEFAULTS_IS_NOT_FIRST_LAUNCH      @"NSDEFAULTS_IS_NOT_FIRST_LAUNCH"



#pragma mark - AD's constants

#define CHARTBOOST_APP_ID           @"5023dc219c890d867c00006a"
#define AD_WHIRL_APPLICATION_KEY    @"93b05cd3b0a340728f4f74098e91cdd5"

#define FBAppID                     @"514965845195961"

#define CHARTBOOST_APP_SIGNATURE    @"05eef741da41d92e09df84869c3af3cfb9bee86d"

#define INFO_GAME_TEXT              @"\n CREDITS  \n Moon Skater – ©3 Guys Apps 2012 \n Developed by 3 Guys Apps \n Visit 3GuysApps.net for more amazing games \n \n Game design – Eric Barnes \n Sound – Eric Barnes, Mark Barnes \n Operations – Mike Doutt \n\nBeta Testers: \n Ethan Lauren \n Georgia Camryn \n \n 3 GUYS APPS THANKS: \n Mollie Barnes \n Joelle Barnes \n Tracy Doutt \n The entire project team \n Family & Friends  \n \n Blast off. . . \n"

#define kLeaderboardID          @"Points"
#define kUserDefaultsScoreKey   @"DefaultUserScore"

typedef enum _GameStatus
{
	GSStop,
    GSRun,
    GSPause,
    GSGameOver
} GameStatus;

typedef enum _ObjectType 
{
	OTNone,
    OTDune, 
    OTRock,
    OTAllien,
    OTHidedAllien,
    OTMeteorit,
    OTMoonDust,
    OTCrater,
    OTShip
    
} GameObjectType ;



typedef enum _ObjectStatus 
{
	SSNothing,
    SSRolling, 
    SSJumping,
    SSFalling,
    SSHided, 
    SSAttack,
    SSAlreadyAttack,
    SSTransporting

} ObjectrStatus ;

#define c_skyCount 2
#define c_earthCount 1
#define c_mountsCount 2

#define c_turboSpeed        600
#define c_shipBaseSpeed     300

typedef enum Allert_Tag_Types 
{
    BUYEMPTY = 1,
    BUY4C,
    BUY3C,
    BUY2C,
    BUY1C,
} ShopItems;

typedef enum _GameObjects
{
	GORock,
    GOAlien,
    GOHidedAlien
    
} GameObjects ;

typedef enum _weaponsClass
{
	WCStandart,
    WCAnnihilator
} WeaponClass ;

typedef enum _skaterGender
{
	SGBoy, 
    SGGirl
} skaterGender ;

static const NSString *weaponPartName[] =  {@"gun_",@"laser"};

#define c_DefaultShotsDelay 0.5
#define c_ImprovedShotsDelay 0.05

#define  c_TimeForRoks 150
#define  c_TimeForAliens 180

#define  c_MinDeltaBetweenObjects 25


#define GAME_VERSION_FREE @"FREE"
#define GAME_VERSION_PRO @"PRO"

#define   c_alienpoints 100

#define   c_pathCount 20

#define c_moonDustDefPeriod 25

#define c_SkaterYPos 103

#define Weapon1Price 1000
#define Weapon2Price 2000
#define Extra1Price 500
#define Extra2Price 1000
#define SuperTurboBoostPrice 5000

#define c_ExtraType1 5
#define c_ExtraType2 10
#define c_timeExtraReload 30

#endif

static const float GameLevelAliensCount[] = {200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100};

static const float GameLevelRocksCount[] =  {200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100};

static const float GameLevelPath[] =  {50, 100, 150, 200, 300, 400, 500, 600, 800, 1000};

static const float GameCraterCounts[] =  {0, 0, 3, 3, 4, 4, 5, 5, 6, 6};

static const float GameShipCounts[] =  {0, 0, 0, 10, 10, 10, 10, 10, 10, 10}; // ранее предпологалось что кол-во кораблей будет увеливаться с каждым уровненм но клиент захотел чтоб корабли появлялись через промежуток времени

static const float MoonDustAlt[] = {c_SkaterYPos,180, 220, 260};



//#define mrocks2000 [[[NSBundle mainBundle] bundleIdentifier] stringByAppendingString:@"2000mrockspro"]
#define mrocks500           @"500rocks"
#define mrocks1500          @"1500rocks"
#define mrocks5000          @"5000rocks"
#define mrocks10000         @"10000rocks"

#define c_girlPart          @"girl_"

#define c_flurryAppKey      @"CVDQCR2YTG3945D9CNTZ"



#define c_SpeedMain                     250
#define c_SpeedTurboBoost               450
#define c_Speed10Level                  150



#define MAIN_SCALE_COEF                 0.7
#define GROUND_HEIGHT                   57.0
#define SPEED_OF_DUST                   (c_SpeedMain * 0.6)

#define STOP_TIME_AFTER_DEATH           0.7 // время остановки бекграунда и движущихся объектов сразу после столкновения скейтера

#define MOON_ROCK_COLLECTION_SPEED      400.0
#define MOON_ROCK_MAGNET_SPEED          (c_SpeedMain * 1.1)
#define MAGNET_RADIUS                   300.0

#define ALIENS_FALL_SPEED               250.0

//#define MOONROCKS_END_POINT             ccp(screenSize.width / 2, screenSize.height - 15);


enum ZOrdersOfObjects {
    Z_ORDER_ALIENS = 400,
    Z_ORDER_SKATER = 1,
};

enum MoonRocksAltitudes {
    MOON_ROCK_ALTITUDE01 = 20,
    MOON_ROCK_ALTITUDE11 = 100,
    MOON_ROCK_ALTITUDE21 = 180,
};

#define ENERGY_SKATER                   4
#define ENERGY_SPACESHIP                4
#define ENERGY_ALIEN_SMALL              1
#define ENERGY_ALIEN_LARGE              3


static inline CGFloat ccpDistance(CGPoint first, CGPoint second) {
    return hypotf(second.x - first.x, second.y - first.y);
}

#define SK_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * 0.01745329252f) // PI / 180
#define SK_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 57.29577951f) // PI * 180







