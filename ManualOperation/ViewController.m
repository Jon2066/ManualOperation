//
//  ViewController.m
//  animationRunLoop
//
//  Created by Jonathan on 16/3/29.
//  Copyright © 2016年 Jonathan. All rights reserved.
//

#import "ViewController.h"

#import "ManualOperation.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;


@property (strong, nonatomic) NSOperationQueue *animationQueue;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hCenterCt;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.animationQueue = [[NSOperationQueue alloc] init];
    self.animationQueue.maxConcurrentOperationCount = 1;
    
    
    //0.1秒添加一个operation
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(addAnimation) userInfo:nil repeats:YES];
    
}

- (void)addAnimation
{
    
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


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
