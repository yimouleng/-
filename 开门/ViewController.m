//
//  ViewController.m
//  开门
//
//  Created by Ely on 15/10/27.
//  Copyright © 2015年 Ely. All rights reserved.
//

#import "ViewController.h"
#import "ExperimentView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *testImg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect frame = self.view.frame;
   // frame.size = [UIImage imageNamed:@"my.gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"my" ofType:@"gif"]];
    // view生成
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
   // webView.center = self.view.center;
    
    
    ExperimentView *view = [[ExperimentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -20)];
    [self.view addSubview:view];
    view.myScale = ^{
      
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            webView.transform = CGAffineTransformMakeScale(2, 2);
//        }completion:^(BOOL finished) {
//            webView.transform = CGAffineTransformMakeScale(1, 1);
//        }];
    };
}


@end
