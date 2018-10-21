//
//  Person.m
//  NSCodingAutomaticDemo
//
//  Created by 蔡晓阳 on 2018/10/21.
//  Copyright © 2018 cxy. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:_name forKey:@"name"];
//    [aCoder encodeObject:_age forKey:@"age"];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super init]) {
//        self.name = [aDecoder decodeObjectForKey:@"name"];
//        self.age = [aDecoder decodeObjectForKey:@"age"];
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    return self;
}

@end
