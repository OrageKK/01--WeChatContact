//
//  OAContactTableViewCell.m
//  微信电话本
//
//  Created by 黄坤 on 16/4/26.
//  Copyright © 2016年 wzpnyg. All rights reserved.
//

#import "OAContactTableViewCell.h"
#import "OAContact.h"
@interface OAContactTableViewCell () {
    
    /**
     *  分割线
     */
    UIView *_divedeLine;
    
}

@end
@implementation OAContactTableViewCell
/**
 *  快速创建cell的方法
 */
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"contact";
    OAContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 要想通过故事板中的原型cell进行创建,才能执行跳转,所以代码创建的就注释了.
    
        if (cell == nil) {
            cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
            // 箭头
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    
    return cell;
}

//重写set方法分发数据
-(void)setContactModel:(OAContact *)contactModel{
    _contactModel = contactModel;
    //姓名
    self.textLabel.text = contactModel.name;
    //电话
    self.detailTextLabel.text = contactModel.phoneNum;
}
#pragma mark - 添加分割线
// 这么写就是不管代码还是xib文件加载都能hold住
// 代码走的
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSepertorLine];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        [self setupSepertorLine];
//    }
//    return self;
//}

#pragma mark - 添加一根分割线进来
- (void)setupSepertorLine {
    
    // MARK: - 分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    line.alpha = 0.5;
    
    // 注意:添加到contentView里面
    [self.contentView addSubview:line];
    
    // 两种写法
    _divedeLine = line;
    //    self->_divedeLine = line;
    
}
#pragma mark - 布局分割线
- (void)layoutSubviews {
#warning 不要缺少super
    [super layoutSubviews];
    
    CGFloat height = 1;
    CGFloat width = self.bounds.size.width;
    
    CGFloat x = 0;
    CGFloat y = self.bounds.size.height - height;
    
    _divedeLine.frame = CGRectMake(x, y, width, height);
}

@end
