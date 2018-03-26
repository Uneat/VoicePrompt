//
//  MessageTextView.h
//  palmLawyer
//
//  Created by Orient on 2018/1/23.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageTextView;
@protocol MessageTextViewDelegate <NSObject>

//监测文本高度的变化
- (void)textViewChangeFrame:(MessageTextView *)textView changeHeight:(CGFloat)height;

@optional
- (void)textViewValueString:(NSString *)textValue textView:(MessageTextView *)textView;

- (void)deleteBackward:(MessageTextView *)textView;

@end


@interface MessageTextView : UITextView<UITextViewDelegate>

//IBInspectable  可在xib上设置
@property (nonatomic, copy) IBInspectable NSString * placeholder;
@property (nonatomic, strong) IBInspectable UIColor * placeholderColor;

@property (nonatomic, weak) id<MessageTextViewDelegate> messageDelegate;


@end
