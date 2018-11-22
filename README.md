# 利用runtime对NSCoding进行自动归档解档
1. 记得自己初学时，对模型进行数据持久化可能会这样写
    ```objc
    - (void)encodeWithCoder:(NSCoder *)aCoder {
        [aCoder encodeObject:_name forKey:@"name"];
        [aCoder encodeObject:_age forKey:@"age"];
    }
    - (instancetype)initWithCoder:(NSCoder *)aDecoder {
        if (self=[super init]) {
            self.name = [aDecoder decodeObjectForKey:@"name"];
            self.age = [aDecoder decodeObjectForKey:@"age"];
        }
        return self;
    }
    ```
    如果有几百个属性，那会变得非常麻烦。所以，我们可以利用runtime对NSCoding进行自动归档解档
2. 核心代码
    ```objc
    - (void)encodeWithCoder:(NSCoder *)aCoder {
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
    ```
# 利用Runtime进行字典转模型
1. 思路：利用Runtime，遍历模型中的所有属性，根据属性名从字典中取出对应的值，然后给模型赋值
2. 核心代码：实现一个乞丐版字典转模型
```objc
//新建一个分类：NSObject+Model
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
```
3. 字典转模型框架当然没那么简单，还包括模型中嵌套模型、数组包含其他模型等等，可以参考YYModel的源码。我有打算学习YYModel的源码，挖坑中。。
