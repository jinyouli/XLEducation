//
//  ButtonView.m
//  TongFubao
//
//  Created by kin on 14-8-15.
//  Copyright (c) 2014年 MD313. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

@synthesize _cellButton;

- (id)initWithFrame:(CGRect)frame buttonTag:(NSInteger)newTag buttonTitle:(NSString *)newTitle
{
    self = [super initWithFrame:frame];
    if (self) {

        _cellButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _cellButton.frame = self.frame;
        _cellButton.tag  = newTag;
        _cellButton.backgroundColor = [UIColor whiteColor];
        _cellButton.selected = YES;
        _cellButton.titleLabel.text = newTitle;
        _cellButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cellButton setTitle:_cellButton.titleLabel.text forState:(UIControlStateNormal)];
        [_cellButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_cellButton setTitleEdgeInsets:(UIEdgeInsetsMake(0, 10, 0, (Screen_Width)-100))];
        [_cellButton setImage:[UIImage imageNamed:@"icon_im_arrow_close@2x.png"] forState:(UIControlStateNormal)];
        [_cellButton setImageEdgeInsets:(UIEdgeInsetsMake(0, 0, 0, (Screen_Width)-100))];
        [_cellButton addTarget:self action:@selector(clikButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_cellButton];
        
        for (int i = 0; i < 2; i++)
        {
            UIImageView *lineImageone = [[UIImageView alloc]init];
            lineImageone.tag = i;
            if (i==0) {
                lineImageone.frame = CGRectMake(0,0,(Screen_Width), 1);
            }else{
                lineImageone.frame = CGRectMake(0,50,(Screen_Width), 1);
            }
            lineImageone.image = [UIImage imageNamed:@"rule.png"];
            [self addSubview:lineImageone];
        }
        
    }
    return self;
}

-(void)clikButton:(UIButton *)sender
{
        if (sender.selected == YES)
        {
            [_cellButton setImage:[UIImage imageNamed:@"icon_im_arrow_open@2x.png"] forState:(UIControlStateNormal)];
            [self.delegate shouCell:sender];


            sender.selected = NO;
        }else
        {
            sender.selected = YES;
            [_cellButton setImage:[UIImage imageNamed:@"icon_im_arrow_close@2x.png"] forState:(UIControlStateNormal)];
            [self.delegate shouCell:sender];

        }
}

//[self rotateArrow:sender.tag with:0];
//-(void) rotateArrow:(NSInteger)tagBt with:(double)degree{
//    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        self.arrowImage.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
//    } completion:NULL];
//}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
















