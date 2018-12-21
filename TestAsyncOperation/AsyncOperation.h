//
//  AsyncOperation.h
//  TestAsyncOperation
//
//  Created by nmi on 2018/12/20.
//  Copyright © 2018 nmi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AsyncOperation : NSOperation
- (instancetype)initWithUrlStr:(NSString*)urlstr;
@end

NS_ASSUME_NONNULL_END
