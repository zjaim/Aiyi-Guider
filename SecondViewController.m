//
//  SecondViewController.m
//  爱易
//
//  Created by 路伟饶 on 2016/7/20.
//  Copyright © 2016年 xiaolu. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *TopSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *SearchResultTableView;
@property (nonatomic,strong) CLGeocoder *Geocoder;  //地理编码器的实例
@end

@implementation SecondViewController

NSMutableArray *ResultPlaces;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)UserTapView:(id)sender {
    [_TopSearchBar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton=YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;
    if(_Geocoder==nil) {
        _Geocoder=[[CLGeocoder alloc]init];
    }
    NSString *UserInputAddress=self.TopSearchBar.text;  //取搜索框中的字符串
    [self.Geocoder geocodeAddressString:(UserInputAddress) completionHandler:^(NSArray *placemarks, NSError *error) {   //开始地理位置编码（地名->经纬度坐标）
        if(error || placemarks.count==0) {
            UIAlertController *NoPlaceFound=[UIAlertController alertControllerWithTitle:(@"未找到结果") message:(@"请更换其它关键词再试") preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *OkButton=[UIAlertAction actionWithTitle:(@"好") style:UIAlertActionStyleDefault handler:(nil)];
            [NoPlaceFound addAction:(OkButton)];
            [self presentViewController:(NoPlaceFound) animated:(YES) completion:(nil)];
        }
        else {   //如果找到了地点
            ResultPlaces=[NSMutableArray array];
            for (CLPlacemark *placemark in placemarks) {
                [ResultPlaces addObject:(placemark.name)];
            }
            
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {  //指定分区的个数
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  //指定每个分区内行数的方法
    if(ResultPlaces==nil) {
        return 1;
    }
    else {
        return ResultPlaces.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //加载每个单元格时调用的方法
    static NSString *TableViewIdentifier=@"ResultTableView";  //单元格的唯一标识符
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableViewIdentifier];
    //声明TableViewCell单元格
    if(cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:TableViewIdentifier];   //如果不存在，先创建TableViewCell单元格
    }
    if(ResultPlaces!=nil) {
        cell.textLabel.text=[ResultPlaces objectAtIndex:indexPath.row];    //加载地点数组的值
    }
    else {
        cell.textLabel.text=nil;
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
