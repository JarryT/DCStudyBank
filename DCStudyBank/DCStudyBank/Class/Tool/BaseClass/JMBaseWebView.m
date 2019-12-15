

//
//  JMBaseWebView.m
//  JiaMei
//
//  Created by jm on 2018/5/28.
//  Copyright © 2018年 TJarry. All rights reserved.
//

#import "JMBaseWebView.h"

@interface JMBaseWebView ()
@property(nonatomic,strong)UIWebView *web;
@end

@implementation JMBaseWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _navTitle;
    
    [self.view addSubview:self.web];
    if (_url) {
         [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    _web.frame = self.view.bounds;
}

#pragma lazy
- (UIWebView *)web{
    
    if (!_web) {
        _web = [[UIWebView alloc] init];
		_web.scalesPageToFit = YES;
    }
    return _web;
}

@end
