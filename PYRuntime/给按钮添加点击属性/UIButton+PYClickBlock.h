//
//  UIButton+PYClickBlock.h
//  PYRuntime
//
//  Created by PodiMac on 17/3/16.
//  Copyright © 2017年 于浦洋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PYClickBlock) (void);

@interface UIButton (PYClickBlock)
@property(nonatomic,copy)PYClickBlock py_click;
@end
