//
//  ShowMessageVC.m
//  memoBoard
//
//  Created by 詹鎮豪 on 2015/4/13.
//  Copyright (c) 2015年 www. All rights reserved.
//

#import "ShowMessageVC.h"
#import "ViewController.h"
@interface ShowMessageVC ()<ViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeText;
@property (weak, nonatomic) IBOutlet UITextView *contentText;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ShowMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%@",_receiveDic);
    self.title=_receiveDic[@"title"];
    _timeText.text=_receiveDic[@"date"];
    _contentText.text=_receiveDic[@"content"];
    _imageView.image=_receiveDic[@"image"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressEditAction:(id)sender {
    ViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"customView"];
    vc.receiveEditDic=_receiveDic;
    vc.Delegate=self;
    vc.flag=2;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ViewController:(ViewController *)ViewController messageDic:(NSDictionary *)message{
    NSLog(@"get");
    _receiveDic=message;
    self.title=_receiveDic[@"title"];
    _timeText.text=_receiveDic[@"date"];
    _contentText.text=_receiveDic[@"content"];
    _imageView.image=_receiveDic[@"image"];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
