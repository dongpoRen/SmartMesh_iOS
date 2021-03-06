//
//  FFMeBindingTipView.m
//  SmartMesh
//
//  Created by Rain on 17/9/20.
//  Copyright © 2017年 SmartMesh Foundation All rights reserved.
//

#import "FFMeBindingTipView.h"

@interface FFMeBindingTipView ()

@property (nonatomic, strong) DDYButton *closeBtn;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) DDYButton *bindingBtn;

@property (nonatomic, strong) UILabel *tipLab;

@end

@implementation FFMeBindingTipView

+ (instancetype)tipView {
    return [[self alloc] initWithFrame:DDYRect(0, 0, DDYSCREENW, FFMeTipHight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupContentView];
        self.backgroundColor = DDY_White;
        self.layer.shadowColor = DDY_Black.CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -1);
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowRadius = 5;
    }
    return self;
}

- (void)setupContentView {
    
    _closeBtn = [DDYButton btnTitle:nil img:@"back_black" target:self action:@selector(handleClose:)];

    _titleLab = [self labelColor:DDY_Mid_Black font:DDYFont(15) text:DDYLocalStr(@"Binding mobile")];
    
    _bindingBtn = [DDYButton btnTitle:DDYLocalStr(@"Binding") img:nil target:self action:@selector(handleBinding:)];
    DDYBorderRadius(_bindingBtn.btnTitleColorN(FF_MAIN_COLOR).btnFont(DDYFont(15)), 4, 1, FF_MAIN_COLOR);
    
    _tipLab = [self labelColor:DDY_Small_Black font:DDYFont(14) text:DDYLocalStr(@"BindingTip")];
    
    [self addSubview:_closeBtn];
    [self addSubview:_titleLab];
    [self addSubview:_bindingBtn];
    [self addSubview:_tipLab];
}

#pragma mark 生成label
- (UILabel *)labelColor:(UIColor *)color font:(UIFont *)font text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = color;
    label.font = font;
    label.text = text;
    return label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(30);
    }];
    
    [_bindingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(self.mas_top).offset(7);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(24);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_closeBtn.mas_right).offset(12);
        make.right.mas_equalTo(_bindingBtn.mas_left).offset(-12);
        make.top.mas_equalTo(self.top).offset(8 );
        make.height.mas_equalTo(20);
    }];
    
    [_tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_closeBtn.mas_right).offset(12);
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.top.mas_equalTo(_bindingBtn.mas_bottom).offset(4);
        make.height.mas_equalTo(20);
    }];
}

- (void)handleClose:(UIButton *)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
}

- (void)handleBinding:(UIButton *)sender {
    if (self.bindingBlock) {
        self.bindingBlock();
    }
}

@end
