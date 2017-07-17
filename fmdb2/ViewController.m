//
//  ViewController.m
//  fmdb2
//
//  Created by LCHK on 17/7/12.
//  Copyright © 2017年 MM. All rights reserved.
//

#import "ViewController.h"
#import "JQFMDB.h"
#import "VideoAndPhotoModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (nonatomic,strong) JQFMDB *db;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        self.db = [JQFMDB shareDatabase];
        
        if (![self.db jq_isExistTable:@"videoAndImage"]) {
            [self.db jq_createTable:@"videoAndImage" dicOrModel:[VideoAndPhotoModel class]];
        }
    });
    if ([self.db jq_isExistTable:@"videoAndImage"]) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
}


- (IBAction)lookAction:(UIButton *)sender {
    //查找表中所有数据
    NSArray *personArr = [self.db jq_lookupTable:@"videoAndImage" dicOrModel:[VideoAndPhotoModel class] whereFormat:nil];
    NSLog(@"表中所有数据:%@", personArr);
    _numLabel.text = [NSString stringWithFormat:@"%d",personArr.count];

}
- (IBAction)addAction:(UIButton *)sender {
        VideoAndPhotoModel *video = [[VideoAndPhotoModel alloc] init];
    video.name = @"maomao";
    video.isVideo = YES;
    VideoAndPhotoModel *image = [[VideoAndPhotoModel alloc] init];
    image.name = @"lala";
    image.isVideo = NO;
    //    NSLog(@"last:%ld", (long)[self.db lastInsertPrimaryKeyId:@"videoAndImage"]);
    //保证线程安全插入一条数据, jq_inDatabase的block中即可保证线程安全
    [self.db jq_inDatabase:^{
        [self.db jq_insertTable:@"videoAndImage" dicOrModelArray:@[video, image]];
    }];
}
- (IBAction)deleteAllAction:(UIButton *)sender {
    //查找表中所有数据
    NSArray *personArr = [self.db jq_lookupTable:@"videoAndImage" dicOrModel:[VideoAndPhotoModel class] whereFormat:nil];
    [personArr enumerateObjectsUsingBlock:^(VideoAndPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //保证线程安全删除最后一条数据
        [self.db jq_inDatabase:^{
            [self.db jq_deleteTable:@"videoAndImage" whereFormat:[NSString stringWithFormat:@"WHERE pkid = %d",obj.pkid]];
        }];
    }];
    NSArray *resultArr = [self.db jq_lookupTable:@"videoAndImage" dicOrModel:[VideoAndPhotoModel class] whereFormat:nil];
    if (resultArr.count == 0) {
        NSLog(@"数据已全部删除");
    }
}


@end
