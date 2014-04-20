//
//  BaiduModHandle.h
//  BaiduAds
//
//  Created by rect on 14-1-8.
//
//

#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"
#import "BaiduAdsEvens.h"
#import "BaiduMobAdDelegateProtocol.h"



@interface BaiduModBanner : UIViewController<UITableViewDataSource,UITableViewDelegate,BaiduMobAdViewDelegate>
@property (nonatomic, retain) IBOutlet UITableView* tableView;

- (id)initWithContext:(FREContext)extensionContext;

//-(void)BaiduAdsBanner;

-(void) sendMsgToAs:(NSString *) code
              level:(NSString * )level;

-(void) setBannerXY:(int)viewX
              viewY:(int)viewY;

-(void) setBaiduAdsData;
@end

