//
//  SearchWebViewController.h
//  HuarenjieMarket
//
//  Created by 赵一 on 16/5/10.
//  Copyright © 2016年 dujiaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchWebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *searchWeb;
@property (nonatomic, copy) NSString *URLStr;
@end
