//
//  TaskMng.h
//  TestAsyncOperation
//
//  Created by nmi on 2018/12/21.
//  Copyright © 2018 nmi. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ITaskMng
- (void)subtaskFinished;
@end

NS_ASSUME_NONNULL_BEGIN
@interface SubTask : NSObject
- (instancetype)initWithURL:(NSString*)_url Del:(id<ITaskMng>)_delegate;
- (void)execute;
@property(nonatomic, weak) id<ITaskMng> taskdelegate;
@end

@interface TaskMng : NSObject<ITaskMng>
- (instancetype)initWithTasksUrl:(NSArray*)urlArray Complete:(void (^)(BOOL result))completionHandler;
- (void)execute;
@end

NS_ASSUME_NONNULL_END
