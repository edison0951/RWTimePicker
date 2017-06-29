//
//  ViewController.m
//  RWTimePickerDemo
//
//  Created by 王河云 on 2017/6/29.
//  Copyright © 2017年 riven. All rights reserved.
//

#import "ViewController.h"
#import "RWTimePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [RWTimePicker appearance].normalFont = [UIFont systemFontOfSize:20];
    [RWTimePicker appearance].selectedFont = [UIFont systemFontOfSize:45];
    [RWTimePicker appearance].normalColor = UIColorFromRGB(0xb0b8c4);
    [RWTimePicker appearance].selectedColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"background.png"];
    [self.view addSubview:imageView];
    RWTimePicker *timePicker = [[RWTimePicker alloc] initWithFrame:CGRectMake(43, 43, 290, 150) is12HourFormat:YES];
    timePicker.rowHeight = 50;
    [self.view addSubview:timePicker];
    timePicker.completeHandler = ^(NSInteger hour, NSInteger minute){
    
    };
}




@end
