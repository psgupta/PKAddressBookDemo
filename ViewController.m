//
//  ViewController.m
//  PKAddressBookDemo
//
//  Created by Randem IT on 11/02/16.
//  Copyright © 2016 RIT_MacMini. All rights reserved.
//

#import "ViewController.h"
#import "Contact.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrContacts;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FetchContacts *contactObj = [[FetchContacts alloc]init];
    arrContacts = [[contactObj fetchAllContacts] mutableCopy];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (Contact *)getContactObjectFor:(NSUInteger)pos
{
    return (pos < arrContacts.count) ? (Contact *)arrContacts[pos] : nil;
}
#pragma mark ----------------------------------------
#pragma mark - Table view data source & Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Contact *localObj = [self getContactObjectFor:indexPath.row];
    
    if(localObj)
    {
        return 44*[localObj getEmails].count;
    }
    return 55.0f;

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strCellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellIdentifier];
    }
    cell.textLabel.numberOfLines = 0;
    
    cell.textLabel.text = [self getCellTextLabelStringFor:indexPath.row];
    return cell;
}

- (NSMutableString *)getCellTextLabelStringFor:(NSUInteger)pos
{
    NSMutableString *strMutableText;
    
    Contact *localObj = [self getContactObjectFor:pos];
    
    if(localObj)
    {
        NSString *contactName = [localObj getName];
        
        NSArray *emailArray = [localObj getEmails];
        
        strMutableText = [contactName mutableCopy];
        
        for (NSString *emailString in emailArray ) {
            
            [strMutableText appendFormat:@"\n email :%@",emailString];
        }
    }
    
    return strMutableText;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
