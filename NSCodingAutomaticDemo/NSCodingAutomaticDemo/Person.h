//
//  Person.h
//  NSCodingAutomaticDemo
//
//  Created by 蔡晓阳 on 2018/10/21.
//  Copyright © 2018 cxy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

@end

