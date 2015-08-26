//
//  LJStatusFrame.h
//  LJWeiBo
//
//  Created by qianfeng on 15-8-12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
/** 时间的字体*/
#define LJStatusNameFont [UIFont systemFontOfSize:15]
/** 来源的字体*/
#define LJStatusTimeFont [UIFont systemFontOfSize:12]
/** 昵称的字体*/
#define LJStatusSourceFont [UIFont systemFontOfSize:12]
/** 正文的字体*/
#define LJStatusContentFont [UIFont systemFontOfSize:13]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LJStatus;
@interface LJStatusFrame : NSObject
@property (nonatomic,strong) LJStatus *status;


/** 顶部 */
@property (nonatomic,assign,readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic,assign,readonly) CGRect iconViewF;
/** 会员 */
@property (nonatomic,assign,readonly) CGRect vipViewF;
/** 配图 */
@property (nonatomic,assign,readonly) CGRect photoViewF;


/** 昵称 */
@property (nonatomic,assign,readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic,assign,readonly) CGRect timeLabelF;
/** 来源 */
@property (nonatomic,assign,readonly) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic,assign,readonly) CGRect contentLabelF;


/** 被转发的微博 */
@property (nonatomic,assign,readonly) CGRect retweetViewF;
/** 被转发的微博的昵称 */
@property (nonatomic,assign,readonly) CGRect retweetNameLabelF;
/** 被转发的微博的正文 */
@property (nonatomic,assign,readonly) CGRect retweetContentLabelF;
/**被转发的微博的配图 */
@property (nonatomic,assign,readonly) CGRect retweetPhotoViewF;

/**cell的高度*/
@property (nonatomic,assign,readonly) CGFloat cellHeight;
@end
