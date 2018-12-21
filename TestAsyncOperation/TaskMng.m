//
//  TaskMng.m
//  TestAsyncOperation
//
//  Created by nmi on 2018/12/21.
//  Copyright © 2018 nmi. All rights reserved.
//

#import "TaskMng.h"
@interface SubTask()
{
    NSString *url;
    id<ITaskMng> delegate;
}
@end

@implementation SubTask
- (instancetype)initWithURL:(NSString*)_url Del:(id<ITaskMng>)_delegate
{
    self = [super init];
    url = _url;
    delegate = _delegate;
    return self;
}

- (void)execute
{
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSLog(@"%@", self->url);
                                      [self->delegate subtaskFinished];
                                  }];
    
    [task resume];
}
@end

@interface TaskMng()
{
    NSMutableArray* tasklist;
}
@property (nonatomic, weak) void (^blockName)(BOOL);
@end

@implementation TaskMng
- (instancetype)initWithTasksUrl:(NSArray*)urlArray Complete:(void (^)(BOOL result))completionHandler
{
    self = [super init];
    _blockName = completionHandler;
    tasklist = [NSMutableArray new];
    for (int i = 0; i < urlArray.count; i++)
    {
        NSString* oneurl = [urlArray objectAtIndex:i];
        SubTask *subtask = [[SubTask alloc] initWithURL:oneurl Del:self];
        [tasklist addObject:subtask];
    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"TaskMng Release");
}

- (void)execute
{
    if (tasklist.count)
    {
        SubTask *subtask = [tasklist firstObject];
        [subtask execute];
    }
    else
    {
        _blockName(YES);
    }
}

- (void)subtaskFinished
{
    if (tasklist.count)
    {
        [tasklist removeObjectAtIndex:0];
    }
    [self execute];
}
@end
