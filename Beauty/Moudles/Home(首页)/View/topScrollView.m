//
//  topScrollView.m
//  Beauty
//
//  Created by LiuYong on 2018/6/5.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "topScrollView.h"

@interface topScrollView()
@property(nonatomic,strong)UIButton*selectedBtn;
@property(nonatomic,strong)UIScrollView*sv;
@property(nonatomic,strong)UIView*lineView;

@end



@implementation topScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        NSArray*types=@[@"all",@"Android",@"iOS",@"前端",@"瞎推荐",@"App",@"拓展资源"];
        [self loadScrollViewWithFrame:frame andTypes:types];
    }
    return self;
}

-(void)loadScrollViewWithFrame:(CGRect)frame andTypes:(NSArray*)types{
    
    self.sv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.sv.showsVerticalScrollIndicator=NO;
    self.sv.showsHorizontalScrollIndicator=NO;
    self.sv.contentOffset=CGPointMake(0, 0);
    self.sv.contentSize=CGSizeMake(60*types.count, frame.size.height);
    [self addSubview:self.sv];
    
    for (int index = 0; index<types.count; index++) {
        UIButton*typeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        typeBtn.frame=CGRectMake(index*60, 5, 60, 30);
        [typeBtn setTitle:types[index] forState:UIControlStateNormal];
        [typeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [typeBtn setTitleColor:mainColor forState:UIControlStateSelected];
        typeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        typeBtn.tag=index;
        [typeBtn addTarget:self action:@selector(didClickOnType:) forControlEvents:UIControlEventTouchUpInside];
        [self.sv addSubview:typeBtn];
        if (index==0) {
            self.selectedBtn=typeBtn;
            typeBtn.selected=YES;
        }
    }
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 38, 60, 2)];
    self.lineView.backgroundColor=mainColor;
    [self.sv addSubview:self.lineView];
    

}

-(void)didClickOnType:(UIButton*)button{
    NSLog(@"%@",button.titleLabel.text);
    if (!button.isSelected) {
        self.selectedBtn.selected = !self.selectedBtn.selected;
        button.selected = !button.selected;
        self.selectedBtn = button;
    }
    self.lineView.frame=CGRectMake(button.tag*60, 38, 60, 2);
    if (self.delegate&&[self.delegate respondsToSelector:@selector(topScrollView:DidFinishSelectAtIndexType:)]) {
        [self.delegate topScrollView:self DidFinishSelectAtIndexType:button.titleLabel.text];
    }
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
