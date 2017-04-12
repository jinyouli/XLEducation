//
//  XLWeChatView.m
//  XLEducation
//
//  Created by kin on 15/5/5.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLWeChatView.h"

@implementation XLWeChatView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBACOLOR(10, 10, 10, 0.5);
        [self ControlsGenerate];
    }
    return self;
}

-(void)ControlsGenerate
{
    UIView *WeChatView = [[UIView alloc]initWithFrame:CGRectMake(50,((Screen_Height)-100)/2,(Screen_Width)-100, 100)];
    WeChatView.backgroundColor = [UIColor whiteColor];
    WeChatView.layer.masksToBounds = YES;
    WeChatView.layer.cornerRadius = 10;
    [self addSubview:WeChatView];
    
    NSArray *arrayWechat = @[@"朋友圈",@"会话",@"收藏"];
    NSArray *buttonArray = @[@"wechat_friends_icon@2x.png",@"wechat_icon@2x.png",@"wechat_collect_icon@2x.png"];
    NSArray *bIamgeArray = @[@"wechat_friends_icon.png",@"wechat_icon.png",@"wechat_collect_icon.png"];

    for (int i = 0; i < 3; i++) {
        UIButton *btn_y = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_y.tag = i;
        [btn_y setFrame:CGRectMake((WeChatView.frame.size.width-240)/4+((WeChatView.frame.size.width-240)/4+80)*i, 0,80, 80)];
        if (IOSVERSIONDevice) {
            [btn_y setImage:[UIImage imageNamed:[buttonArray objectAtIndex:i]] forState:(UIControlStateNormal)];
        }else{
            [btn_y setImage:[UIImage imageNamed:[bIamgeArray objectAtIndex:i]] forState:(UIControlStateNormal)];
        }
        [btn_y addTarget:self action:@selector(onSelectTimelineScene:) forControlEvents:UIControlEventTouchUpInside];
        [WeChatView addSubview:btn_y];
        
        UILabel *wechatitle = [[UILabel alloc]initWithFrame:CGRectMake((WeChatView.frame.size.width-240)/4+((WeChatView.frame.size.width-240)/4+80)*i, 70,80, 20)];
        wechatitle.textAlignment = NSTextAlignmentCenter;
        wechatitle.text = [arrayWechat objectAtIndex:i];
        [WeChatView addSubview:wechatitle];
        
    }
}

- (void)onSelectTimelineScene:(UIButton*)sender
{
    [self.delegate XLWeChatHieth];
    if (sender.tag == 0) {
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:[UIImage imageNamed:@"logo2.png"]];
        
        WXImageObject *ext = [WXImageObject object];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"logo420" ofType:@"jpg"];
        ext.imageData = [NSData dataWithContentsOfFile:filePath];
        
        message.mediaObject = ext;
        message.mediaTagName = @"WECHAT_TAG_JUMP_APP";
        message.messageExt = @"找家教就上选师网 —— http://51xuanshi.com";
        message.messageAction = @"<action>dotalist</action>";
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        [WXApi sendReq:req];
        NSLog(@"====[WXApi sendReq:req]===%hhd",[WXApi sendReq:req]);
        
    }
    else if(sender.tag == 1)
    {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"选师无忧";
        message.description = @"选师网 —— http://51xuanshi.com ——找家教，就上选师网，万名师资任你选！选师网是立足于互联网络，面向广大学院与社会提供家教服务的专业网站。网站建设于2003年6月，只用较短的时间立足于广州家教市场，成为广州本土十年的家教专家。我们的优势显而易见。";
        [message setThumbImage:[UIImage imageNamed:@"wechat_share_logo.png"]];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = @"https://itunes.apple.com/cn/app/xuan-shi-wu-you/id973791363?mt=8";
        message.mediaObject = ext;
        message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;
        [WXApi sendReq:req];
        
    }
    else if(sender.tag == 2)
    {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"选师无忧";
        message.description = @"选师无忧 —— http://51xuanshi.com ——找家教，就上选师网，万名师资任你选！选师网是立足于互联网络，面向广大学院与社会提供家教服务的专业网站。网站建设于2003年6月，只用较短的时间立足于广州家教市场，成为广州本土十年的家教专家。我们的优势显而易见。";
        [message setThumbImage:[UIImage imageNamed:@"wechat_share_logo.png"]];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = @"https://itunes.apple.com/cn/app/xuan-shi-wu-you/id973791363?mt=8";
        message.mediaObject = ext;
        message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneFavorite;
        [WXApi sendReq:req];
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
