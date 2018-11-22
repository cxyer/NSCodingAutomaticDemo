//
//  NSObject+Model.h
//  NSCodingAutomaticDemo
//
//  Created by 蔡晓阳 on 2018/11/22.
//  Copyright © 2018 cxy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Model)

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
