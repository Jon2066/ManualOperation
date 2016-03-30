//
//  manualFinishBlockOperation.m
//  animationRunLoop
//
//  Created by Jonathan on 16/3/29.
//  Copyright © 2016年 Jonathan. All rights reserved.
//

#import "ManualOperation.h"

@interface ManualOperation ()
@property (strong, nonatomic) void(^executionBlock)(void(^)(void));
@end

@implementation ManualOperation
@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithExecutionBlock:(void (^)(void (^)(void)))block
{
    self = [super init];
    if (self) {
        _executionBlock = block;
    }
    return self;
}

- (void)start
{
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    if (_executionBlock) {
        __weak typeof(self) weakSelf = self;
        _executionBlock(^{
            [weakSelf finish];
        });
    }
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)finish
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    _executing = NO;
    _finished = YES;
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
}
@end
