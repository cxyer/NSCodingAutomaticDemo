//
//  ViewController.m
//  NSCodingAutomaticDemo
//
//  Created by 蔡晓阳 on 2018/10/21.
//  Copyright © 2018 cxy. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@", dict);
    Person *person = [Person modelWithDict:dict];
//    person.name = @"cxy";
//    person.age = @"10";
    NSLog(@"%@ %@",person.name,person.age);
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:person];
    Person *newPerson = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@ %@",newPerson.name,newPerson.age);
}


@end
