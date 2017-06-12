//
//  SSConversationViewController.m
//  IMDemo
//
//  Created by lss on 2017/6/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "SSConversationViewController.h"

@interface SSConversationViewController ()

@end

@implementation SSConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)dealloc
{
    if(self.complention){
        RCMessageModel *messageModel = self.conversationDataRepository.lastObject;
        self.complention(messageModel);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
