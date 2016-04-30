//
//  OAAddViewController.h
//  微信电话本
//
//  Created by 黄坤 on 16/4/26.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OAAddViewController,OAContact;
@protocol OAAddViewControllerDelegate <NSObject>

@optional
/**
 *  添加联系人方法
 *
 *  @param addVc 添加控制器
 *  @param addCt 要添加的联系人
 */
- (void)addController:(OAAddViewController *)addVc wantToAddContact:(OAContact *)addCt;



@end

@interface OAAddViewController : UIViewController
/**
 *  代理属性
 */
@property (weak, nonatomic) id<OAAddViewControllerDelegate> delegate;
@end
