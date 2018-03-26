//
//  NMCVoicePrompts.h
//  VoicePromptDemo
//
//  Created by Orient on 2018/1/23.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMCVoicePrompts : NSObject
+ (NMCVoicePrompts *)sharedInstance;

/**
 说话
 
 @param words 要说的话
 */
- (void)speakWithWords:(NSString *)words;
@end
