//
//  OALoginViewController.m
//  微信电话本
//
//  Created by 黄坤 on 16/4/26.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import "OALoginViewController.h"
#import "OAListViewController.h"




@implementation OALoginViewController{
    /**
     *  用户名
     */
    UITextField *_userNameField;
    /**
     *  密码
     */
    UITextField *_passWordField;
    /**
     *  登录
     */
    UIButton *_loginBtn;
    /**
     *  记住密码lbl
     */
    UILabel *_rmbLbl;
    /**
     *  自动登录lbl
     */
    UILabel *_autoLbl;

    /**
     *  记住密码开关
     */
    UISwitch *_rememberSwitch;
    /**
     *  自动登录开关
     */
    UISwitch *_autoLoginSwitch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self settingFrame];
#pragma mark - 读取数据
    
    
    /****************** 登录数据读取 ****************/
    // 1.获取偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 2.读取数据
    _userNameField.text = [defaults objectForKey:OA_USERNAME];
    _passWordField.text = [defaults objectForKey:OA_PASSWORD];
    _rememberSwitch.on = [defaults boolForKey:OA_RMBSWITCH];
    _autoLoginSwitch.on = [defaults boolForKey:OA_ATOSWITCH];
    
    // 3.根据不同情况执行操作
    // 3.0 如果记住密码是关着的,就不要显示密码
    if (!_rememberSwitch.isOn) {
        // 清除密码
        _passWordField.text = nil;
    }
    
    
    // 3.1 如果自动登录打开,登录
    if (_autoLoginSwitch.isOn) {
        
        [self loginBtnClick:_loginBtn];
        
    }
    
    /**********************************************/
    
    //MARK:监听文本框内容的改变
    [_userNameField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [_passWordField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    //MARK:监听登录按钮的点击
    [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //MARK:监听开关按钮改变
    //值改变事件
    [_rememberSwitch addTarget:self action:@selector(rembSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_autoLoginSwitch addTarget:self action:@selector(autoSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //执行以下文本框内容判断操作
    [self textChange:nil];
    
}
#pragma mark - 创建控件
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"欢迎使用微信电话本";
    //用户名
    UITextField *user = [[UITextField alloc] init];
    user.borderStyle = 3;
    user.placeholder = @"请输入用户名";
//    user.text = @"OA";
    user.clearButtonMode = 1;
    [self.view addSubview:user];
    _userNameField = user;
    //密码
    UITextField *pwd = [[UITextField alloc] init];
    pwd.borderStyle = 3;
    pwd.placeholder = @"请输入密码";
//    pwd.text = @"123";
    pwd.secureTextEntry = YES;
    
    pwd.clearButtonMode = 1;
    [self.view addSubview:pwd];
    _passWordField = pwd;
    //登录按钮
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登      录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    loginBtn.font = [UIFont systemFontOfSize:15.0];
    loginBtn.enabled = NO;
//    loginBtn.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:loginBtn];
    _loginBtn = loginBtn;
    //记住密码label
    UILabel *rmb = [[UILabel alloc] init];
    rmb.font = [UIFont systemFontOfSize:17.0];
    rmb.text = @"记住密码";
    [self.view addSubview:rmb];
    _rmbLbl = rmb;
    //自动登录label
    UILabel *autolbl = [[UILabel alloc] init];
    autolbl.font = [UIFont systemFontOfSize:17.0];
    autolbl.text = @"自动登录";
    [self.view addSubview:autolbl];
    _autoLbl = autolbl;
    //记住密码开关
    UISwitch *rmbswitch = [[UISwitch alloc] init];
    [self.view addSubview:rmbswitch];
    _rememberSwitch = rmbswitch;
    //自动登录开关
    UISwitch *autoswitch = [[UISwitch alloc] init];
    [self.view addSubview:autoswitch];
    _autoLoginSwitch = autoswitch;
    
    
}
#pragma mark - 布局
- (void)settingFrame{
    //用户名
    [_userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(40);
        make.leading.mas_equalTo(self.view.mas_leading).offset(20);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-20);
    }];
    
    //密码
    [_passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(_userNameField);
        make.top.mas_equalTo(_userNameField.mas_bottom).offset(30);
        
    }];
    
    //登录按钮
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(_passWordField);
        make.top.mas_equalTo(_passWordField.mas_bottom).offset(85);
    }];
    
    //记住密码lbl
    [_rmbLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passWordField.mas_bottom).offset(25);
        make.leading.mas_equalTo(_passWordField);
    }];
    
    //自动登录lbl
    [_autoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_autoLoginSwitch.mas_centerY);
    }];
    //记住密码开关
    [_rememberSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_rmbLbl.mas_centerY);
        make.leading.mas_equalTo(_rmbLbl.mas_trailing).offset(15.0);
    }];
    
    
    //自动登录开关
    [_autoLoginSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_rememberSwitch.mas_centerY);
        make.trailing.mas_equalTo(_passWordField.mas_trailing);
        make.leading.mas_equalTo(_autoLbl.mas_trailing).offset(15.0);
    }];
    
}

