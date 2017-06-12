//
//  SSConversationViewController.h
//  IMDemo
//
//  Created by lss on 2017/6/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

typedef void(^Complention)(RCMessageModel *messageModel);

@interface SSConversationViewController : RCConversationViewController

@property (nonatomic, copy) Complention complention;

@end
