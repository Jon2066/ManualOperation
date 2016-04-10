# ManualOperation
operation will not finish until call finish().use to waite asyn's completion for continue

 __weak typeof(self) weakSelf = self;
    
    ManualOperation *blockOperation = [[ManualOperation alloc] initWithExecutionBlock:^(void(^finish)(void)){
        
        __block typeof(finish) blockFinish = finish;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger time = [self.label.text integerValue] + 1;

            self.label.text = [NSString stringWithFormat:@"%ld", time];

            [UIView animateWithDuration:1.5f delay:0.1f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                

                NSInteger r = (random() - random()) % 50;
                
                weakSelf.hCenterCt.constant = weakSelf.hCenterCt.constant +  r?r:r+1;
                
                [weakSelf.view layoutSubviews];
                
            } completion:^(BOOL finished) {
                blockFinish(); //等待所有操作完成后再结束operation
            }];

        });
    
    }];
    
    [self.animationQueue addOperation:blockOperation];
