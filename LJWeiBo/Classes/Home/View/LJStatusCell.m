//
//  LJStatusCell.m
//  LJWeiBo
//
//  Created by qianfeng on 15-8-12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJStatusCell.h"
#import "LJStatus.h"
#import "LJStatusFrame.h"
#import "LJUser.h"
#import "UIImageView+WebCache.h"

@interface LJStatusCell ()

/** 顶部 */
@property (nonatomic,weak) UIImageView * topView;
/** 头像 */
@property (nonatomic,weak) UIImageView * iconView;
/** 会员 */
@property (nonatomic,weak) UIImageView * vipView;
/** 配图 */
@property (nonatomic,weak) UIImageView * photoView;


/** 昵称 */
@property (nonatomic,weak) UILabel * nameLabel;
/** 时间 */
@property (nonatomic,weak) UILabel * timeLabel;
/** 来源 */
@property (nonatomic,weak) UILabel * sourceLabel;
/** 正文 */
@property (nonatomic,weak) UILabel * contentLabel;


/** 被转发的微博 */
@property (nonatomic,weak) UIImageView * retweetView;
/** 被转发的微博的昵称 */
@property (nonatomic,weak) UILabel * retweetNameLabel;
/** 被转发的微博的正文 */
@property (nonatomic,weak) UILabel * retweetContentLabel;
/**被转发的微博的配图 */
@property (nonatomic,weak) UIImageView * retweetPhotoView;


/**微博的工具条 */
@property (nonatomic,weak) UIImageView * statusToolBar;
@end
@implementation LJStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        //2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        //3.添加微博的工具条
        [self setupStatusToolBarSubviews];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{
    /** 1.顶部view */
    UIImageView * topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    /** 2.头像view */
    UIImageView * iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /** 3.会员view */
    UIImageView * vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    /** 4.配图view */
    UIImageView * photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    /** 5.昵称view */
    UILabel * nameLabel= [[UILabel alloc] init];
    nameLabel.font = LJStatusNameFont;
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 6.时间view */
    UILabel * timeLabel = [[UILabel alloc] init];
    timeLabel.font =LJStatusTimeFont;
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 7.来源view */
    UILabel * sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = LJStatusSourceFont;
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 8.正文view */
    UILabel * contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = LJStatusContentFont;
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
}
/**
 *  添加被转发微博内部的子控件
 */
- (void)setupRetweetSubviews
{
    /** 1.被转发的微博 */
    UIImageView * retweetView = [[UIImageView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 2.被转发的微博的昵称 */
    UILabel * retweetNameLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /** 3.被转发的微博的正文 */
    UILabel * retweetContentLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 4.被转发的微博的 配图 */
    UIImageView * retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}
/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBarSubviews
{
    /**微博的工具条 */
    UIImageView * statusToolbar = [[UIImageView alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolBar = statusToolbar;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setStatusFrame:(LJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //1.原创微博
    [self setupOriginalData];
    //2.被转发微博
    [self setupRetweetData];
}
/**
 *  原创微博
 */
- (void)setupOriginalData{
    //1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    //2.iconView
    LJStatus *status = self.statusFrame.status;
    LJUser *user = status.user;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    //3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    //4.vip
    if (user.vip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
        self.vipView.frame = self.statusFrame.vipViewF;
    }else{
        self.vipView.hidden = YES;
    }
    
    
    //5.时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = self.statusFrame.timeLabelF;
    
    //6.来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    //7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
//    NSLog(@"self.contentLabel.text%@",self.contentLabel.text);

}
/**
  *  原创微博
  */
- (void)setupRetweetData{
    
}

@end