#pragma mark - 文本框改变事件
- (void)textChange: (UITextField *)sender{
    //判断文本框的内容,如果用户名和密码都有内容才能够点击登录按钮
    NSString *userName = _userNameField.text;
    NSString *passWord = _passWordField.text;
    if (userName.length > 0 && passWord.length > 0) {
        _loginBtn.enabled = YES;
        //改变按钮字体颜色
        [_loginBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }else{
        _loginBtn.enabled = NO;
    }
}


#pragma mark - 登录按钮的点击事件
- (void)loginBtnClick: (UIButton *)sender{
    
    // MARK: - 用户提示
    // 1.创建hud
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    
    // 灰色效果
    //    hud.dimBackground = YES;
    // 2.设置信息
    hud.labelText = @"正在登录...";
    
    // 3.添加到视图
    [self.navigationController.view addSubview:hud];
    
    // 4.显示 bool 决定是否要动画
    [hud show:YES];
    
    
    NSString *userName = _userNameField.text;
    NSString *passWord = _passWordField.text;
    //延时2s
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([userName isEqualToString:@"OA"] && [passWord isEqualToString:@"123"]) {
            HMLog(@"执行登录操作, 隐藏提示框");
            /****************** 登录数据存储 ****************/
            // MARK: - 存储用户信息及开关状态
            // 需要存储的信息 用户名 密码 记住密码的开关 自动登录的开关
            // 1.获取偏好设置对象
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            // 2.存储数据
            [defaults setObject:_userNameField.text forKey:OA_USERNAME];
            [defaults setObject:_passWordField.text forKey:OA_PASSWORD];
            [defaults setBool:_rememberSwitch.isOn forKey:OA_RMBSWITCH];
            [defaults setBool:_autoLoginSwitch.isOn forKey:OA_ATOSWITCH];
            
            // 3.同步
            [defaults synchronize];
            
            NSLog(@"%@", NSHomeDirectory());
            /****************************************/
            // 登录成功时,隐藏别再有动画
            [hud hide:NO];
            // 需要移除
            [hud removeFromSuperview];
            
            //执行手动segue
            //sender传的对象作为以下方法的参数,用来在跳转之前做哪些操作
            //- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
            //
            //}
//            [self performSegueWithIdentifier:@"goListVc" sender:@"123"];
            OAListViewController *listVc = [[OAListViewController alloc]init];
            [self.navigationController pushViewController:listVc animated:YES];
            
        }else{
            hud.mode = MBProgressHUDModeText;
            
            hud.labelText = @"用户名或密码错误";
            
            [hud hide:YES afterDelay:1.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //从父控件移除
                [hud removeFromSuperview];
            });
            
            HMLog(@"用户名或密码错误, 给用户提示错误信息");
            
        }
        
    });
    
}


#pragma mark - 开关状态改变事件
//记住密码
- (void)rembSwitchValueChanged: (UISwitch *)sender{
    //记住密码关闭自动登录必须关闭
    if (sender.isOn == NO) {
        //        self.autoLoginSwitch.on = NO;
        //有动画
        [_autoLoginSwitch setOn:NO animated:YES];
    }
}
//自动登录
- (void)autoSwitchValueChanged: (UISwitch *)sender{
    //自动登录打开记住密码必须打开
    if (sender.isOn == YES) {
        [_rememberSwitch setOn:YES animated:YES];
    }
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//}
    
@end
