//
//  BaiduModInterstatial.m
//  BaiduAds
//
//  Created by rect on 14-4-19.
//
//

#import "BaiduModInterstatial.h"
#import "BaiduMobAdView.h"



@interface BaiduModInterstatial () {
    BaiduMobAdView *_sharedAdView;
    BaiduMobAdInterstitial *_interstitialView;
    BOOL _adloaded;
}
@property FREContext context;
@property (nonatomic,retain) BaiduMobAdView* sharedAdView;
@property (nonatomic,retain) BaiduMobAdInterstitial *interstitialView;
@property (retain) UIWindow* win;
@property NSDictionary* baiduAdsData;
@end

@implementation BaiduModInterstatial

@synthesize context;
@synthesize win;
@synthesize baiduAdsData;
@synthesize sharedAdView = _sharedAdView,interstitialView = _interstitialView;
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
        _adloaded = NO;
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
    
    
}
- (void)clickLoadAd
{
    NSLog(@"enter clickLoadAd");
    if (_adloaded == YES) {
        NSLog(@" _adloaded = yes");
        [self clickShowAd];
        return;
    }
    
    self.interstitialView = [[[BaiduMobAdInterstitial alloc] init] autorelease];
    self.interstitialView.delegate = self;
    self.interstitialView.interstitialType = BaiduMobAdViewTypeInterstitialGame;
    [self.interstitialView load];
    NSLog(@"out clickLoadAd");
}

- (void)clickShowAd
{
    NSLog(@"enter clickShowAd");
    if (self.interstitialView.isReady) {
        [self.interstitialView presentFromRootViewController:win.rootViewController];
    }else {
        NSLog(@"ad not ready");
    }
    NSLog(@"out clickShowAd");
}

- (void)clickShowVideoAd
{
    NSLog(@"enter clickShowVideoAd");
    self.sharedAdView = [[[BaiduMobAdView alloc] init] autorelease];
    // 视频类型广告相关设置
    
    // init data
    [self setBaiduAdsData];
    NSString* baiAdPlaceId1 = [baiduAdsData objectForKey:@"baiAdPlaceId1"];
    
    self.sharedAdView.AdUnitTag = baiAdPlaceId1;
    self.sharedAdView.AdType = BaiduMobAdViewTypeVABeforeVideo;
    self.sharedAdView.frame = CGRectMake(20,20,kBaiduAdViewSquareBanner300x250.width,kBaiduAdViewSquareBanner300x250.height);
    self.sharedAdView.delegate = self;
    [win addSubview:self.sharedAdView];
    [self.sharedAdView start];
    NSLog(@"out clickShowVideoAd");
}

- (NSString *)publisherId
{
    // init data
    [self setBaiduAdsData];
    NSString* baipublisherId = [baiduAdsData objectForKey:@"baipublisherId"];
    
    return  baipublisherId; //@"your_own_app_id";
}

- (NSString*) appSpec
{
    // init data
    [self setBaiduAdsData];
    NSString* baiAppSpec = [baiduAdsData objectForKey:@"baiAppSpec"];
    //注意：该计费名为测试用途，不会产生计费，请测试广告展示无误以后，替换为您的应用计费名，然后提交AppStore.
    return baiAppSpec;
}

-(BOOL) enableLocation
{
    // init data
    [self setBaiduAdsData];
    NSString* test;
    test = [baiduAdsData objectForKey:@"baiisenableLocation"];
    if ([test  isEqual: @"false"]) {
        return NO;
    } else {
        return YES;
    }
    //启用location会有一次alert提示
}


-(void) willDisplayAd:(BaiduMobAdView*) adview
{
    
    NSLog(@"delegate: will display ad");
    
}

-(void) failedDisplayAd:(BaiduMobFailReason) reason;
{
    NSLog(@"delegate: failedDisplayAd %d", reason);
}

/**
 *  广告预加载成功
 */
- (void)interstitialSuccessToLoadAd:(BaiduMobAdInterstitial *)interstitial
{
    _adloaded = YES;
    [self sendMsgToAs:(NSString*)BAIDUADS_INTERSTATIAL level:@"addsuccess"];
    [self clickShowAd];
    //UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"" message:@"load success" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] autorelease];
    //[alertView show];
}

/**
 *  广告预加载失败
 */
- (void)interstitialFailToLoadAd:(BaiduMobAdInterstitial *)interstitial
{
    [self sendMsgToAs:(NSString*)BAIDUADS_INTERSTATIAL level:@"addfialed"];
    _adloaded = NO;
    //UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"" message:@"load fail" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] autorelease];
    //[alertView show];
}

/**
 *  广告即将展示
 */
- (void)interstitialWillPresentScreen:(BaiduMobAdInterstitial *)interstitial
{
    [self sendMsgToAs:(NSString*)BAIDUADS_INTERSTATIAL level:@"广告即将展示"];
}

/**
 *  广告展示成功
 */
- (void)interstitialSuccessPresentScreen:(BaiduMobAdInterstitial *)interstitial
{
    [self sendMsgToAs:(NSString*)BAIDUADS_INTERSTATIAL level:@"广告展示成功"];
}

/**
 *  广告展示失败
 */
- (void)interstitialFailPresentScreen:(BaiduMobAdInterstitial *)interstitial withError:(BaiduMobFailReason) reason
{
    [self sendMsgToAs:(NSString*)BAIDUADS_INTERSTATIAL level:@"广告展示失败"];
}

/**
 *  广告展示结束
 */
- (void)interstitialDidDismissScreen:(BaiduMobAdInterstitial *)interstitial
{
    [self sendMsgToAs:(NSString*)BAIDUADS_INTERSTATIAL level:@"广告展示结束"];
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
