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
- (IBAction)Tap:(id)sender {
    [_UserAccountText resignFirstResponder];
    [_PasswordText resignFirstResponder];
}
- (IBAction)SwitchButtonPasswordChanged:(id)sender {
    if(_SwitchButtonPassword.isOn==YES) {
        [_PasswordText setSecureTextEntry:(NO)];
    }
    else {
        [_PasswordText setSecureTextEntry:(YES)];
    }
}
- (IBAction)SwitchButtonAdminChanged:(id)sender {
    if(_SwitchButtuoAdmin.isOn==YES) {
        [_UserLabel setText:(@"管理帐号")];
    }
    else {
        [_UserLabel setText:(@"发布帐号")];
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
