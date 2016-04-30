//
//  OAAddViewController.m
//  微信电话本
//
//  Created by 黄坤 on 16/4/26.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import "OAAddViewController.h"
#import "OAContact.h"
@interface OAAddViewController ()


@end

@implementation OAAddViewController{
    /**
     *  用户名
     */
    UITextField *_nameField;
    /**
     *  密码
     */
    UITextField *_phoneNumField;
    /**
     *  添加
     */
    UIButton *_addsBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加控件
    [self stupUI];
    
    //布局
    [self settingFrame];
    

    //监听文本框内容的改变
    //通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:_nameField];
     [center addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:_phoneNumField];
    
    //监听添加按钮的点击事件
    [_addsBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 添加控件
- (void)stupUI{
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //用户名
    UITextField *name = [[UITextField alloc] init];
    name.borderStyle = 3;
    name.placeholder = @"姓名";
    name.clearButtonMode = 1;
    [self.view addSubview:name];
    _nameField = name;
    //密码
    UITextField *phoneNum = [[UITextField alloc] init];
    phoneNum.borderStyle = 3;
    phoneNum.placeholder = @"电话";
    phoneNum.clearButtonMode = 1;
    [self.view addSubview:phoneNum];
    _phoneNumField = phoneNum;
    
    //添加按钮
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setTitle:@"添      加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    addBtn.font = [UIFont systemFontOfSize:15.0];
    addBtn.enabled = NO;
    [self.view addSubview:addBtn];
    _addsBtn = addBtn;

}

#pragma mark - 布局
- (void)settingFrame{
    //用户名
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(40);
        make.leading.mas_equalTo(self.view.mas_leading).offset(20);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-20);
    }];
    
    //密码
    [_phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(_nameField);
        make.top.mas_equalTo(_nameField.mas_bottom).offset(30);
        
    }];
    
    //添加按钮
    [_addsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(_phoneNumField);
        make.top.mas_equalTo(_phoneNumField.mas_bottom).offset(85);
    }];
    

}

// 当文本框内容发生改变时调用
/**
 *  通知里面的两个信息
 object
 userInfo 字典
 */
- (void)textChange:(NSNotification *)noti {
    
    HMLog(@"%@", [[noti object] text]);
    // 获取姓名和电话,如果都有内容,才能够点击添加按钮
    // 1.获取姓名和电话
    NSString *name = _nameField.text;
    NSString *phone = _phoneNumField.text;
    
    // 2.判断
    if (name.length > 0 && phone.length > 0) {
        _addsBtn.enabled = YES;
        //改变按钮文字颜色
        [_addsBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    } else {
        
        _addsBtn.enabled = NO;
    }
    
}
#pragma mark - 添加按钮的点击事件
- (void)addBtnClick{
    //获取数据
    NSString *name = _nameField.text;
    NSString *num = _phoneNumField.text;
    
    //将联系人转换为模型
    OAContact *addContact = [OAContact contactWithName:name phoneNum:num];
    
    //将模型数据传给列表控制器
    // MARK: - 3.让自己的代理对象执行协议方法 代理   好处: 解耦
    if ([self.delegate respondsToSelector:@selector(addController:wantToAddContact:)]) {
        [self.delegate addController:self wantToAddContact:addContact];
        NSLog(@"代理有响应");
    }else{
        NSLog(@"代理无响应");
    }
    
    //自己pop出去
    [self.navigationController popViewControllerAnimated:YES];
}

@end
