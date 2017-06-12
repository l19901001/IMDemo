//
//  ViewController.m
//  IMDemo
//
//  Created by lss on 2017/6/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "ViewController.h"
#import "SSUserModel.h"
#import "SSTableViewCell.h"
#import "SSConversationViewController.h"
#import "SSAnimationView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *rows;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) SSAnimationView *animationView;

@end

@implementation ViewController
static NSString *cellid = @"cellid";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    SSAnimationView *animationView = [[SSAnimationView alloc] init];
    [self.view addSubview:animationView];
    _animationView = animationView;
    [animationView startAnimation];
    
    animationView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(50)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"view":animationView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(50)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"view":animationView}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:animationView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:animationView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    self.navigationItem.title = @"好友列表";
    UITableView *tableView = [[UITableView alloc] init];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 50;
    CGRect rect = self.view.frame;
    tableView.frame = rect;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    UINib *nib = [UINib nibWithNibName:@"SSTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellid];
    [self.view addSubview:tableView];
    _tableview = tableView;
    
    [self.view bringSubviewToFront:animationView];

    [[RCIM sharedRCIM] initWithAppKey:@"pwe86ga5ph2t6"];
    [[RCIM sharedRCIM] connectWithToken:@"jZWhNPEj6NgtAChiTMWChz/OyIsoWX2hMDcNpJhk4PYtO4yg7C70mOOFAPzLBzJLAlPRp6hjRzz4OCn6I8QrxsHruxn2Dw9s" success:^(NSString *userId) {
        NSArray *array = [[RCIMClient sharedRCIMClient] getConversationList:@[@(1)]];
        NSMutableArray *arrayM = [NSMutableArray array];
        NSArray *icons = @[@"chatListCellHead", @"default_avatar"];
        NSArray *nickNames = @[@"测试一", @"测试二"];
        for (int i = 0; i < array.count; i++) {
            SSUserModel *userModel = [[SSUserModel alloc] init];
            RCConversation *conversation = array[i];
            
            NSString *icon = icons[i % 2];
            NSString *nickName = nickNames[i % 2];
            userModel.userIcon = icon;
            userModel.nickName = nickName;
            userModel.userId = conversation.targetId;
            RCMessageContent *textContent = (RCTextMessage *)conversation.lastestMessage;
            RCMessageModel *messageModel = [[RCMessageModel alloc] init];
            messageModel.objectName = conversation.objectName;
            if(textContent){
                messageModel.content = textContent;
            }
            userModel.messageModel = messageModel;
            [arrayM addObject:userModel];
        }
        self.rows = arrayM.copy;
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登录失败");
    } tokenIncorrect:^{
        NSLog(@"token过期或无效");
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)initModel
{
    NSMutableArray *arrayM = [NSMutableArray array];
    NSArray *icons = @[@"chatListCellHead", @"default_avatar"];
    NSArray *nickNames = @[@"测试一", @"测试二"];
    for(int i = 0; i < 20; i++){
        NSString *icon = icons[i % 2];
        NSString *nickName = nickNames[i % 2];
        SSUserModel *userModel = [[SSUserModel alloc] init];
        userModel.userIcon = icon;
        userModel.nickName = nickName;
        userModel.userId = [NSString stringWithFormat:@"%d", i+1];
        [arrayM addObject:userModel];
    }

    _rows = arrayM.copy;
}

-(void)setRows:(NSArray *)rows
{
    _rows = rows;
    if(rows.count == 0){
        [self initModel];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            _animationView.hidden = YES;
            [_animationView stopAniamtion];
            [_tableview reloadData];
        });
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rows.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];

    SSUserModel *model = _rows[indexPath.row];
    cell.userModel = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    SSUserModel *userModel = _rows[indexPath.row];
    SSConversationViewController *vc = [[SSConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:userModel.userId];

    vc.complention = ^(RCMessageModel *message){
        userModel.messageModel = message;
        [_tableview reloadData];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
