//
//  CountListViewController.m
//  Pay
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CountListViewController.h"
#import "BankCountModel.h"
#import "AppUtil.h"
@interface CountListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>

@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) UISearchController *searchController;
@property(strong, nonatomic) NSMutableArray *dataList;
@property(strong, nonatomic) NSMutableArray *searchList;
@end

@implementation CountListViewController

-(NSMutableArray *)dataList{
    if(_dataList == nil){
        _dataList = [BankCountModel creatModelInType:self.type];
        
    }
    return _dataList;
}

-(NSMutableArray *)searchList{
    if(_searchList == nil){
        _searchList = [NSMutableArray arrayWithCapacity:5];
    }
    return _searchList;
}

-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UISearchController *)searchController{
    if(_searchController == nil){
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
//        _searchController.obscuresBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
        // 添加 searchbar 到 headerview
        self.tableView.tableHeaderView = _searchController.searchBar;
      
    }
    return _searchController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.searchController.active){
        return self.searchList.count;
    }else{
        return self.dataList.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    if(self.searchController.active){
        BankCountModel *mode = self.searchList[indexPath.row];
        [self cell:cell value:mode];
        
        
    }else{
        BankCountModel *mode = self.dataList[indexPath.row];
        [self cell:cell value:mode];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.searchController.active){
        self.searchController.active = NO;
        [self.delegate callBackModel:self.searchList[indexPath.row] type:self.type];
        
    }else{
        [self.delegate callBackModel:self.dataList[indexPath.row] type:self.type];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cell:(UITableViewCell *)cell value:(BankCountModel *)mode{
    
    cell.imageView.image = [UIImage imageNamed:mode.bankLogo];
    cell.textLabel.text = mode.bankName;
    cell.detailTextLabel.text = mode.countName;

}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{

    NSString *searchString = [self.searchController.searchBar text];
    if(searchString != nil && ![searchString isEqualToString:@""]){
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"bankName CONTAINS %@ OR countName CONTAINS %@",searchString,searchString];
    if(self.searchList != nil){
        [self.searchList removeAllObjects];
    }
    NSArray *array = [self.dataList filteredArrayUsingPredicate:preicate];
    self.searchList = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
    }
}
- (void)didDismissSearchController:(UISearchController *)searchController{
    [self.tableView reloadData];
}
@end
