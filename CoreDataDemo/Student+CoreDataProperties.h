//
//  Student+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by admin on 2018/3/16.
//  Copyright © 2018年 admin. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *uid;

@end

NS_ASSUME_NONNULL_END
