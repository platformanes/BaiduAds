//
//  BaiduModInterstatial.m
//  BaiduAds
//
//  Created by rect on 14-4-19.
//
//

#import "BaiduModInterstatial.h"
#import "BaiduMobAdView.h"

int portraitX1;
int portraitY1;
int drawWidth1;
int drawHeight1;
BOOL isShow1 = FALSE;
int adsType;

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

-(void) setBannerXY:(int)viewX
              viewY:(int)viewY
              viewW:(int)viewW
              viewH:(int)viewH
{
    portraitX1 = viewX;
    portraitY1 = viewY;
    drawWidth1 = viewW;
    drawHeight1 = viewH;
    
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
    
    if (adsType > 5) {
        adsType = BaiduMobAdViewTypeInterstitialGame;
    }
    
    self.interstitialView.interstitialType = adsType;
    
    [self.interstitialView load];
    NSLog(@"out clickLoadAd");
}

-(void) setToype:(int)adType
{
    adsType = adType;
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

-(int) changeViewDraw:(int)t
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    //CGRect frame = [UIScreen mainScreen].applicationFrame;
    //CGPoint center = CGPointMake(frame.origin.x + ceil(frame.size.width/2), frame.origin.y + ceil(frame.size.height/2));
    
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        NSLog(@"UIInterfaceOrientationLandscapeLeft 1");
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"UIInterfaceOrientationLandscapeRight 2");
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"UIInterfaceOrientationPortraitUpsideDown 3");
    } else {
         NSLog(@"no  4");
    }
    
    //[[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationLandscapeRight animated:YES];
    
    //CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    //[UIView beginAnimations:nil context:nil];
    //[UIView setAnimationDuration:duration];
    
    //在这里设置view.transform需要匹配的旋转角度的大小就可以了。
    
    //[UIView commitAnimations];
    
    
    return 0;
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
    self.sharedAdView.frame = CGRectMake(portraitX1,portraitY1,drawWidth1,drawHeight1);
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
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        [ adview setTransform: CGAffineTransformMakeRotation( -(M_PI*90/180))];
        NSLog(@"UIInterfaceOrientationLandscapeLeft 1");
        
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"UIInterfaceOrientationLandscapeRight 2");
        [ adview setTransform: CGAffineTransformMakeRotation( M_PI*90/180)];
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"UIInterfaceOrientationPortraitUpsideDown 3");
    } else {
        NSLog(@"no  4");
    }
    

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
