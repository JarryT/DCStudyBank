//
//  DCDatiTestResultVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCDatiTestResultVC.h"
#import "CircleProgressView.h"
#import "DCKaoDianTestVC.h"

@interface DCDatiTestResultVC ()
@property (weak, nonatomic) IBOutlet UILabel *titlNa;
@property (weak, nonatomic) IBOutlet CircleProgressView *circleProgreV;
@property (weak, nonatomic) IBOutlet UIView *conetView;
@property (weak, nonatomic) IBOutlet UIButton *cheackAllJxBtn;
@property (weak, nonatomic) IBOutlet UIButton *cheackWoringBtn;

@property(nonatomic,strong)UIScrollView *scrllV;
@property(nonatomic,assign)CGFloat conetH;
@end

@implementation DCDatiTestResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"练习报告";
    self.navView.titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    self.navView.backView2.backgroundColor = [UIColor whiteColor];
    [self initWithConet];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowBgImag = NO;
    self.isShowWhiteImg = NO;
}

- (void)initWithConet{

    int collectCount = 0;
    for (DCKaoDianObjModel *model in _list) {
        if ([model isAnswerCorrect]) {
            collectCount ++;
        }
    }

    _circleProgreV.centerLabel.text = [NSString stringWithFormat:@"%d",collectCount];
    _circleProgreV.centerTitleName.text = [NSString stringWithFormat:@"共%lu道", (unsigned long)_list.count];

    _titlNa.layer.cornerRadius = 10;
    _titlNa.layer.masksToBounds = YES;
    _circleProgreV.percent = _circleProgreV.centerLabel.text.floatValue/ _list.count;
    _circleProgreV.backgroundColor = [UIColor clearColor];
    _circleProgreV.progressBackgroundColor = [UIColor colorWithHexString:@"#F2F2F2" alpha:1];
    _circleProgreV.progressColor = KMainColor;
    _circleProgreV.progressWidth = 4;
    _circleProgreV.textFont = KFont(30);
    _circleProgreV.textColor = KMainColor;
    _circleProgreV.subTextFont = KFont(11);
    _circleProgreV.subTextColor = KTextColor;

    _cheackAllJxBtn.layer.cornerRadius = 20;
    _cheackAllJxBtn.layer.masksToBounds = YES;
    _cheackWoringBtn.layer.cornerRadius = 20;
    _cheackWoringBtn.layer.masksToBounds = YES;

    [self setUpUI];

    [self.navView handleItemClickBlock:^(BRBaseNavgationViewType type) {
        [self.navigationController popToRootViewControllerAnimated:true];
    }];
}

- (void)setUpUI {
    _conetH = 0;
    _scrllV = [[UIScrollView alloc]initWithFrame:self.conetView.bounds];
    [self.conetView addSubview:_scrllV];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 15,200, 20)];
    lab.text = @"答题卡";
    lab.font = KFont(14);
    [self.scrllV addSubview:lab];
    _conetH = lab.bottom;
    UIView *singleBgView = [[UIView alloc] init];

    [self.scrllV addSubview:singleBgView];

    NSInteger number = 1;

    UIButton *lastBtn = nil;
    for (int k = 0; k < _list.count; k++) {

        DCKaoDianObjModel *model = _list[k];

        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];

        [singleBgView addSubview:btn];

        CGFloat top;
        if(lastBtn == nil) {
            top = 10;
        } else if (lastBtn.right + 40 > KScreenWidth) {
            top = lastBtn.bottom + 10;
            number++;
        } else{
            top = lastBtn.top;
        }

        btn.frame = CGRectMake(lastBtn == nil ? 20 : lastBtn.right + 40 > KScreenWidth ? 20 : lastBtn.right + 20, top, 30, 30);
        btn.layer.cornerRadius = 15;
        btn.layer.borderWidth = 1;

        if (model.selectedOptionsList.count > 0) {
            if ([model isAnswerCorrect]) {
                btn.layer.borderColor = [UIColor clearColor].CGColor;
                [btn setBackgroundColor: KMainColor];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } else {
                btn.layer.borderColor = [UIColor clearColor].CGColor;
                [btn setBackgroundColor: [UIColor redColor]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        } else {
            btn.layer.borderColor = [UIColor colorWithHexString:@"#AAAAAA" alpha:1].CGColor;
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:[UIColor colorWithHexString:@"#222222" alpha:1] forState:UIControlStateNormal];
        }

        btn.titleLabel.font = KFont(14);
        NSInteger inde = k+1;
        [btn setTitle:[NSString stringWithFormat:@"%ld",inde] forState:UIControlStateNormal];
        lastBtn = btn;

    }
    singleBgView.frame = CGRectMake(0, lab.bottom + 5, KScreenWidth, number * 50);

    _conetH = singleBgView.bottom + 5;

}

//查看所有解析
- (IBAction)cheackAllJxBtnClick:(UIButton *)sender {

    DCKaoDianTestVC *vc = [[DCKaoDianTestVC alloc] init];
    vc.isAllCheck = true;
    vc.itemtype = _itemtype;
    vc.keMuName = _keMuName;
    vc.keMuId = _keMuId;
    vc.kaoDianList = _list;
    for (DCKaoDianObjModel *model in vc.kaoDianList) {
        model.cellType = KaoDianCellTypeAll;
    }
    [self.navigationController pushViewController:vc animated:true];
}

//查看错误
- (IBAction)cheackWrongBtnClick:(UIButton *)sender {

    NSArray *temp = [_list copy];
    NSMutableArray *errorsModel = [NSMutableArray array];
    for (DCKaoDianObjModel *model in temp) {
        if (model.selectedOptionsList.count > 0 && ![model isAnswerCorrect]) {
            model.cellType = KaoDianCellTypeError;
            [errorsModel addObject:model];
        }
    }

    DCKaoDianTestVC *vc = [[DCKaoDianTestVC alloc] init];
    vc.isAllCheck = true;
    vc.itemtype = _itemtype;
    vc.keMuName = _keMuName;
    vc.keMuId = _keMuId;
    vc.kaoDianList = temp;
    [self.navigationController pushViewController:vc animated:true];
}

@end
