//
//  ViewController.m
//  NSCodingAutomaticDemo
//
//  Created by 蔡晓阳 on 2018/10/21.
//  Copyright © 2018 cxy. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *person = [[Person alloc] init];
    person.name = @"cxy";
    person.age = @"10";
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:person];
    Person *newPerson = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@ %@",newPerson.name,newPerson.age);
}


@end
