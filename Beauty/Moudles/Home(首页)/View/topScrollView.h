//
//  topScrollView.h
//  Beauty
//
//  Created by LiuYong on 2018/6/5.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class topScrollView;

@protocol TopScrollViewDelegate <NSObject>

@required
-(void)topScrollView:(topScrollView*)scrollView DidFinishSelectAtIndexType:(NSString*)type;
@end

@interface topScrollView : UIView

@property(nonatomic,weak)id<TopScrollViewDelegate>delegate;

@end
