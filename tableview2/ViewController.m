//
//  ViewController.m
//  tableview2
//
//  Created by Mac User on 2015/2/17.
//  Copyright (c) 2015年 www. All rights reserved.
//

#import "ViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (strong,nonatomic) NSMutableArray *InfoArray;
@end

@implementation ViewController

-(void)doneCust{
    if (self.flag==1) {
        //新增存擋
        [_messageDic setValue:_titleText.text forKey:@"title"];
        [_messageDic setValue:_dateText.text forKey:@"date"];
        [_messageDic setValue:_contentText.text forKey:@"content"];
        [_messageDic setValue:_InfoArray[0] forKey:@"image"];

        
        [self.Delegate ViewController:self messageDic:_messageDic];
    }else if (_flag==2){
        //修改存擋
        [self.Delegate ViewController:self messageDic:self.messageDic];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneCust)];
    self.navigationItem.rightBarButtonItem=doneButton;
    _messageDic =[NSMutableDictionary new];
    _InfoArray=[NSMutableArray new];
    //    self.noText.enabled=NO;
    
    
    if (_flag==1) {
        self.title=@"New Message";
        
    }else if(_flag==2){
        self.title=@"Edit Message";
        _InfoArray[0]=_messageDic[@""];
        _titleText.text=_messageDic[@""];
        _dateText.text=_messageDic[@""];
        _contentText.text=_messageDic[@""];
        _imageView1.image=_InfoArray[0];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)imagePickerBtn:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新增圖片" message:@"選取方式" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *pickerImageView =[[UIImagePickerController alloc] init];
        pickerImageView.delegate=self;
        //如果要使用相機要先測試iDevice是否有相機
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerImageView.sourceType=UIImagePickerControllerSourceTypeCamera;
        }else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
            pickerImageView.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
        }
        
        pickerImageView.mediaTypes =@[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
        
        [self presentViewController:pickerImageView animated:YES completion:nil];

        
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"從相簿" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *pickerImageView =[[UIImagePickerController alloc] init];
        pickerImageView.delegate=self;
        pickerImageView.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImageView.mediaTypes =@[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
        
        [self presentViewController:pickerImageView animated:YES completion:nil];

            }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"關閉" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:cameraAction];
    [alertController addAction:albumAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

    }

#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    CGRect new = CGRectMake(78, 335, 70, 70);
    
    new.origin.x+=80;
    [UIView animateWithDuration:0.5 animations:^{
        [_button setFrame:new];
    }];
//    NSLog(@"%@",info);
    self.imageView1.image =info[UIImagePickerControllerOriginalImage];
    [_InfoArray addObject:info[UIImagePickerControllerOriginalImage]];
//    NSLog(@"%@",_InfoArray);

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
