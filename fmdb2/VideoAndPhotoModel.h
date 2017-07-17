//
//  VideoAndPhotoModel.h
//  SwellPro
//
//  Created by smartyou on 2017/6/27.
//  Copyright © 2017年 MM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoAndPhotoModel : NSObject
// 可省略, 默认的主键id, 如果需要获取主键id的值, 可在自己的model中添加下面这个属性
@property (nonatomic, assign)NSInteger pkid;

@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,copy)NSString *time;

/** 媒体名字 */
@property (nonatomic, copy) NSString *name;

/** 媒体上传格式 图片是NSData，视频主要是路径名，也有NSData */
//@property (nonatomic, strong) id uploadType;

//兼容 MWPhotoBrowser 的附加属性

/** 媒体照片 */
//@property (nonatomic, strong) UIImage *image;
@property (nonatomic,strong) NSData *imageData;

/** url string image */
@property (nonatomic, copy) NSString *imageUrlString;

/** 时长 */
//@property (nonatomic,assign) CGFloat shichang;
/** iOS8 之后的媒体属性 */
//@property (nonatomic, strong) PHAsset *asset;

/** 是否属于可播放的视频类型 */
@property (nonatomic, assign) BOOL isVideo;

/** 视频的URL */
//@property (nonatomic, strong) NSURL *mediaURL;

@property(nonatomic)BOOL isChoose;
@end
