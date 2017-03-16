//
//  UIButton+PYClickBlock.m
//  PYRuntime
//
//  Created by PodiMac on 17/3/16.
//  Copyright © 2017年 于浦洋. All rights reserved.
//

#import "UIButton+PYClickBlock.h"
#import <objc/runtime.h>

//Category中的属性，只会生成setter和getter方法，不会生成成员变量

static const void *associatedKey = "associatedKey";
@implementation UIButton (PYClickBlock)

-(void)setPy_click:(PYClickBlock)py_click
{
    objc_setAssociatedObject(self, associatedKey, py_click, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(py_buttonClick) forControlEvents:UIControlEventTouchUpInside];
    if (py_click)
    {
        [self addTarget:self action:@selector(py_buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(PYClickBlock)py_click
{
    return objc_getAssociatedObject(self, associatedKey);
}
-(void)py_buttonClick
{
    if (self.py_click)
    {
        self.py_click();
    }
}
@end
