//
//  NSObject+PYKeyValues.h
//  PYRuntime
//
//  Created by PodiMac on 17/3/16.
//  Copyright © 2017年 于浦洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PYKeyValues)

//字典转模型
+(id)py_objectWithKeyValues:(NSDictionary *)dic;

//模型转字典
-(NSDictionary *)py_keyValuesWithObject;
@end
