//
//  FourthViewController.m
//  爱易
//
//  Created by 路伟饶 on 2016/7/20.
//  Copyright © 2016年 xiaolu. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()
@property (weak, nonatomic) IBOutlet UITableView *SettingsTableView;

@end

@implementation FourthViewController

NSArray *settingsdata,*settingsdata1,*settingsdata2,*settingsdata3;

- (void)viewDidLoad {
    settingsdata1=[NSArray arrayWithObjects:@"发布帐号",nil];  //第1个分区的显示文字数组
    settingsdata2=[NSArray arrayWithObjects:@"预留1",@"预留2",@"预留3",nil];  //第2个分区的显示文字数组
    settingsdata3=[NSArray arrayWithObjects:@"关于",nil];   //第3个分区的显示文字数组
    settingsdata=[NSArray arrayWithObjects:settingsdata1,settingsdata2,settingsdata3,nil];   //由上述数组组成的数组
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  //指定每个分区内行数的方法
    switch(section) {
        case 0:
            return [settingsdata1 count];   //返回第1个分区的数组元素数
            break;
        case 1:
            return [settingsdata2 count];   //返回第2个分区的数组元素数
            break;
        case 2:
            return [settingsdata3 count];   //返回第3个分区的数组元素数
            break;
        default:
            return 0;
            break;
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {  //指定分区标题的方法
    switch(section) {
        case 0:
            return @"通用";   //返回第1个分区的标题
            break;
        case 1:
            return @"预留";   //返回第2个分区的标题
            break;
        case 2:
            return @"关于";   //返回第3个分区的标题
            break;
        default:
            return @" ";
            break;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {  //指定分区的个数
    return [settingsdata count];   //返回分区数组的数组元素数
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //加载每个单元格时调用的方法
    static NSString *TableViewIdentifier=@"SettingsTableView";  //单元格的唯一标识符
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableViewIdentifier];
    //声明TableViewCell单元格
    if(cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:TableViewIdentifier];   //如果不存在，先创建TableViewCell单元格
    }
    switch(indexPath.section) {   //判断当前加载的TableViewCell单元格的分区
        case 0:
            cell.textLabel.text=[settingsdata1 objectAtIndex:indexPath.row];    //第1分区加载对应数组的值
            break;
        case 1:
            cell.textLabel.text=[settingsdata2 objectAtIndex:indexPath.row];    //第2分区加载对应数组的值
            break;
        case 2:
            cell.textLabel.text=[settingsdata3 objectAtIndex:indexPath.row];    //第3分区加载对应数组的值
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //点按TableViewCell单元格触发的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];   //点击后反光高亮效果立即消失
    NSString* AlertTitle,*AlertMessage;
    switch (indexPath.section) {   //判断当前点按的TableViewCell单元格的分区
        case 2:
            AlertTitle=[[NSString alloc]initWithFormat:@"关于爱易"];
            AlertMessage=[[NSString alloc]initWithFormat:@"版本:1.0  开发者:小路"];
            break;
        default:
            AlertTitle=[[NSString alloc]initWithFormat:@"提示"];
            AlertMessage=[[NSString alloc]initWithFormat:@"此功能正在开发中，敬请期待！"];
            break;
    }
    UIAlertController *WarningAlert=[UIAlertController alertControllerWithTitle:(AlertTitle) message:(AlertMessage) preferredStyle:(UIAlertControllerStyleAlert)];    //创建警告视图
    UIAlertAction *OkButton=[UIAlertAction actionWithTitle:(@"好") style:(UIAlertActionStyleDefault) handler:(nil)];
      //创建警告视图按钮
    [WarningAlert addAction:(OkButton)];   //添加警告视图按钮
    [self presentViewController:(WarningAlert) animated:(YES) completion:(nil)];   //显示警告视图
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
