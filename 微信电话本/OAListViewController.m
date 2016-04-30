//
//  OAListViewController.m
//  微信电话本
//
//  Created by 黄坤 on 16/4/26.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import "OAListViewController.h"
#import "OAContact.h"
#import "OAContactTableViewCell.h"
#import "OAAddViewController.h"
#import "OAEditViewController.h"
#import "OAAddViewController.h"
@interface OAListViewController ()<OAAddViewControllerDelegate,OAEditViewControllerDelegate>
/**
 *  保存所有联系人的模型数组
 */
@property (strong, nonatomic) NSMutableArray<OAContact *> *contactArrM;
//@property (strong, nonatomic) OAAddViewController *addVc;
//@property (strong, nonatomic) OAEditViewController *editVc;
@end

@implementation OAListViewController{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // MARK: - 取消多余的行
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // MARK: - 取消系统的分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

#pragma mark - 设置控件
- (void)setupUI{
    //注销按钮
    UIBarButtonItem *signout = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(signOut)];
    [self.navigationItem setLeftBarButtonItem:signout];
    
    
    //添加按钮
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goAddVc)];
    //    [self.navigationItem setRightBarButtonItem:add];
    
    
    //删除按钮
    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashItemClick:)];
    
    
    //添加rightBarButton
    NSArray *rightBtn = [NSArray arrayWithObjects:add,delete,nil];
    
    [self.navigationItem setRightBarButtonItems:rightBtn animated:YES];
    
    //添加backbutton
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backBtn;
    
}


/**************************** 删除联系人 *****************************/

- (void)trashItemClick:(id)sender {
    // 修改tableView的一个属性,就可以显示减号
    
    //    self.tableView.editing = YES;
    //    if (self.tableView.isEditing) {
    //        self.tableView.editing = NO;
    //    } else {
    //        self.tableView.editing = YES;
    //    }
    //显示减号后 再点击垃圾桶要回到不编辑状态.
    // 直接通过取反的形式设置
    self.tableView.editing = !self.tableView.isEditing;
}
#pragma mark - tableView的代理方法
// commit 提交   实现此代理方法,即可实现向左滑动,显示delete按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.从集合中删除对应的联系人
    [self.contactArrM removeObjectAtIndex:indexPath.row];
    
    // 2.刷新表格
    [self.tableView reloadData];
#pragma mark - 3.删除联系人存储一下
    [self saveContacts];
    
}

// 作用,实现此代理方法,可以修改向左滑动时,显示的删除按钮的title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"DIY删除";
    
}
#pragma mark - 设置代理并跳转界面
//跳转添加界面
- (void)goAddVc{
    OAAddViewController *addVc = [[OAAddViewController alloc] init];
    //MARK:设置代理
    addVc.delegate = self;
    [self.navigationController pushViewController:addVc animated:YES];
}
//跳转编辑界面

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OAEditViewController *editVc = [[OAEditViewController alloc] init];
#warning delegate 在哪里获取控制器对象,就在哪里设置代理
    //MARK:2.设置代理
    editVc.delegate = self;
    //3.设置数据
    //获取选中的数据
    //获取选中行的索引
    NSIndexPath *selectIdex = [self.tableView indexPathForSelectedRow];
    //获取数据
    OAContact *selectContact = self.contactArrM[selectIdex.row];
    //给要编辑的联系人赋值
    editVc.editContact = selectContact;
    [self.navigationController pushViewController:editVc animated:YES];
}


/**************************** 删除联系人 *****************************/

//#pragma mark - 设置代理
//在prepare方法中获取目标控制器
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"ADD"]) {
//        //获取添加控制器对象
//        //destina 目标,目的地    获取目标控制器
//        OAAddViewController *addVc = segue.destinationViewController;
//        //设置代理
//        addVc.delegate = self;
//    }else if([segue.identifier isEqualToString:@"EDIT"]){
//        HMLog(@"跳转到编辑控制器");
//        //1.获取编辑控制器对象
//        OAEditViewController *editVc = segue.destinationViewController;
//        //2.设置代理
//        editVc.delegate = self;
//        //3.设置数据
//            //获取选中的数据
//            //获取选中行的索引
//        NSIndexPath *selectIdex = [self.tableView indexPathForSelectedRow];
//            //获取数据
//        OAContact *selectContact = self.contactArrM[selectIdex.row];
//            //给要编辑的联系人赋值
//        editVc.editContact = selectContact;
//    }
//
//}


#pragma mark - 实现代理方法
- (void)addController:(OAAddViewController *)addVc wantToAddContact:(OAContact *)addCt{
    //先把联系人存到数组
    [self.contactArrM addObject:addCt];
    
    //刷新数据
    // 2.刷新
    // 全局刷新
    //    [self.tableView reloadData];
    // 局部刷新
    /**
     *  如果是添加数据  insert
     *
     *  如果是修改数据  reload
     *
     *  如果是删除数据  delete
     */
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.contactArrM.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
#pragma mark - 1.添加好联系人存储一下
    [self saveContacts];
    
}
// MARK: - 编辑联系人的代理方法
- (void)didFinishEditedContact:(OAEditViewController *)editVc {
    
    // 直接让列表刷新,读取最新的数据
    [self.tableView reloadData];
    
#pragma mark - 2.编辑联系人存储一下
    [self saveContacts];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contactArrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    OAContactTableViewCell *cell = [OAContactTableViewCell cellWithTableView:tableView];
    //设置数据
    cell.contactModel = self.contactArrM[indexPath.row];
    
    //返回cell
    return cell;
}
/************************联系人数据的存储***********************/
// 可以直接归档模型数组
// 前提:模型里面的对象必须要遵守协议NSCoding协议,实现对应的方法.
#pragma mark - 保存所有的联系人数据
- (void)saveContacts{
    //归档
    //1.文件路径
    NSString *ctsFilePath = [self filePathWithName:@"OA_contact.oa"];
    //2.存储
    
    [NSKeyedArchiver archiveRootObject:self.contactArrM toFile:ctsFilePath];
}



/**
 *  返回存储文件路径的方法
 */
- (NSString *)filePathWithName:(NSString *)fileName {
    
    // 1.读取沙盒中document的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 2.拼接文件路径并返回
    return [docPath stringByAppendingPathComponent:fileName];
}


#pragma mark - 懒加载
- (NSMutableArray<OAContact *> *)contactArrM{
    if (_contactArrM == nil) {
        
        
#pragma mark - 4 读取数据 防 nil
        
        _contactArrM = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePathWithName:@"OA_contact.oa"]];
        
        //第一次读取为空,屏蔽掉数组为空的错误
        if (_contactArrM == nil) {
            //如果为空,实例化对象
            _contactArrM =[[NSMutableArray alloc] init];
        }
        
    }
    return _contactArrM;
}

#pragma mark - 注销按钮被点击时调用
- (void)signOut{
    //1.创建一个AlertController
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出吗?" preferredStyle:UIAlertControllerStyleActionSheet];
    //2.创建两个按钮
    //注销按钮
    UIAlertAction *outAction = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //点击注销返回登录控制器
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //3.把按钮添加到AlertVc
    [alertVc addAction:outAction];
    [alertVc addAction:cancelAction];
    //4.显示ALertVc
    [self presentViewController:alertVc animated:YES completion:nil];
}

@end
