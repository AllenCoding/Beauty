//
//  topicCell.h
//  Beauty
//
//  Created by LiuYong on 2018/6/7.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface topicCell : UITableViewCell

@property(nonatomic,strong)HomeData*data;

+(instancetype)configCellWithTableView:(UITableView*)tableview;

@end
