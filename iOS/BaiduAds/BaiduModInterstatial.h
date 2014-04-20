//
//  BaiduModInterstatial.h
//  BaiduAds
//
//  Created by rect on 14-4-19.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"
#import "BaiduAdsEvens.h"
#import "BaiduMobAdDelegateProtocol.h"
#import "BaiduMobAdInterstitial.h"

@interface BaiduModInterstatial : UIViewController<BaiduMobAdViewDelegate,BaiduMobAdInterstitialDelegate>

- (id)initWithContext:(FREContext)extensionContext;


-(void) sendMsgToAs:(NSString *) code
              level:(NSString * )level;
- (void)clickLoadAd;
- (void)clickShowVideoAd;
-(void) setBaiduAdsData;
@end
