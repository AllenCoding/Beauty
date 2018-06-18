//
//  topicCell.m
//  Beauty
//
//  Created by LiuYong on 2018/6/7.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "topicCell.h"
@interface topicCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *timeLable;

@end


@implementation topicCell

+(instancetype)configCellWithTableView:(UITableView *)tableview{
    topicCell*cell=[tableview dequeueReusableCellWithIdentifier:@"topicCell"];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"topicCell" owner:self options:nil].lastObject;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}


-(void)setData:(HomeData *)data{
    _data=data;
    self.titleLabel.text=data.desc.length?data.desc:@"";
    self.iconView.hidden=!data.images.count;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:data.images.count?data.images[0]:@""] placeholderImage:[UIImage imageNamed:@"home_placeholder_image"]];
    
    NSString*time=[data.createdAt substringToIndex:10];
    NSString*uploader=[NSString stringWithFormat:@"%@  %@",data.who,time];
    self.timeLable.text=uploader;
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];

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
