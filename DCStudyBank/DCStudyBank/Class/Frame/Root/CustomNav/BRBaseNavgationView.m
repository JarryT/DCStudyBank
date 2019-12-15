//
//  BRBaseNavgationView.m
//  BROA
//
//  Created by fillinse on 2019/10/24.
//  Copyright © 2019 fillinse. All rights reserved.
//

#import "BRBaseNavgationView.h"
#import "UIImage+XYSWTool.h"
#import "SYButton.h"
@interface BRBaseNavgationView ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backWidth;

@property (nonatomic, copy) void(^itemClickBlock)(BRBaseNavgationViewType type);
@property (nonatomic, copy) ActionBlock firstBtnBlock;
@property (nonatomic, copy) ActionBlock secondBtnBlock;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (nonatomic, copy) void(^searcBarTextChange)(NSString *context);


@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@end
@implementation BRBaseNavgationView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.rightFirstBtn.hidden = YES;
    self.rightSecondBtn.hidden = YES;
//    _backView1.backgroundColor = [UIColor colorWithHexString:@"2C93FF"];
//    _backView2.backgroundColor = [UIColor colorWithHexString:@"0x2C93FF"];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.rightFirstBtn.hidden = YES;
        self.rightSecondBtn.hidden = YES;
    }
    return self;
}
- (void)handleItemClickBlock:(void(^)(BRBaseNavgationViewType type))block
{
    _itemClickBlock = block;
}
- (void)resetRightBtnState
{
    [_rightFirstBtn setImage:[UIImage new] forState:UIControlStateNormal];
    [_rightFirstBtn setTitle:@"" forState:UIControlStateNormal];
    [_rightSecondBtn setImage:[UIImage new] forState:UIControlStateNormal];
    [_rightSecondBtn setTitle:@"" forState:UIControlStateNormal];
}
- (IBAction)backClick:(id)sender {
    if (_itemClickBlock) {
        _itemClickBlock(BRBaseNavgationViewTypeBack);
    }
}

- (void)setIsShowWhiteImg:(BOOL)isShowWhiteImg{
    _isShowWhiteImg = isShowWhiteImg;
    if (_isShowWhiteImg) {
        [_backBtn setImage:[UIImage imageNamed:@"navigation_back_w_icon"] forState:UIControlStateNormal];
    }
    
}
- (void)setHasBack:(BOOL)hasBack
{
    _hasBack = hasBack;
    _backWidth.constant = _hasBack ? 55 : 0;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}
- (void)setIsRed:(BOOL)isRed
{
    _isRed = isRed;
    if (_isRed) {
        _backView1.backgroundColor = [UIColor colorWithHexString:@"d95940"];
        _backView2.backgroundColor = [UIColor colorWithHexString:@"d95940"];
    }else{
        _backView1.backgroundColor = [UIColor colorWithHexString:@"2C93FF"];
        _backView2.backgroundColor = [UIColor colorWithHexString:@"2C93FF"];
    }
}
- (void)setTitleCenter:(BOOL)titleCenter
{
    _titleCenter = titleCenter;
    _titleLabel.textAlignment = _titleCenter ? NSTextAlignmentCenter : NSTextAlignmentLeft;
}
- (void)setRightFirstName:(NSString *)name icon:(NSString *)icon btnType:(BtnType)btnType resultAction:(ActionBlock)block
{
    _rightFirstBtn.hidden = NO;
    if (name && name.length > 0) {
        [_rightFirstBtn setTitle:name forState:UIControlStateNormal];
    }
    if (icon && icon.length > 0) {
        [_rightFirstBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
    _rightFirstBtn.btnType = btnType;
    _firstBtnBlock = block;
}

- (void)setRrihtFirstBtnImg:(NSString *)iconName name:(NSString *)name{
    if (iconName && iconName.length > 0) {
        [_rightFirstBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    }
    if (name && name.length > 0) {
        [_rightFirstBtn setTitle:name forState:UIControlStateNormal];
    }
}
- (IBAction)firstBtnAction:(id)sender {
    if (_firstBtnBlock) {
        _firstBtnBlock();
    }
}
- (void)updateRightBtn:(NSString *)right
{
    [_rightFirstBtn setTitle:right forState:UIControlStateNormal];
}
- (void)setRightSecondName:(NSString *)name icon:(NSString *)icon btnType:(BtnType)btnType resultAction:(ActionBlock)block
{
    _rightSecondBtn.hidden = NO;
    if (name && name.length > 0) {
        [_rightSecondBtn setTitle:name forState:UIControlStateNormal];
    }
    if (icon && icon.length > 0) {
        [_rightSecondBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
    _rightSecondBtn.btnType = btnType;
    _secondBtnBlock = block;
}
- (IBAction)secondBtnAction:(id)sender {
    if (_secondBtnBlock) {
        _secondBtnBlock();
    }
}

- (void)setIsBagImage:(BOOL)isBagImage{
    _isBagImage = isBagImage;
    if (_isBagImage) {
        _backView1.backgroundColor = [UIColor clearColor];
        _backView2.backgroundColor = [UIColor clearColor];
        _backImage.image = [UIImage imageNamed:@"title_head_bg_three"];
    }else{
        _backView1.backgroundColor = [UIColor whiteColor];
        _backView2.backgroundColor = [UIColor whiteColor];
    }
}
//- (void)setHasSearch:(BOOL)hasSearch
//{
//    _hasSearch = hasSearch;
//    if (_hasSearch) {
//        if (!_searchBar) {
//            [self loadSearchView];
//        }else{
//            _searchBar.hidden = NO;
//        }
//    }else{
//        if (_searchBar) {
//            _searchBar.hidden = YES;
//        }
//    }
//}
- (void)loadSearchView
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [self addSubview:_searchBar];
    weakSelf(self);
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(50);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        make.right.mas_equalTo(self.mas_right).offset(weakSelf.rightFirstBtn.hidden ? -10 : -50);
        make.height.mas_equalTo(34);
    }];
   
    _searchBar.backgroundColor = RGB(24, 202, 211);
    [_searchBar setBackgroundImage:[UIImage imageWithColor:RGB(44, 147, 255)]];
    self.backgroundColor = RGB(24, 202, 211);
    _searchBar.delegate = self;
    _searchBar.placeholder = @"群聊/好友/聊天";
    _searchBar.showsSearchResultsButton = NO;
    _searchBar.showsCancelButton = NO;
    //    [_searchBar setImage:[UIImage imageNamed:@"mesg_5"]
    //        forSearchBarIcon:UISearchBarIconSearch
    //                   state:UIControlStateNormal];
    //    [self.view addSubview:_searchBar];
    //    self.navigationItem.titleView = _searchBar;
    if (@available(iOS 11.0, *))
    {
//        [_searchBar setPositionAdjustment:UIOffsetMake((_searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0) forSearchBarIcon:UISearchBarIconSearch];
    }
    self.clipsToBounds = YES;
}
- (void)handleSearchBarTextChangeClick:(void(^)(NSString *context))block
{
    _searcBarTextChange = block;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (_searcBarTextChange) {
        _searcBarTextChange(searchText);
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if (@available(iOS 11.0, *))
    {
        [searchBar setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    if (@available(iOS 11.0, *))
    {
        if (searchBar.text.length == 0) {
//            [searchBar setPositionAdjustment:UIOffsetMake((searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0) forSearchBarIcon:UISearchBarIconSearch];
        }
    }
    [self searchBarResignFirstResponder];
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}
- (void)searchBarBecomeFirstResponder
{
    [_searchBar becomeFirstResponder];
}
- (void)searchBarResignFirstResponder
{
    [_searchBar resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
