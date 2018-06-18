//
//  ArticleCell.m
//  Beauty
//
//  Created by LiuYong on 2018/6/7.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "ArticleCell.h"


@interface ArticleCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *uploaderLabel;

@end

@implementation ArticleCell

+(instancetype)configCellWithTableView:(UITableView *)tableview{
    ArticleCell*cell=[tableview dequeueReusableCellWithIdentifier:@"ArticleCell"];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"ArticleCell" owner:self options:nil].lastObject;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}


-(void)setData:(HomeData *)data{
    _data=data;
    self.titleLabel.text=data.desc.length?data.desc:@"";
    NSString*time=[data.publishedAt substringToIndex:10];
    NSString*uploader=[NSString stringWithFormat:@"%@  %@",data.who,time];
    self.uploaderLabel.text=uploader;

    
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
