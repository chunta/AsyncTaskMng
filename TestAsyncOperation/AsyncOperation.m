//
//  AsyncOperation.m
//  TestAsyncOperation
//
//  Created by nmi on 2018/12/20.
//  Copyright © 2018 nmi. All rights reserved.
//

#import "AsyncOperation.h"
@interface AsyncOperation()
{
    
}
@property(nonatomic, assign)BOOL bfinished;
@property(nonatomic, assign)BOOL bcancelled;
@property(nonatomic, copy)NSString *urlstr;
@end

@implementation AsyncOperation

- (instancetype)initWithUrlStr:(NSString*)urlstr
{
    self = [super init];
    self.urlstr = urlstr;
    return self;
}

- (void)start
{
    __weak AsyncOperation* wself = self;
    NSURL *URL = [NSURL URLWithString:self.urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (error==NULL)
                                      {
                                          wself.bfinished = YES;
                                          NSLog(@"Finished %@", wself.urlstr);
                                      }else
                                      {
                                          wself.bcancelled = YES;
                                      }
                                  }];
    
    [task resume];
}

- (BOOL)isCancelled
{
    return _bcancelled;
}
- (BOOL)isFinished
{
    return _bfinished;
}

- (BOOL)isAsynchronous
{
    return YES;
}
@end
