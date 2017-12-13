//
//  CMNoMessageView.m
//  LoanInternalPlus
//
//  Created by wenglx on 2017/10/3.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMDefaultInfoView.h"
#import "CMColor.h"
#import "UIView+JYExtension.h"

@implementation CMDefaultInfoView

- (instancetype)initDefaultInfoViewWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title showButton:(BOOL)isShow
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        self.imageView.image = [UIImage imageNamed:imageName];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.hintLabel.text = title;
        self.reloadButton.hidden = !isShow;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (instancetype)defaultInfoViewWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title showButton:(BOOL)isShow
{
    CMDefaultInfoView *defaultView = [[CMDefaultInfoView alloc] initDefaultInfoViewWithFrame:frame imageName:imageName title:title showButton:isShow];
    return defaultView;
}

- (void)setUpUI
{
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    
    self.hintLabel = [[UILabel alloc] init];
    self.hintLabel.textColor = HRGB(@"666666");
    self.hintLabel.font = [UIFont systemFontOfSize:18];
    self.hintLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.hintLabel];
    
    self.reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [self.reloadButton setTitleColor:HRGB(@"0C9BFF") forState:UIControlStateNormal];
    self.reloadButton.titleLabel.font = [UIFont systemFontOfSize:18];
    self.reloadButton.width = 84;
    self.reloadButton.layer.cornerRadius = 17;
    self.reloadButton.layer.masksToBounds = YES;
    self.reloadButton.layer.borderColor = HRGB(@"0C9BFF").CGColor;
    self.reloadButton.layer.borderWidth = 1.0;
    [self.reloadButton addTarget:self action:@selector(reloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.reloadButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.hintLabel sizeToFit];
    self.hintLabel.centerX = self.width/2;
    self.hintLabel.centerY = self.centerY;
//    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//    }];
//
    [self.imageView sizeToFit];
    self.imageView.centerX = self.width/2;
    self.imageView.y = self.hintLabel.y - 20 - self.imageView.height;
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.hintLabel.mas_top).offset(-20);
//        make.centerX.equalTo(self.hintLabel);
//    }];
    [self.reloadButton sizeToFit];
    self.reloadButton.width = self.reloadButton.width + 20;
    if (self.reloadButton.width <100) {
        self.reloadButton.width = 100;
    }
    self.reloadButton.y = self.hintLabel.maxY + 20;
    self.reloadButton.height = 34;
    self.reloadButton.centerX = self.width/2;
//    [self.reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.hintLabel.mas_bottom).offset(20);
//        make.width.equalTo(@84);
//        make.height.equalTo(@34);
//        make.centerX.equalTo(self.hintLabel);
//    }];
}

#pragma mark - 事件监听
- (void)reloadButtonClick
{
    if (self.reloadActionBlock) {
        self.reloadActionBlock();
    }
}


@end
