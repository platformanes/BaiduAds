//
//  BaiduModHandle.m
//  BaiduAds
//
//  Created by rect on 14-1-8.
//
//

#import "BaiduModBanner.h"
#import  "BaiduAdsEvens.h"
#import "BaiduMobAdView.h"

#define kAdViewPortraitRect CGRectMake(0, 460-48-48, kBaiduAdViewSizeDefaultWidth, kBaiduAdViewSizeDefaultHeight)

NSDictionary* baiduAdsData = nil;
int portraitX;
int portraitY;
int drawWidth;
int drawHeight;

@interface BaiduModBanner () {
}
@property FREContext context;

@property BaiduMobAdView* sharedAdView;
@property (retain) UIWindow* win;

// 广告相关参数
// 保存的方式可能不太好,请使用的同行自行修改(by Rect)

//@property (nonatomic)  NSDictionary* baiduAdsData;
// 广告位ID
@property  NSString* baiAdPlaceId1;
// your_own_app_id
@property NSString* baipublisherId;
// appSpec 注意：该计费名为测试用途，不会产生计费，请测试广告展示无误以后，替换为您的应用计费名，然后提交AppStore.
@property NSString* baiAppSpec;
//启用location会有一次alert提示
@property BOOL baiisenableLocation;
// 人群属性接口 关键词数组
@property NSArray* baikeywords;
// 人群属性接口 性别
@property int baiuserGender;
// 人群属性接口 用户生日
@property int baiuserBirthday;
// 人群属性接口 用户城市
@property NSString* baiuserCity;
// 人群属性接口 用户邮编
@property NSString* baiuserPostalCode;
// 人群属性接口 用户职业
@property NSString* baiuseruserWork;
// 人群属性接口 用户最高教育学历
@property int baiuserEducation;
// 人群属性接口 用户收入
@property int baiuserSalary;
// 人群属性接口 用户爱好
@property NSArray* baiuserHobbies;
// 人群属性接口 其他自定义字段
@property NSDictionary* baiuserOtherAttributes;
// end

@end


@implementation BaiduModBanner

@synthesize tableView = tableView_;

@synthesize context,win;
@synthesize sharedAdView;

// 广告相关参数
//@synthesize baiduAdsData;
@synthesize baiAdPlaceId1;
@synthesize baipublisherId,baiAppSpec,baiisenableLocation,baikeywords,baiuserGender,baiuserBirthday,baiuserCity,baiuserPostalCode,baiuseruserWork,baiuserEducation,baiuserSalary,baiuserHobbies,baiuserOtherAttributes;

#pragma mark - Lifecycle

- (void)dealloc
{
    [tableView_ release];
    [super dealloc];
}
/*
 * init the adobe air ctx
 *
 */
- (id)initWithContext:(FREContext)extensionContext
{
    NSLog(@"init context");
    
    self = [super init];
    if( self )
    {
        NSLog(@"context not null");
        context = extensionContext;
        win = [UIApplication sharedApplication].keyWindow;
        
    }
    return self;
}

