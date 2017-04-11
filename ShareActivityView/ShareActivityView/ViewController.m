//
//  ViewController.m
//  ShareActivityView
//
//  Created by chenjie on 17/4/11.
//  Copyright © 2017年 chenjie. All rights reserved.
//

#import "ViewController.h"
#import "ShareItem.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addBtn];
}

-(void)addBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.center = self.view.center;
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addActivityViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}



-(void)addActivityViewController
{
    /**
     第一种：分享类型为纯图片
     */
//    UIImage *imageToShare = [UIImage imageNamed:@"111.jpg"];
//    UIImage *imageToShare1 = [UIImage imageNamed:@"222.jpg"];
//    UIImage *imageToShare2= [UIImage imageNamed:@"333.jpg"];
//    NSArray *itemArr = @[imageToShare,imageToShare1,imageToShare2];
    
    
    /**
     第二种：图片数组为img的本机缓存地址
     */
//    UIImage *imageToShare = [UIImage imageNamed:@"111.jpg"];
//    UIImage *imageToShare1 = [UIImage imageNamed:@"222.jpg"];
//    UIImage *imageToShare2= [UIImage imageNamed:@"333.jpg"];
//    NSArray *activityItems = @[imageToShare,imageToShare1,imageToShare2];
//    
//    NSMutableArray *items = [NSMutableArray array];
//    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//
//    for (int i = 0; i < activityItems.count; i++) {
//        //图片缓存的地址，自己进行替换
//        NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"/ShareWX%d.jpg",i]];
//        //把图片写进缓存，一定要先写入本地，不然会分享出错
//        [UIImageJPEGRepresentation(activityItems[i], .5) writeToFile:imagePath atomically:YES];
//        //把缓存图片的地址转成NSUrl格式
//        NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
//        //这个部分是自定义ActivitySource
//        ShareItem *item = [[ShareItem alloc] initWithData:activityItems[i] andFile:shareobj];
//        //分享的数组
//        [items addObject:item];
//    }
    
    /**
     第三种：图片数组为url的本机缓存地址
            url必须是图片的地址，不是网页的地址
     */
    NSArray *activityItems = @[
                             @"http://img3.duitang.com/uploads/item/201604/24/20160424132044_ZzhuX.jpeg",
                             @"http://v1.qzone.cc/avatar/201408/03/23/44/53de58e5da74c247.jpg%21200x200.jpg",
                             @"http://img4.imgtn.bdimg.com/it/u=1483569741,1992390913&fm=214&gp=0.jpg"];
    NSMutableArray *items = [NSMutableArray array];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    for (int i = 0; i < activityItems.count; i++) {
        //取出地址
        NSString *URL = [activityItems[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //把图片转成NSData类型
         NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
        //写入图片中
        UIImage *imagerang = [UIImage imageWithData:data];
        //图片缓存的地址，自己进行替换
        NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"/ShareWX%d.jpg",i]];
        //把图片写进缓存，一定要先写入本地，不然会分享出错
        [UIImageJPEGRepresentation(imagerang, .5) writeToFile:imagePath atomically:YES];
        //把缓存图片的地址转成NSUrl格式
        NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
        //这个部分是自定义ActivitySource
        ShareItem *item = [[ShareItem alloc] initWithData: imagerang andFile:shareobj];
        //分享的数组
        [items addObject:item];
    }
    
#pragma mark - 分享功能
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    //去除特定的分享功能
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
    [self presentViewController: activityVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
