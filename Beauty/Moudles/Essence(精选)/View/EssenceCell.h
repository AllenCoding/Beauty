//
//  EssenceCell.h
//  Beauty
//
//  Created by LiuYong on 2018/6/9.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EssenceCell : UITableViewCell

@property(nonatomic,strong)HomeData*data;


+(instancetype)configCellWithTableView:(UITableView*)tableview;


@end
