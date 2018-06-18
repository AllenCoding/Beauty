//
//  WelfareCell.m
//  Beauty
//
//  Created by LiuYong on 2018/6/6.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "WelfareCell.h"


@interface WelfareCell ()

@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation WelfareCell

-(void)setModel:(WelfareModel *)model{
    _model=model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"placeholder_image"]];
    self.timeLabel.text=[model.publishedAt substringToIndex:10];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
