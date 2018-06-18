//
//  HomeCell.m
//  Beauty
//
//  Created by LiuYong on 2018/6/6.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "HomeCell.h"


@interface HomeCell()
@property (strong, nonatomic) IBOutlet UILabel *markTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *firstIv;
@property (strong, nonatomic) IBOutlet UIImageView *secondIv;
@property (strong, nonatomic) IBOutlet UIImageView *thirdIv;
@property (strong, nonatomic) IBOutlet UILabel *markLabel;


@end
@implementation HomeCell

+(instancetype)configCellWithTableView:(UITableView *)tableview{
    HomeCell*cell=[tableview dequeueReusableCellWithIdentifier:@"HomeCell"];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"HomeCell" owner:self options:nil].lastObject;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}


-(void)setData:(HomeData *)data{
    _data=data;
    self.markTitleLabel.text=data.desc.length?data.desc:@"";
    self.firstIv.hidden=!data.images.count;
    self.firstIv.hidden=!data.images.count;
    self.firstIv.hidden=!data.images.count;

    [self.firstIv sd_setImageWithURL:[NSURL URLWithString:data.images.count?data.images[0]:@""] placeholderImage:[UIImage imageNamed:@"home_placeholder_image"]];
    [self.secondIv sd_setImageWithURL:[NSURL URLWithString:data.images.count>=2?data.images[1]:@""] placeholderImage:[UIImage imageNamed:@"home_placeholder_image"]];
    [self.thirdIv sd_setImageWithURL:[NSURL URLWithString:data.images.count>=3?data.images[2]:@""] placeholderImage:[UIImage imageNamed:@"home_placeholder_image"]];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];

    NSString*time=[data.createdAt substringToIndex:10];
    NSString*uploader=[NSString stringWithFormat:@"%@  %@",data.who,time];
    self.markLabel.text=uploader;

}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
