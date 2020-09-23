//
//  ViewController.m
//  CoreDataDemo
//
//  Created by admin on 2018/3/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "Student+CoreDataClass.h"
@interface ViewController (){
    NSManagedObjectContext  *context;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSManagedObjectModel * model  = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator * psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    NSString * docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL * url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"Student.sqlite"]];
    
    NSError * error = nil;
    NSPersistentStore * store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) {
        [NSException raise:@"添加数据库错误" format:@"%@",[error localizedDescription]];
    }
    //初始化上下文
    context = [[NSManagedObjectContext alloc]init];
    context.persistentStoreCoordinator = psc;
    
    NSLog(@"%@",NSHomeDirectory());
    
    
}

/**
 增

 @param sender <#sender description#>
 */
- (IBAction)add:(id)sender {
    
    NSManagedObject * obj = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
    [obj setValue:@"小明" forKey:@"name"];
    [obj setValue:@"01" forKey:@"uid"];
    [obj setValue:@"www.baidu.com" forKey:@"url"];
    NSError * error = nil;
    BOOL success = [context save:&error];//每次改变实体后，都要保存上下文
    
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
        
    }else
    {
        NSLog(@"插入成功");
    }

}

/**
 删

 @param sender <#sender description#>
 */
- (IBAction)delete:(id)sender {
    //创建请求
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    //获取实体
    request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    //创建谓词
    NSPredicate * perdicate  = [NSPredicate predicateWithFormat:@"uid = %@",@"01"];
    request.predicate = perdicate;
    
    
    NSError * error = nil;
    NSArray * objects = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@",
         [error localizedDescription]];
    }
    for (NSManagedObject * obj in objects) {
        [context deleteObject:obj];
    }
    BOOL success = [context save:&error];//每次改变实体后，都要保存上下文
    
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
        
    }else
    {
        NSLog(@"删除成功");
    }
    
}


/**
 改

 @param sender <#sender description#>
 */
- (IBAction)change:(id)sender {
    //查询
    //创建请求
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    //查询条件
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name = %@",@"小明"];
    request.predicate = predicate;
    NSError * error = nil;
    NSArray * objects = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@",[error localizedDescription]];
    }
    //遍历数据
    for (NSManagedObject * obj in objects) {
        [obj setValue:@"小红" forKey:@"name"];
    }
    BOOL success = [context save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@",
         [error localizedDescription]];
    }else{
        NSLog(@"修改成功");
    }
    
}

/**
 查

 @param sender <#sender description#>
 */
- (IBAction)select:(id)sender {
    
    //查询
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    NSPredicate * perdicate = [NSPredicate predicateWithFormat:@"name = %@",@"小明"];
    request.predicate = perdicate;
    
    NSError * error = nil;
    NSArray * objects = [context executeFetchRequest:request error:&error];
    
    if (error) {
        [NSException raise:@"查询错误" format:@"%@",[error localizedDescription]];
    }
    for (NSManagedObject * obj in objects) {
        NSLog(@"name = %@",[obj valueForKey:@"name"]);
    }
    
    BOOL success = [context save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@",[  error localizedDescription ]];
    }else{
        NSLog(@"查询成功");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
