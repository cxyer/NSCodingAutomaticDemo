# 利用runtime对NSCoding进行自动归档解档
1. 记得自己初学时，对模型进行数据持久化可能会这样写
    ```
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
    ```
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
