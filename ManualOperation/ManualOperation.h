//
//  manualFinishBlockOperation.h
//  animationRunLoop
//
//  Created by Jonathan on 16/3/29.
//  Copyright © 2016年 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManualOperation : NSOperation

/**
 *  创建operation
 *
 *  @param block 要执行的代码 执行结束需调用finish()来结束operation
 *  operation will not finish until call block's finish()
 *  @return manualFinishBlockOperation
 */
- (instancetype)initWithExecutionBlock:(void(^)(void(^finish)(void)))block;

@end
