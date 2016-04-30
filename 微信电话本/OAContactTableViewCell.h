//
//  OAContactTableViewCell.h
//  微信电话本
//
//  Created by 黄坤 on 16/4/26.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OAContact;
@interface OAContactTableViewCell : UITableViewCell
/**
 *  数据模型
 */
@property (strong, nonatomic) OAContact *contactModel;
/**
 *  快速创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
