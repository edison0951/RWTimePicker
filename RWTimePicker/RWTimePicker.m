//
//  RWTimePicker.m
//  RWTimePickerDemo
//
//  Created by riven on 2017/6/29.
//  Copyright © 2017年 riven. All rights reserved.
//

#import "RWTimePicker.h"

@interface RWTimeCell : UITableViewCell
@end

@implementation RWTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.textLabel.font = [RWTimePicker appearance].normalFont;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [RWTimePicker appearance].normalColor;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    if (selected) {
        self.textLabel.textColor = [RWTimePicker appearance].selectedColor;
        self.textLabel.font = [RWTimePicker appearance].selectedFont;
    }else{
        self.textLabel.textColor = [RWTimePicker appearance].normalColor;
        self.textLabel.font = [RWTimePicker appearance].normalFont;
    }
}
@end


@interface RWTimePicker () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, assign) BOOL is12HourFormat;
@property(nonatomic, strong) UITableView *hourTableView;
@property(nonatomic, strong) UITableView *minuteTableView;
@property(nonatomic, strong) UITableView *amPmTableView;
@property(nonatomic, assign) NSInteger hour;
@property(nonatomic, assign) NSInteger minute;
@end

@implementation RWTimePicker

- (instancetype)initWithFrame:(CGRect)frame is12HourFormat:(BOOL)is12HourFormat{
    self = [super initWithFrame:frame];
    if (self) {
        self.is12HourFormat = is12HourFormat;
        self.backgroundColor = [UIColor clearColor];
        [self setupSubview];
    }
    return self;
}

- (UITableView *)hourTableView{
    if (_hourTableView == nil) {
        _hourTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _hourTableView.contentInset = UIEdgeInsetsMake(self.frame.size.height / 2, 0, self.frame.size.height / 2, 0);
        _hourTableView.showsVerticalScrollIndicator = NO;
        _hourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _hourTableView.delegate = self;
        _hourTableView.dataSource = self;
        _hourTableView.backgroundColor = [UIColor clearColor];
        [_hourTableView registerClass:[RWTimeCell class] forCellReuseIdentifier:NSStringFromClass([RWTimeCell class])];
    }
    return _hourTableView;
}

- (UITableView *)minuteTableView{
    if (_minuteTableView == nil) {
        _minuteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _minuteTableView.contentInset = UIEdgeInsetsMake(self.frame.size.height / 2, 0, self.frame.size.height / 2, 0);
        _minuteTableView.showsVerticalScrollIndicator = NO;
        _minuteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _minuteTableView.delegate = self;
        _minuteTableView.dataSource = self;
        [_minuteTableView registerClass:[RWTimeCell class] forCellReuseIdentifier:NSStringFromClass([RWTimeCell class])];
        _minuteTableView.backgroundColor = [UIColor clearColor];
    }
    return _minuteTableView;
}

- (UITableView *)amPmTableView{
    if (_amPmTableView == nil) {
        _amPmTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _amPmTableView.contentInset = UIEdgeInsetsMake(self.frame.size.height/2, 0, self.frame.size.height/2, 0);
        _amPmTableView.showsVerticalScrollIndicator = NO;
        _amPmTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _amPmTableView.delegate = self;
        _amPmTableView.dataSource = self;
        [_amPmTableView registerClass:[RWTimeCell class] forCellReuseIdentifier:NSStringFromClass([RWTimeCell class])];
        _amPmTableView.backgroundColor = [UIColor clearColor];
    }
    return _amPmTableView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.is12HourFormat) {
        CGFloat width = self.frame.size.width/3;
        self.hourTableView.frame = CGRectMake(0, 0, width, self.frame.size.height);
        self.minuteTableView.frame = CGRectMake(width, 0, width, self.frame.size.height);
        self.amPmTableView.frame = CGRectMake(2*width, 0, width, self.frame.size.height);
    }else{
        CGFloat width = self.frame.size.width/2;
        self.hourTableView.frame = CGRectMake(0, 0, width, self.frame.size.height);
        self.minuteTableView.frame = CGRectMake(width, 0, width, self.frame.size.height);
    }
}

- (void)updateWithHour:(NSInteger)hour minute:(NSInteger)minute{
    self.hour = hour;
    self.minute = minute;
}

