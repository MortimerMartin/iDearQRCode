//
//  ResultDisplayController.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/20.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "ResultDisplayController.h"
#import "PickingCell.h"
#import "PickingModel.h"
//#import "PickDetailVc.h"
//#import "PreloadDetailVC.h"
@interface ResultDisplayController ()
@property (nonatomic , strong) NSMutableArray * results;
@property (nonatomic , assign) BOOL tableViewStatusStytle;

@end

@implementation ResultDisplayController

static NSString * identifier = @"ResultPickingCell" ;

-(NSMutableArray *)results{
    if (_results == nil) {
        _results = [NSMutableArray arrayWithCapacity:0];
    }
    return _results;
}
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tableView.frame = CGRectMake(0, 40, kScreen_width, kScreen_height-40);
    self.tableView.backgroundColor = back_Color;
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PickingCell class] forCellReuseIdentifier:identifier];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PickingCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[PickingCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    cell.pickModel = self.results[indexPath.row];
//    cell.isLastCell = self.results.count - 1 == indexPath.row  ? YES : NO;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PickingModel * pick = self.results[indexPath.row];


    if (indexPath.row == self.results.count - 1) {
        return pick.height+10;
    }
    return pick.height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([_delegate respondsToSelector:@selector(didSelectRow:)]) {
     
        [_delegate didSelectRow:indexPath];
    }


}

#pragma mark UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{

    NSString * search_text = searchController.searchBar.text;
    if (self.results.count>0) {
        [self.results removeAllObjects];
    }

    for (PickingModel * pick in self.datas) {
        if ([pick.pickId.lowercaseString rangeOfString:search_text.lowercaseString].location != NSNotFound) {

            [self.results addObject:pick];
        }
    }

    [self.tableView reloadData];
}


//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return _tableViewStatusStytle == YES ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    _tableViewStatusStytle = YES;
//    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_upPickStatusStytle) {
        _upPickStatusStytle();
    }
//    _tableViewStatusStytle = NO;
//    [self setNeedsStatusBarAppearanceUpdate];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

@end
