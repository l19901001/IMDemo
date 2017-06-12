//
//  SSUserModel.h
//  IMDemo
//
//  Created by lss on 2017/6/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RCMessageModel.h>

@interface SSUserModel : NSObject
/**用户昵称*/
@property (nonatomic, copy) NSString * nickName;
/**用户 id*/
@property (nonatomic, copy) NSString *userId;
/**用户头像*/
@property (nonatomic, copy) NSString *userIcon;
/**发送的最后一条消息*/
@property (nonatomic, copy) NSString *lastMessage;
/**融云消息模型*/
@property (nonatomic, strong) RCMessageModel *messageModel;

@end
