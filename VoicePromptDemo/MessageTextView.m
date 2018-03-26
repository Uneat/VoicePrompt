//
//  MessageTextView.m
//  palmLawyer
//
//  Created by Orient on 2018/1/23.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import "MessageTextView.h"

@interface MessageTextView ()


@property (nonatomic, strong)  UILabel * placeHolderLabel;

@end



@implementation MessageTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.delegate = self;
        self.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:1.0] CGColor];
        self.layer.borderWidth = 2;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6;
        
        
        [self setPlaceholder:@""];
        
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.delegate = self;
        self.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:1.0] CGColor];
        self.layer.borderWidth = 0.5;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6;
        
        
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}


-(void)setPlaceholder:(NSString *)placeholder{
    
    if (_placeholder != placeholder) {
        
        _placeholder = placeholder;
        
        [self.placeHolderLabel removeFromSuperview];
        
        self.placeHolderLabel = nil;
        
        [self setNeedsDisplay];
        
        
    }
    
}


/** 实时监测文字的高度变化 */
- (void)textViewDidChange:(UITextView *)textView{

    CGFloat labelHeight = textView.contentSize.height - 16;
    
    //限制行数
    int count = (labelHeight) / textView.font.lineHeight;
    
    if (count < 5) {
    
        [self.messageDelegate textViewChangeFrame:self changeHeight:count * ((int)textView.font.lineHeight) + 16];

    }else{
        
        [self.messageDelegate textViewChangeFrame:self changeHeight:5 *((int)textView.font.lineHeight)];
    }
   
    
    if ([self.messageDelegate respondsToSelector:@selector(textViewValueString:textView:)]) {
        
        [self.messageDelegate textViewValueString:textView.text textView:self];
    }
    
}


- (void)textChanged:(NSNotification *)notification{
    
    if ([[self placeholder] length] == 0) {
        return;
    }
    
    if ([[self text] length] == 0) {
        [[self viewWithTag:999] setAlpha:1.0];
    }
    
    else{
        
        [[self viewWithTag:999] setAlpha:0];
    }
    
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    if ([[self placeholder] length] > 0) {
        if (_placeHolderLabel == nil) {
            _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16, 0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if ([[self text] length] == 0 && [[self placeholder] length] >0) {
        [[self viewWithTag:999] setAlpha:1.0];
    }
    
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}


//监测删除
- (void)deleteBackward{
    [super deleteBackward];
    
    if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(deleteBackward:)]) {
        
        [self.messageDelegate deleteBackward:self];
    }
    
}

@end

