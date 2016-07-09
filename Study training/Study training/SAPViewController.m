//
//  SAPViewController.m
//  Study training
//
//  Created by Andrey on 7/9/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "SAPViewController.h"

@interface SAPViewController ()
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation SAPViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    NSMutableArray *dataArray = [NSMutableArray new];
    for (NSUInteger counter = 1; counter <= 50; counter++) {
        [dataArray addObject:@(counter)];
    }
    
    self.data = dataArray.copy;
    
    self.tableView.editing = YES;
    
}
#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    NSNumber *dataElement = self.data[indexPath.row];
    cell.textLabel.text = dataElement.stringValue;
    
    switch (indexPath.row) {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.textLabel.text = @"UITableViewCellAccessoryCheckmark";
            break;
        
        case 1:
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
            cell.textLabel.text = @"UITableViewCellAccessoryDetailButton";
            break;
            
        case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"UITableViewCellAccessoryDisclosureIndicator";
            break;
            
        case 3:
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            cell.textLabel.text = @"UITableViewCellAccessoryDetailDisclosureButton";
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row >=5 ? : UITableViewCellEditingStyleInsert;
}



@end
