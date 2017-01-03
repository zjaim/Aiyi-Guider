//
//  FourthViewController.m
//  爱易
//
//  Created by 路伟饶 on 2016/7/20.
//  Copyright © 2016年 xiaolu. All rights reserved.
//

#import "FourthViewController.h"
#import <Foundation/Foundation.h>

@interface SettingsCell : NSObject

@property (nonatomic,copy,nonnull) NSString *cellTitle;
@property (nonatomic,copy) NSString *cellDetails;
- (SettingsCell *)initWithTitle:(nonnull NSString *)title andDetails:(NSString *)details;
- (NSString *)getCellTitle;
- (NSString *)getCellDetails;

@end

@interface SettingsSection : NSObject

@property (nonatomic,copy) NSString *sectionTitle,*sectionDetails;
@property (nonatomic,strong) NSMutableArray *cells;
- (SettingsSection *)initWithTitle:(NSString *)title andCells:(NSMutableArray *)cells andDetails:(NSString *)details;
- (NSString *)getSectionTitle;
- (NSMutableArray *)getCells;
- (NSString *)getSectionDetails;

@end

@implementation SettingsCell

- (SettingsCell *)initWithTitle:(nonnull NSString *)title andDetails:(NSString *)details {
    self=[super init];
    _cellTitle=title;
    _cellDetails=details;
    return self;
}
- (nonnull NSString *)getCellTitle {
    return _cellTitle;
}
- (NSString *)getCellDetails {
    return _cellDetails;
}

@end

@implementation SettingsSection

- (SettingsSection *)initWithTitle:(NSString *)title andCells:(NSMutableArray *)cells andDetails:(NSString *)details {
    self=[super init];
    _sectionTitle=title;
    _cells=cells;
    _sectionDetails=details;
    return self;
}
- (NSString *)getSectionTitle {
    return _sectionTitle;
}
- (NSMutableArray *)getCells {
    return _cells;
}
- (NSString *)getSectionDetails {
    return _sectionDetails;
}

@end

@interface FourthViewController ()

@property (weak, nonatomic) IBOutlet UITableView *settingsTable;
@property (nonatomic,strong) UITableViewCell *cell;
@property (nonatomic,strong) NSMutableArray *settingsSection;
@property (nonatomic,strong) NSUserDefaults *settingsValue;
@property (nonatomic,weak) UISwitch *touchidSwitcher;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_touchidSwitcher setOn:(false)];
    SettingsCell *touchIDSettingsCell=[[SettingsCell alloc]initWithTitle:(@"使用Touch ID登录") andDetails:(@"启用指纹登录功能")];
    SettingsCell *aboutSettingsCell=[[SettingsCell alloc]initWithTitle:(@"致谢") andDetails:(@"关于本程序")];
    NSMutableArray *section0Cells=[[NSMutableArray alloc]initWithObjects:(touchIDSettingsCell),(aboutSettingsCell), nil];
    SettingsSection *section0=[[SettingsSection alloc]initWithTitle:(@"通用") andCells:(section0Cells) andDetails:(@" ")];
    _settingsSection=[NSMutableArray arrayWithObjects:(section0), nil];
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {  //指定分区的个数
    return _settingsSection.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  //指定每个分区内行数的方法
    return [_settingsSection[section] getCells].count;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {  //指定分区标题的方法
    return [_settingsSection[section] getSectionTitle];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //加载每个单元格时调用的方法
    static NSString *cellIdentifier=@"UITableViewCellIdentifier";      //建立单元格标识符
    _cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];     //先尝试从缓存池中取出已经加载的单元格
    if(!_cell){      //如果缓存池中没有该单元格到则重新创建，并放到缓存池中
        _cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    _cell.textLabel.text=[[_settingsSection[indexPath.section] getCells][indexPath.row] getCellTitle];
    _cell.detailTextLabel.text=[[_settingsSection[indexPath.section] getCells][indexPath.row] getCellDetails];
    return _cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //点按TableViewCell单元格触发的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];   //点击后反光高亮效果立即消失
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
