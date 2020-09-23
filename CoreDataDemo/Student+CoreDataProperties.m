//
//  Student+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by admin on 2018/3/16.
//  Copyright © 2018年 admin. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic url;
@dynamic name;
@dynamic uid;

@end
