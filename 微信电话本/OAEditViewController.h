//
//  OAEditViewController.h
//  微信电话本
//
//  Created by 黄坤 on 16/4/26.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OAContact,OAEditViewController;
@protocol OAEditViewControllerDelegate <NSObject>

@optional
//- (void)editController:(HMEditController *)editVc didFinishEditContact;
- (void)didFinishEditedContact:(OAEditViewController *)editVc;


@end

@interface OAEditViewController : UIViewController
/**
 *  要被编辑的联系人
 */
@property (strong, nonatomic) OAContact *editContact;
/**
 *  代理
 */
@property (weak, nonatomic) id<OAEditViewControllerDelegate> delegate;
@end