-(void) setBaiduAdsData
{
    [self sendMsgToAs:(NSString *)BAIDUADS_DATA level:@"enter setBaiduAdsData"];
    //baiduAdsData = dictionary;
    
    //baiduAdsData = [NSDictionary dictionaryWithDictionary:dictionary];
    //读取TestPlistDemo文件中的数据
    NSString *plistPath1 = [[NSBundle mainBundle] pathForResource:@"baiduadsdata" ofType:@"plist"];
    baiduAdsData = [NSDictionary dictionaryWithContentsOfFile:plistPath1];
    
    //得到词典的数量
    int count = [baiduAdsData count];
    NSLog(@"baiduAdsData 词典的数量为： %d",count);
    
    NSString* test;
    // init data
    baiAdPlaceId1 = [baiduAdsData objectForKey:@"baiAdPlaceId1"];
    baipublisherId = [baiduAdsData objectForKey:@"baipublisherId"];
    baiAppSpec = [baiduAdsData objectForKey:@"baiAppSpec"];
    
    test = [baiduAdsData objectForKey:@"baiisenableLocation"];
    if ([test  isEqual: @"false"]) {
        baiisenableLocation = NO;
    } else {
        baiisenableLocation = YES;
    }
    
    test = [baiduAdsData objectForKey:@"baikeywords"];
    baikeywords = [test componentsSeparatedByString:@"-"];
    
    test = [baiduAdsData objectForKey:@"baiuserGender"];
    baiuserGender = [test intValue];
    
    test = [baiduAdsData objectForKey:@"baiuserBirthday"];
    baiuserBirthday = [test intValue];
    
    baiuserCity = [baiduAdsData objectForKey:@"baiuserCity"];
    baiuserPostalCode = [baiduAdsData objectForKey:@"baiuserPostalCode"];
    baiuseruserWork = [baiduAdsData objectForKey:@"baiuseruserWork"];
    
    test = [baiduAdsData objectForKey:@"baiuserEducation"];
    baiuserEducation = [test intValue];
    
    test = [baiduAdsData objectForKey:@"baiuserSalary"];
    baiuserSalary = [test intValue];
    
    test = [baiduAdsData objectForKey:@"baiuserHobbies"];
    baiuserHobbies = [test componentsSeparatedByString:@"-"];
    
    NSLog(@"baiAdPlaceId1为： %@",baiAdPlaceId1);
    [baiAdPlaceId1 retain];
    [baipublisherId retain];
    [baiAppSpec retain];
    [baikeywords retain];
    [baiuserCity retain];
    [baiuserPostalCode retain];
    [baiuseruserWork retain];
    [baiuserHobbies retain];
    
    [self sendMsgToAs:(NSString *)BAIDUADS_DATA level:@"out setBaiduAdsData"];
}

-(void) setBannerXY:(int)viewX
              viewY:(int)viewY
              viewW:(int)viewW
              viewH:(int)viewH
{
    portraitX = viewX;
    portraitY = viewY;
    drawWidth = viewW;
    drawHeight = viewH;
    
}
- (void)showAdViewInController:(UIViewController<BaiduMobAdViewDelegate> *)controller withRect:(CGRect) rect
{
    
    BaiduMobAdView *adView = [[[BaiduMobAdView alloc] init] autorelease];
    adView.AdUnitTag = baiAdPlaceId1 ;//@"myAdPlaceId1";
    adView.AdType = BaiduMobAdViewTypeBanner;
    adView.frame = rect;
    adView.delegate = controller;
    [controller.view addSubview:adView];
    [adView start];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    tableView_.delegate = self;
    tableView_.dataSource = self;
    
    //使用嵌入广告的方法实例。
    sharedAdView = [[BaiduMobAdView alloc] init];
    sharedAdView.AdUnitTag = baiAdPlaceId1;//@"myAdPlaceId1";
    //此处为广告位id，可以不进行设置，如需设置，在百度移动联盟上设置广告位id，然后将得到的id填写到此处。
    sharedAdView.AdType = BaiduMobAdViewTypeBanner;
    
    sharedAdView.frame = CGRectMake(portraitX, portraitY, drawWidth, drawWidth);//kAdViewPortraitRect;
    
    sharedAdView.delegate = self;
    
    [win addSubview:sharedAdView];
    
    [sharedAdView start];
    
    
    //使用悬浮广告的方法实例。
    //    [self showAdViewInController:self withRect:kAdViewPortraitRect];
     NSLog(@"finish viewDidLoad");
}

- (NSString *)publisherId
{
    //得到词典的数量
    NSLog(@"publisherId -- ");
    //[self setBaiduAdsData];
    
    return  baipublisherId; //@"your_own_app_id";
}

- (NSString*) appSpec
{
    //得到词典的数量
    NSLog(@"appSpec -- ");
    //[self setBaiduAdsData];
    
    //注意：该计费名为测试用途，不会产生计费，请测试广告展示无误以后，替换为您的应用计费名，然后提交AppStore.
    return baiAppSpec;
}

-(BOOL) enableLocation
{
    //得到词典的数量
    NSLog(@"enableLocation -- ");
    //[self setBaiduAdsData];
    
    //启用location会有一次alert提示
    return baiisenableLocation;
}


