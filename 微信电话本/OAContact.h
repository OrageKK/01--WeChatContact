//
//  OAContact.h
//  微信电话本
//
//  Created by 黄坤 on 16/4/26.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAContact : NSObject<NSCoding>
/**
 *  姓名
 */
@property (nonatomic,copy) NSString * name;
/**
 *  电话
 */
@property (nonatomic,copy) NSString * phoneNum;
/**
 *  类方法快速创建模型
 */
+ (instancetype)contactWithName:(NSString *)name phoneNum:(NSString *)phoneNum;
@end
