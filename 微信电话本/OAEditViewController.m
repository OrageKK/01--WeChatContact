//
//  OAEditViewController.m
//  微信电话本
//
//  Created by 黄坤 on 16/4/26.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import "OAEditViewController.h"
#import "OAContact.h"

@implementation OAEditViewController{
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
    UIButton *_saveBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self stupUI];
    [self settingFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    // MARK: - 设置数据
    _nameField.text = self.editContact.name;
    _phoneNumField.text = self.editContact.phoneNum;
    NSLog(@"%@",_phoneNumField.text);
    // MARK: - 监听保存按钮的点击
    [_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 添加控件
- (void)stupUI{
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //用户名
    UITextField *name = [[UITextField alloc] init];
    name.borderStyle = 3;
    name.placeholder = @"姓名";
    name.clearButtonMode = 1;
    name.enabled = NO;
    [self.view addSubview:name];
    _nameField = name;
    //密码
    UITextField *phoneNum = [[UITextField alloc] init];
    phoneNum.borderStyle = 3;
    phoneNum.placeholder = @"电话";
    phoneNum.clearButtonMode = 1;
    phoneNum.enabled = NO;
    [self.view addSubview:phoneNum];
    _phoneNumField = phoneNum;
    
    //添加按钮
    UIButton *saveBtn = [[UIButton alloc] init];
    [saveBtn setTitle:@"保      存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    saveBtn.font = [UIFont systemFontOfSize:15.0];
    saveBtn.hidden = YES;
    [self.view addSubview:saveBtn];
    _saveBtn = saveBtn;
    
    
    //编辑按钮
    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editItemClick:)];
    self.navigationItem.rightBarButtonItem = editBtn;
    
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
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(_phoneNumField);
        make.top.mas_equalTo(_phoneNumField.mas_bottom).offset(85);
    }];
    
    
}


#pragma mark - 当点击编辑按钮时调用
- (void)editItemClick:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        
        // 编辑文字
        // 取消
        sender.title = @"取消";
        // 两个文本框可以编辑了
        _nameField.enabled = YES;
        _phoneNumField.enabled = YES;
        
        // 保存按钮出来了
        _saveBtn.hidden = NO;
        [_saveBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        // 让电话文本框成为第一响应者
        [_phoneNumField becomeFirstResponder];
    }else{
        
        // 取消文字
        // 编辑
        sender.title = @"编辑";
        // 两个文本框取消编辑
        _nameField.enabled = NO;
        _phoneNumField.enabled = NO;
        // 保存按钮不见了
        _saveBtn.hidden = YES;
        // 需要恢复联系人信息
        _nameField.text = self.editContact.name;
        _phoneNumField.text = self.editContact.phoneNum;
    }
    
    
    
    

    
    
}
#pragma mark - 当点击保存按钮的时候调用
- (void)saveBtnClick {
    
    // 1.修改模型数据
    self.editContact.name = _nameField.text;
    self.editContact.phoneNum = _phoneNumField.text;
    
    // 2.让列表刷新 // 通过代理让列表刷新
    if ([self.delegate respondsToSelector:@selector(didFinishEditedContact:)]) {
        [self.delegate didFinishEditedContact:self];
    }
    
    
    // 3.返回
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


@end
