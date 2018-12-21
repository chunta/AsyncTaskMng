//
//  ViewController.m
//  TestAsyncOperation
//
//  Created by nmi on 2018/12/20.
//  Copyright © 2018 nmi. All rights reserved.
//

#import "ViewController.h"
#import "AsyncOperation.h"
#import "TaskMng.h"
@interface ViewController ()
{
    NSOperationQueue *queue;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *URL = [NSURL URLWithString:@"https://google.com"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if (error==NULL)
                                          {
                                              
                                              NSLog(@"op1");
                                          }else
                                          {
                                              
                                          }
                                      }];
        
        [task resume];
        
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op2");
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op3");
    }];
    
    NSBlockOperation *waitOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op4");
    }];
    
    // uncomment to fix problem
    // [op2 addDependency:op1];
    // [op3 addDependency:op2];
    
    //[op2 addDependency: waitOp];
    
    [queue addOperations:@[op1, op2, op3] waitUntilFinished:NO];
    
    void (^blockName)(BOOL) = ^void(BOOL res)
    {
        NSLog(@"BlockName:%d", res);
    };
    TaskMng *mng = [[TaskMng alloc] initWithTasksUrl:@[@"https://www.google.com",@"https://facebook.com"] Complete:blockName];
    [mng execute];
}


@end
