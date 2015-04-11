//
//  AdminMainTVC.m
//  tableview2
//
//  Created by 詹鎮豪 on 2015/4/9.
//  Copyright (c) 2015年 www. All rights reserved.
//

#import "AdminMainTVC.h"

@interface AdminMainTVC ()<UISearchBarDelegate>
{
    NSMutableArray *bandArray;
    NSMutableArray *origingroupListArr;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation AdminMainTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate=self;
    bandArray = [[NSMutableArray alloc]initWithObjects:@"一年甲班",@"三年六班",@"二年甲班",@"二年乙班",@"五年丙班",@"六年甲班",@"四年乙班",@"二乙班", nil];
    origingroupListArr = [[NSMutableArray alloc]initWithArray:bandArray];
}

- (IBAction)addBandAction:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"創造群組"
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString (@"群組名稱", nil);
     }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   UITextField *name = alertController.textFields.firstObject;
                                   [bandArray addObject:name.text];
                                   [self.tableView reloadData];
                               }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return bandArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryView = [self addCustAccessoryBtn];
    cell.textLabel.text= bandArray[indexPath.row];
    // Configure the cell...
    
    return cell;
}


-(UIButton *)addCustAccessoryBtn{
    UIImage *accessoryImg = [UIImage imageNamed:@"settings-25"];
    CGRect imgFrame = CGRectMake(0, 0, accessoryImg.size.width, accessoryImg.size.height);
    UIButton *custAccessoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [custAccessoryBtn setFrame:imgFrame];
    [custAccessoryBtn setBackgroundImage:accessoryImg forState:UIControlStateNormal];
    [custAccessoryBtn setBackgroundColor:[UIColor clearColor]];
    [custAccessoryBtn addTarget:self action:@selector(pressAccessoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return custAccessoryBtn;
    
}


-(void)pressAccessoryBtn:(UIButton *)button{
    //    NSLog(@"test sucess");
    //獲得Cell：button的上一層是UITableViewCell
    UITableViewCell *cell = (UITableViewCell *)button.superview;
    //然后使用indexPathForCell方法，就得到indexPath了~
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //  NSLog(@"%ld",(long)indexPath.row);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"一經刪除便無法復原" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //  利用NSMutableAttributedString，設定多種屬性及Range去變更alertController(局部或全部)字級、顏色，Range:“警告”為兩個字元，所以設定0~2
    NSMutableAttributedString *StringAttr = [[NSMutableAttributedString alloc]initWithString:@"警告"];
    [StringAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 2)];
    [StringAttr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [alertController setValue:StringAttr forKey:@"attributedTitle"];
    
    //Delete
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"刪除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSMutableAttributedString *delectstring = [[NSMutableAttributedString alloc]initWithString:@"刪除群組"];
        [delectstring addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, delectstring.length)];
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@""
                                              message:@"一經刪除便無法復原"
                                              preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:delectstring forKey:@"attributedTitle"];
       
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                   {
                                       [bandArray removeObjectAtIndex:indexPath.row];
                                       [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                                   }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }];
    //Rename
    UIAlertAction *renameAction = [UIAlertAction actionWithTitle:@"重新命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"重新命名"
                                              message:@""
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
         {
             textField.placeholder = @"群組名稱";
             textField.text=bandArray[indexPath.row];
         }];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       UITextField *name = alertController.textFields.firstObject;
                                       bandArray[indexPath.row]=name.text;
                                       [self.tableView reloadData];
                                   }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
        
        
        
    }];
    //Cancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"關閉" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:renameAction];
    [alertController addAction:deleteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //TODO: 若有資料庫要一併刪除
        [bandArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



#pragma mark - UISearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    NSLog(@"開始編輯");
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"按下Cancel");
    searchBar.text = nil;
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"按下Search");
    [searchBar resignFirstResponder];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"結束編輯");
    NSString *filter = searchBar.text;
    if (filter.length == 0) {
        bandArray = [[NSMutableArray alloc]initWithArray:origingroupListArr];
        [self.tableView reloadData];
        [searchBar resignFirstResponder];
    }else if(filter.length >0){
        NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:origingroupListArr];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",filter];
        [bandArray removeAllObjects];
        bandArray = [NSMutableArray arrayWithArray:[tempArray filteredArrayUsingPredicate:predicate]];
        [self.tableView reloadData];
        
        [searchBar resignFirstResponder];}
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"文字改變");
    NSString *filter = searchText;
    if (filter.length == 0) {
        bandArray = [[NSMutableArray alloc]initWithArray:origingroupListArr];
        [self.tableView reloadData];
        [searchBar resignFirstResponder];
    }else if(filter.length >0){
        NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:origingroupListArr];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",filter];
        [bandArray removeAllObjects];
        bandArray = [NSMutableArray arrayWithArray:[tempArray filteredArrayUsingPredicate:predicate]];
        
        [self.tableView reloadData];
        
        [searchBar resignFirstResponder];}
}


@end
