//
//  OAContact.m
//  微信电话本
//
//  Created by 黄坤 on 16/4/26.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import "OAContact.h"
#define OA_CTNAME @"OA_CTNAME"
#define OA_CTNUMBER @"OA_CTNUMBER"
@implementation OAContact
#pragma mark - 归档解档的协议方法

//归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:OA_CTNAME];
    [aCoder encodeObject:self.phoneNum forKey:OA_CTNUMBER];
}

//归档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:OA_CTNAME];
        self.phoneNum = [aDecoder decodeObjectForKey:OA_CTNUMBER];
    }
    return self;
}


+ (instancetype)contactWithName:(NSString *)name phoneNum:(NSString *)phoneNum{
    OAContact *model = [[self alloc] init];
    model.name = name;
    model.phoneNum = phoneNum;
    return model;
}
@end
