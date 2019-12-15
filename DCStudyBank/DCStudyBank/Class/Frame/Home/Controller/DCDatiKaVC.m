//
//  DCDatiKaVC.m
//  DCStudyBank
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DCDatiKaVC.h"
#import "DCDatiTestResultVC.h"
#import "DCKaoDianModel.h"

//添加联系记录
#define DddErrorItemsPath @"itemController/addErrorItems"

@interface DCDatiKaVC ()
@property (weak, nonatomic) IBOutlet UIView *conetView;
@property(nonatomic,strong)UIScrollView *scrllV;
@property(nonatomic,assign)CGFloat conetH;
@property (weak, nonatomic) IBOutlet UIButton *commit;


@end

@implementation DCDatiKaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"考点智能练习";
    self.navView.titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    self.navView.backView2.backgroundColor = [UIColor whiteColor];
    [self initWithConet];

    [_commit setHidden:_isAllCheck];
    [self.navView handleItemClickBlock:^(BRBaseNavgationViewType type) {
        AlertView *alt = [[AlertView alloc] initWithIconName:@"" title:@"提示" content:@"确定要退出？" isSingleAction:NO cancelBlock:^{
            } doneBlock:^{
                [self.navigationController popViewControllerAnimated:true];
        }];
        [alt showTo:self.navigationController.view];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowBgImag = NO;
    self.isShowWhiteImg = NO;
}


- (void)initWithConet{
    _conetH = 0;
    _scrllV = [[UIScrollView alloc]initWithFrame:self.conetView.bounds];
    [self.conetView addSubview:_scrllV];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 15,200, 20)];
    lab.text = @"快速智能练习";
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
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            [btn setBackgroundColor: KMainColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
//确认提交
- (IBAction)suerTijiaoBtnClick:(UIButton *)sender {

    //判断每个题是否正确
    NSMutableArray *erroritems = [NSMutableArray array];
    int collectCount = 0;
    int completeCount = 0;
    for (DCKaoDianObjModel *model in _list) {
        //1、
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"itemid"] = model.itemid;
        //2、
        if (model.selectedOptionsList.count > 0) {
            NSMutableArray *answersOption = [NSMutableArray array];
            for (DCKaoDianOptionsListModel *option in model.selectedOptionsList) {
                [answersOption addObject:option.opname];
            }
            NSString *answers = [answersOption componentsJoinedByString:@","];
            dict[@"erroption"] = answers;
        } else {
            dict[@"erroption"] = @"";
        }
        //3、
        dict[@"corid"] = model.corid;
        //4、
        dict[@"errresult"] = [model isAnswerCorrect] ? @"正确" : @"错误";
        if ([model isAnswerCorrect]) {
            collectCount ++;
        }
        if (model.selectedOptionsList.count > 0) {
            completeCount ++;
        }
        [erroritems addObject:dict];
    }
    
    NSMutableDictionary *exerReport = [NSMutableDictionary dictionary];
    exerReport[@"exername"] = _keMuName;
    //exerReport[@"exertime"] = @"100";
    exerReport[@"exercount"] = [NSString stringWithFormat:@"%lu",(unsigned long)_list.count];
    NSString *count = [NSString stringWithFormat:@"%d", collectCount];
    exerReport[@"exeraccuracy"] = [NSString stringWithFormat:@"%.2f", count.floatValue/_list.count];
    exerReport[@"isaccomplish"] = (completeCount == _list.count) ? @"完成" : @"未完成";
    exerReport[@"corid"] = _keMuId;

    NSDictionary *info = @{@"exerReport": [exerReport mj_JSONString], @"erroritems": [erroritems mj_JSONString]};

    //提示
    if (completeCount < _list.count) {
        AlertView *alt = [[AlertView alloc] initWithIconName:@"" title:@"提示" content:@"你还有题目未做完, 确定交卷么？" isSingleAction:NO cancelBlock:^{
            } doneBlock:^{
                [self commitRequest:info];
        }];
        [alt showTo:self.navigationController.view];
    } else {
        [self commitRequest:info];
    }
}

- (void)commitRequest:(NSDictionary *)info {
    weakSelf(self)
    [DCNetworkingRequest requestWithURLString:DddErrorItemsPath params:info method:POST withMappingObject:@"DCNetworkingReultModel" success:^(id  _Nonnull responseObject) {
        [weakSelf pushToResult];
    } fail:^(NSError * _Nonnull error, NSString * _Nonnull errorDescription) {
    }];
}


- (void)pushToResult {
    DCDatiTestResultVC *vc = [[DCDatiTestResultVC alloc] init];
    vc.itemtype = _itemtype;
    vc.keMuId = _keMuId;
    vc.keMuName = _keMuName;
    vc.list = _list;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