-(void) willDisplayAd:(BaiduMobAdView*) adview
{
    //在广告即将展示时，产生一个动画，把广告条加载到视图中
    sharedAdView.hidden = NO;
    CGRect f = sharedAdView.frame;
    f.origin.x = -320;
    sharedAdView.frame = f;
    [UIView beginAnimations:nil context:nil];
    f.origin.x = 0;
    sharedAdView.frame = f;
    [UIView commitAnimations];
    NSLog(@"delegate: will display ad");
    
}

-(void) failedDisplayAd:(BaiduMobFailReason) reason;
{
    NSLog(@"delegate: failedDisplayAd %d", reason);
}

//人群属性接口
/**
 *  - 关键词数组
 */
-(NSArray*) keywords{
    
    //得到词典的数量
    NSLog(@"keywords -- ");
    //[self setBaiduAdsData];
    return baikeywords;
}

/**
 *  - 用户性别
 * BaiduMobAdMale=0,
 * BaiduMobAdFeMale=1,
 * BaiduMobAdSexUnknown=2,
 */
-(BaiduMobAdUserGender) userGender{
    
    //得到词典的数量
    NSLog(@"userGender -- ");
    //[self setBaiduAdsData];
    
    return baiuserGender;
}

/**
 *  - 用户生日
 */
-(NSDate*) userBirthday{
    
    //得到词典的数量
    NSLog(@"userBirthday -- ");
    //[self setBaiduAdsData];
    
    NSDate* birthday = [NSDate dateWithTimeIntervalSince1970:baiuserBirthday];
    return birthday;
}

/**
 *  - 用户城市
 */
-(NSString*) userCity{
    
    //得到词典的数量
    NSLog(@"userCity -- ");
    //[self setBaiduAdsData];
    
    return baiuserCity;
}


/**
 *  - 用户邮编
 */
-(NSString*) userPostalCode{
    
    //得到词典的数量
    NSLog(@"userPostalCode -- ");
    //[self setBaiduAdsData];
    
    return baiuserPostalCode;
}


/**
 *  - 用户职业
 */
-(NSString*) userWork{
    
    //得到词典的数量
    NSLog(@"userWork -- ");
    //[self setBaiduAdsData];
    
    return baiuseruserWork;
}

/**
 *  - 用户最高教育学历
 *  - 学历输入数字，范围为0-6
 *  - 0表示小学，1表示初中，2表示中专/高中，3表示专科
 *  - 4表示本科，5表示硕士，6表示博士
 */
-(NSInteger) userEducation{
    
    //得到词典的数量
    NSLog(@"userEducation -- ");
    //[self setBaiduAdsData];
    return  baiuserEducation;
}

/**
 *  - 用户收入
 *  - 收入输入数字,以元为单位
 */
-(NSInteger) userSalary{
    
    //得到词典的数量
    NSLog(@"userSalary -- ");
    //[self setBaiduAdsData];
    
    return baiuserSalary;
}

/**
 *  - 用户爱好
 */
-(NSArray*) userHobbies{
    
    //得到词典的数量
    NSLog(@"userHobbies -- ");
    //[self setBaiduAdsData];

    return baiuserHobbies;
}

/**
 *  - 其他自定义字段
 */
-(NSDictionary*) userOtherAttributes{
    
    //得到词典的数量
     NSLog(@"userOtherAttributes -- ");
    //int count = [baiduAdsData count];
    //NSLog(@"dictionary 词典的数量为： %d",count);
    
    NSMutableDictionary* other = [[[NSMutableDictionary alloc] init] autorelease];
    [other setValue:@"测试" forKey:@"测试"];
    return other;
}

/*
 * the function use to callback
 *
 */
-(void)sendMsgToAs:(NSString *  )code level:(NSString * )level {
    
    NSLog(@"code = %@,level = %@",code,level);
    FREDispatchStatusEventAsync( context,
                                (const uint8_t *)[code UTF8String],
                                (const uint8_t *)[level UTF8String]);
}


@end
