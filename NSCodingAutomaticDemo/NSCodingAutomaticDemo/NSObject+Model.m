//
//  NSObject+Model.m
//  NSCodingAutomaticDemo
//
//  Created by 蔡晓阳 on 2018/11/22.
//  Copyright © 2018 cxy. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        //注意：成员变量以_开头
        NSString *key = [name substringFromIndex:1];
        id value = dict[key];
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

@end
