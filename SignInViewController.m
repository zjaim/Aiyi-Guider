//
//  SignInViewController.m
//  爱易
//
//  Created by 路伟饶 on 2016/8/23.
//  Copyright © 2016年 xiaolu. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *UserAccountText;
@property (weak, nonatomic) IBOutlet UITextField *PasswordText;
@property (weak, nonatomic) IBOutlet UISwitch *SwitchButtonPassword;
@property (weak, nonatomic) IBOutlet UISwitch *SwitchButtuoAdmin;
@property (weak, nonatomic) IBOutlet UILabel *UserLabel;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)Tap:(id)sender {        //点按手势控制器触发时激活
    [_UserAccountText resignFirstResponder];
    [_PasswordText resignFirstResponder];
}
- (IBAction)SwitchButtonPasswordChanged:(id)sender {        //显示／隐藏密码切换按钮
    if(_SwitchButtonPassword.isOn==YES) {
        [_PasswordText setSecureTextEntry:(NO)];
    }
    else {
        [_PasswordText setSecureTextEntry:(YES)];
    }
}
- (IBAction)SwitchButtonAdminChanged:(id)sender {       //普通用户／管理用户切换按钮
    if(_SwitchButtuoAdmin.isOn==YES) {
        [_UserLabel setText:(@"管理帐号")];
    }
    else {
        [_UserLabel setText:(@"发布帐号")];
    }
}
- (IBAction)startLoginAction:(id)sender {       //开始登录
    LAContext *context=[[LAContext alloc]init];     //初始化鉴定控制器
    NSError *error=nil;
    NSString *localizedReasonString=@"验证Touch ID以登录";       //权限说明字符串
    if([context canEvaluatePolicy:(LAPolicyDeviceOwnerAuthenticationWithBiometrics) error:(&error)]) {      //请求使用Touch ID鉴定模块
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedReasonString reply:^(BOOL success,NSError *error) {        //请求鉴定用户Touch ID指纹
            if(success) {       //鉴定Touch ID指纹成功
                UIAlertController *loginSuccessful=[UIAlertController alertControllerWithTitle:(@"提示") message:(@"Touch ID认证成功") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *OkButton=[UIAlertAction actionWithTitle:(@"好") style:UIAlertActionStyleDefault handler:(nil)];
                [loginSuccessful addAction:(OkButton)];
                [self presentViewController:(loginSuccessful) animated:(YES) completion:(nil)];
            }
            else {          //鉴定Touch ID指纹失败
                UIAlertController *loginFailed=[UIAlertController alertControllerWithTitle:(@"错误") message:(@"Touch ID认证失败") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *OkButton=[UIAlertAction actionWithTitle:(@"好") style:UIAlertActionStyleDefault handler:(nil)];
                [loginFailed addAction:(OkButton)];
                [self presentViewController:(loginFailed) animated:(YES) completion:(nil)];
            }
        }];
    }
    else {      //设备不支持Touch ID或者未启用Touch ID，或者Touch ID尝试失败次数已到阀值
        UIAlertController *TouchIDFailed=[UIAlertController alertControllerWithTitle:(@"错误") message:(@"设备不支持或未启用Touch ID") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OkButton=[UIAlertAction actionWithTitle:(@"好") style:UIAlertActionStyleDefault handler:(nil)];
        [TouchIDFailed addAction:(OkButton)];
        [self presentViewController:(TouchIDFailed) animated:(YES) completion:(nil)];
    }
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
