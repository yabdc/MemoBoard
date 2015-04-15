//
//  ViewController.h
//  tableview2
//
//  Created by Mac User on 2015/2/17.
//  Copyright (c) 2015年 www. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@protocol ViewControllerDelegate <NSObject>

-(void) ViewController:(ViewController *)ViewController messageDic:(NSDictionary *)message;

@end
@interface ViewController : UIViewController

@property (assign,nonatomic) NSInteger flag;//1.新增  2.修改
@property (nonatomic,strong) NSMutableDictionary *messageDic;
@property (strong,nonatomic) id<ViewControllerDelegate> Delegate;
@property (strong,nonatomic) NSDictionary *receiveEditDic;
@end

