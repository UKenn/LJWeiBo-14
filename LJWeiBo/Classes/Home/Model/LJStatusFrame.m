//
//  LJStatusFrame.m
//  LJWeiBo
//
//  Created by qianfeng on 15-8-12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJStatusFrame.h"
#import "LJStatus.h"
#import "LJUser.h"
#import "NSString+Extension.h"

/**间距*/
#define LJStatusCellBorder 5
/** 时间的字体*/
#define LJStatusNameFont [UIFont systemFontOfSize:15]
/** 来源的字体*/
#define LJStatusTimeFont [UIFont systemFontOfSize:12]
/** 昵称的字体*/
#define LJStatusSourceFont [UIFont systemFontOfSize:12]
/** 正文的字体*/
#define LJStatusContentFont [UIFont systemFontOfSize:13]

@implementation LJStatusFrame

/**
 *  根据传进来的数据，计算子控件的frame
 */
- (void)setStatus:(LJStatus *)status
{
    _status = status;
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    //1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    //2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = LJStatusCellBorder;
    CGFloat iconViewY = LJStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + LJStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    //
    NSDictionary *nameDict =@{NSFontAttributeName:LJStatusNameFont};
    CGSize nameLabelSize = [status.user.name  sizeWithAttributes:nameDict];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY},nameLabelSize};
    
    //4.会员图标
    if (status.user.vip) {
        
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + LJStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + LJStatusCellBorder;
    //
    NSDictionary *timeDict =@{NSFontAttributeName:LJStatusTimeFont};
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:timeDict];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY},timeLabelSize};
    
    //6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + LJStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    //
    NSDictionary *sourceDict =@{NSFontAttributeName:LJStatusSourceFont};
    CGSize sourceLabelSize = [status.source sizeWithAttributes:sourceDict];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY},sourceLabelSize};
    //7.微博正文
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + LJStatusCellBorder;
    CGFloat contentLabelMaxW = topViewW - 2 * LJStatusCellBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:LJStatusContentFont maxSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY},contentLabelSize};
    //topView的高度
    CGFloat topViewH = CGRectGetMaxY(_contentLabelF) + LJStatusCellBorder;
    _topViewF = CGRectMake(topViewX,topViewY,topViewW,topViewH);
    
    //8.配图
    
    
    _cellHeight = topViewH;
}


@end