- (void)setupSubview{
    [self addSubview:self.hourTableView];
    [self addSubview:self.minuteTableView];
    
    if (self.is12HourFormat) {
        [self addSubview:self.amPmTableView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _hourTableView) {
        // need triple of origin storage to scroll infinitely
        return (self.is12HourFormat ? 12 : 24) * 3;
    } else if (tableView == _amPmTableView) {
        return 2;
    }
    // need triple of origin storage to scroll infinitely
    return 60 * 3;
}

//每行对应的数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RWTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RWTimeCell class])];
    if (tableView == _amPmTableView) {
        cell.textLabel.text = indexPath.row == 0 ? @"AM": @"PM";
        return cell;
    }else{
        if (tableView == _minuteTableView){
            cell.textLabel.text = [NSString stringWithFormat:@"%02li", indexPath.row % 60];
        } else {
            if (self.is12HourFormat) {
                cell.textLabel.text = [NSString stringWithFormat:@"%02li", (indexPath.row % 12) + 1];
            } else {
                cell.textLabel.text = [NSString stringWithFormat:@"%02li", indexPath.row % 24];
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    if (tableView == _hourTableView) {
        if (self.is12HourFormat){
            NSInteger currentHour = (indexPath.row - 12)%12 + 1;
            NSIndexPath *amPmIndexPath = _amPmTableView.indexPathForSelectedRow;
            if (amPmIndexPath.row == 1 && currentHour < 12) {
                self.hour += 12;
            } else if (amPmIndexPath.row == 0 && currentHour == 12) {
                self.hour = 0;
            }
        } else {
            self.hour = (indexPath.row - 24)%24;
        }
        
    } else if (tableView == _minuteTableView ){
        self.minute = (indexPath.row - 60)%60;
    } else if (tableView == _amPmTableView) {
        if (indexPath.row == 0 && self.hour >= 12) {
            self.hour = self.hour - 12;
        } else if (indexPath.row == 1 && self.hour < 12) {
            self.hour = self.hour + 12;
        }
    }
}

// for infinite scrolling, use modulo operation.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _amPmTableView) {
        return;
    }
    CGFloat totalHeight = scrollView.contentSize.height;
    CGFloat visibleHeight = totalHeight / 3.0;
    if (scrollView.contentOffset.y < visibleHeight || scrollView.contentOffset.y > visibleHeight + visibleHeight) {
        CGFloat positionValueLoss = scrollView.contentOffset.y - (CGFloat)(int)scrollView.contentOffset.y;
        CGFloat heightValueLoss = visibleHeight - (CGFloat)(int)visibleHeight;
        CGFloat modifiedPotisionY = (CGFloat)((int)scrollView.contentOffset.y % (int)visibleHeight + (int)visibleHeight) - positionValueLoss - heightValueLoss;
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, modifiedPotisionY)];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self alignScrollView:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate){
        [self alignScrollView:scrollView];
    }
}

- (void)alignScrollView:(UIScrollView *)scrollView
{
    UITableView *tableView = (UITableView *)scrollView;
    CGPoint relativeOffset = CGPointMake(0, tableView.contentOffset.y + tableView.contentInset.top );
    NSInteger row = round(relativeOffset.y / self.rowHeight);
    if (tableView == _amPmTableView && row > 1){
        row = 1;
    }
    [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    // add 24 to hour and 60 to minute, because datasource now has buffer at top and bottom.
    if (tableView == _hourTableView) {
        if (self.is12HourFormat) {
            NSInteger hour = (row - 12)%12 + 1;
            NSIndexPath *amPmIndexPath = _amPmTableView.indexPathForSelectedRow;
            if (amPmIndexPath.row == 1 && hour < 12) {
                hour += 12;
            } else if (amPmIndexPath.row == 0 && hour == 12) {
                hour = 0;
            }
            self.hour = hour;
        } else {
            self.hour = (row - 24)%24;
        }
    } else if (tableView == _minuteTableView) {
        self.minute = (row - 60)%60;
    } else if (tableView == _amPmTableView) {
        NSInteger currentHour = self.hour;
        if (row == 0 && currentHour >= 12) {
            self.hour = currentHour - 12;
        } else if (row == 1 && currentHour < 12) {
            self.hour = currentHour + 12;
        }
    }
}
@end
