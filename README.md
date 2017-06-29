# RWTimePicker
系统的DatePickerView以及UIPickerView没办法将改变选中状态和非选中状态的字体大小，

为了满足这个需求，所以实现了一个自定义的TimePicker

使用方法：

```
RWTimePicker *timePicker = [[RWTimePicker alloc] initWithFrame:CGRectMake(43, 43, 290, 150) is12HourFormat:YES];
timePicker.rowHeight = 50;
[self addSubview:timePicker]   
```



操作效果如下所示：

![operation](https://github.com/edison0951/RWTimePicker/blob/master/operation.gif)