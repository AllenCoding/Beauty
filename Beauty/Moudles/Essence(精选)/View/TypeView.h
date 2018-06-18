//
//  TypeView.h
//  Beauty
//
//  Created by LiuYong on 2018/6/9.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeViewDelegate <NSObject>

-(void)didSelectType:(NSString*)type;

@end


@interface TypeView : UIViewController

@property(nonatomic,weak)id<TypeViewDelegate>delegate;

@end
