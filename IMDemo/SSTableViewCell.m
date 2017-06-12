//
//  SSTableViewCell.m
//  IMDemo
//
//  Created by lss on 2017/6/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "SSTableViewCell.h"
#import "SSUserModel.h"

@interface SSTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UILabel *messageContent;

@end

@implementation SSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _messageContent.lineBreakMode = NSLineBreakByTruncatingTail;
    _messageContent.numberOfLines = 1;
    _messageContent.font = [UIFont systemFontOfSize:12.f];
    _messageContent.textColor = [UIColor grayColor];
}

-(void)setUserModel:(SSUserModel *)userModel
{
    _userModel = userModel;
    
    _iconImage.image = [UIImage imageNamed:userModel.userIcon];
    _nickName.text = userModel.nickName;
    
    NSString *messageType = userModel.messageModel.objectName;
    NSString *messageContent = nil;
    if(messageType){
        if([messageType isEqualToString:@"RC:TxtMsg"]){
            //文本信息
            RCTextMessage *message = (RCTextMessage *)userModel.messageModel.content;
            messageContent = message.content;
        }else if([messageType isEqualToString:@"RC:VcMsg"]){
            //语音信息
            messageContent = @"[语音]";
        }else if([messageType isEqualToString:@"RC:ImgMsg"]){
            //图片信息
            messageContent = @"[图片]";
        }else{
            //地理信息 RC:LBSMsg
            messageContent = @"[位置]";
        }
    }
    _messageContent.text = messageContent;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
