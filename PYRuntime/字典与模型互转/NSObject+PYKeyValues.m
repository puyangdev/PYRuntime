//
//  NSObject+PYKeyValues.m
//  PYRuntime
//
//  Created by PodiMac on 17/3/16.
//  Copyright © 2017年 于浦洋. All rights reserved.
//

#import "NSObject+PYKeyValues.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation NSObject (PYKeyValues)

//字典转模型
+(id)py_objectWithKeyValues:(NSDictionary *)dic
{
    id obj=[[self alloc] init];
    for (NSString *key in dic.allKeys)
    {
        id value=dic[key];
        //判断当前属性是不是Model
        objc_property_t property=class_getProperty(self, key.UTF8String);
        unsigned int outCount=0;
        objc_property_attribute_t *attributeList=property_copyAttributeList(property, &outCount);
//        objc_property_attribute_t attribute=attributeList[0];
//        NSString *typeString=[NSString stringWithUTF8String:attribute.value];
        //生成 setter方法，并用 objc_msgSend调用
        NSString *methodName=[NSString stringWithFormat:@"set%@%@:",[key substringToIndex:1].uppercaseString,[key substringFromIndex:1]];
        SEL setter=sel_registerName(methodName.UTF8String);
        if ([obj respondsToSelector:setter])
        {
            ((void(*)(id,SEL,id)) objc_msgSend)(obj,setter,value);
        }
        free(attributeList);
    }
    return obj;
}

//模型转字典
-(NSDictionary *)py_keyValuesWithObject
{
    unsigned int outCount=0;
    objc_property_t *propertyList=class_copyPropertyList([self class], &outCount);
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    for (int i=0; i<outCount; i++)
    {
        objc_property_t property=propertyList[i];
        const char *propertyName=property_getName(property);
        SEL getter = sel_registerName(propertyName);
        if ([self respondsToSelector:getter])
        {
            id value=((id(*)(id,SEL))objc_msgSend)(self,getter);
            if ([value isKindOfClass:[self class]] && value)
            {
                value=[value py_keyValuesWithObject];
            }
            if (value)
            {
                NSString *key=[NSString stringWithUTF8String:propertyName];
                [dic setObject:value forKey:key];
            }
        }
        
    }
    free(propertyList);
    return dic;
}
@end
