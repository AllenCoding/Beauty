//
//  EssenceCell.m
//  Beauty
//
//  Created by LiuYong on 2018/6/9.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "EssenceCell.h"


@interface EssenceCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *uploaderLabel;
@property (strong, nonatomic) IBOutlet UIView *cellBgView;

@end

@implementation EssenceCell


+(instancetype)configCellWithTableView:(UITableView *)tableview{
    EssenceCell*cell=[tableview dequeueReusableCellWithIdentifier:@"EssenceCell"];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"EssenceCell" owner:self options:nil].lastObject;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    return cell;
}

-(void)setData:(HomeData *)data{
    _data=data;
    self.titleLabel.text=data.desc.length?data.desc:@"";
    NSString*time=[data.publishedAt substringToIndex:10];
    NSString*uploader=[NSString stringWithFormat:@"By:%@  %@",data.who,time];
    self.uploaderLabel.text=uploader;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 设置阴影颜色
    self.cellBgView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    // 设置阴影的偏移量，默认是（0， -3）
    self.cellBgView.layer.shadowOffset = CGSizeMake(8, 8);
    // 设置阴影不透明度，默认是0
    self.cellBgView.layer.shadowOpacity = 0.9;
    // 设置阴影的半径，默认是3
//    self.cellBgView.layer.shadowRadius = 4;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
