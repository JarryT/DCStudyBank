//
//  DCCollectMainVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCCollectMainVC.h"
#import "DCWrongTestHeaderView.h"
#import "FSPageContentView.h"
#import "DCNewCollectionVC.h"
#import "DCCollectionCategoryVC.h"
@interface DCCollectMainVC ()<DCWrongTestHeaderViewDelegate,FSPageContentViewDelegate>
@property (strong, nonatomic)DCWrongTestHeaderView *statusView;

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) DCNewCollectionVC *vc1;
@property (nonatomic, strong) DCCollectionCategoryVC *vc2;

@end

@implementation DCCollectMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMainView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowBgImag = true;
    self.isShowWhiteImg = true;
}

- (void)initMainView{
    self.navView.title = @"";
    [self.navView.backView2 addSubview:self.statusView];
    
    [self.statusView setUpStatusButtonWithTitle:[NSArray arrayWithObjects:@"最新收藏",@"收藏分类", nil]
      normalColor:[UIColor whiteColor]
    selectedColor:KMainColor lineColor:[UIColor whiteColor]];
    [self.statusView changeTag:0];
    self.statusView.selectIndex = 0;
    _vc1 = [DCNewCollectionVC new];
    _vc2 = [DCCollectionCategoryVC new];
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,kTopHeight,KScreenWidth,KScreenHeight-kTopHeight) childVCs:@[_vc1,_vc2] parentVC:self delegate:self];
      
    [self.view addSubview:_pageContentView];
}

/// 选中某个tab
- (void)statusViewSelectIndex:(NSInteger)index{
    self.pageContentView.contentViewCurrentIndex = index;
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    [self.statusView changeTag:endIndex];
}

#pragma mark-lazy
- (DCWrongTestHeaderView *)statusView {
    if (!_statusView) {
        _statusView = [[DCWrongTestHeaderView alloc] initWithFrame:CGRectMake((KScreenWidth - 164)*0.5,7,164,30)];
        _statusView.delegate = self;
        _statusView.layer.cornerRadius = 30/2;
        _statusView.layer.masksToBounds = true;
        _statusView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.1];
//        _statusView.layer.borderColor = RGB(240, 30,94).CGColor;
//        _statusView.layer.borderWidth = 0.5;
        _statusView.userInteractionEnabled = YES;
        
    }
    return _statusView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
