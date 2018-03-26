//
//  ViewController.m
//  VoicePromptDemo
//
//  Created by Orient on 2018/1/23.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import "ViewController.h"
#import "NMCVoicePrompts.h"
#import "MessageTextView.h"
@interface ViewController ()<MessageTextViewDelegate>

@property (nonatomic, strong)MessageTextView * textView;
@property (nonatomic, strong)NSLayoutConstraint * textViewHeight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.textView.messageDelegate = self;
    self.textView = [[MessageTextView alloc]initWithFrame:CGRectMake(20, 20, [[UIScreen mainScreen] bounds].size.width-40, 100)];
    [self.textView setFont:[UIFont systemFontOfSize:15.0f]];
    [self.view addSubview:self.textView];
    UIButton * button = [[UIButton alloc]init];
    CGRect frame = button.frame;
    frame.size = CGSizeMake(100, 44);
    button.frame = frame;
    button.center = self.view.center;
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"播放" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)buttonClick{
    [[NMCVoicePrompts sharedInstance] speakWithWords:self.textView.text];
}
- (void)textViewChangeFrame:(MessageTextView *)textView changeHeight:(CGFloat)height
{
    
    
    _textViewHeight.constant = height;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        [self.view setNeedsDisplay];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
