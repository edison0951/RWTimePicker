//
//  RWTimePicker.h
//  RWTimePickerDemo
//
//  Created by riven on 2017/6/29.
//  Copyright © 2017年 riven. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

typedef void(^CompleteHandler)(NSInteger hour, NSInteger minute);

@interface RWTimePicker : UIView
@property(nonatomic, strong) UIColor *selectedColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *normalColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIFont *normalFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIFont *selectedFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, assign) CGFloat rowHeight;
@property(nonatomic, strong) CompleteHandler completeHandler;

- (instancetype)initWithFrame:(CGRect)frame is12HourFormat:(BOOL)is12HourFormat;
@end
