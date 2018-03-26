//
//  NMCVoicePrompts.m
//  VoicePromptDemo
//
//  Created by Orient on 2018/1/23.
//  Copyright © 2018年 Orient. All rights reserved.
//

#import "NMCVoicePrompts.h"
#import <AVFoundation/AVFoundation.h>
@interface NMCVoicePrompts ()

@property AVSpeechSynthesizer *synthesizer; // 语音合成器，说话的人

@end
@implementation NMCVoicePrompts
+ (NMCVoicePrompts *)sharedInstance {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * value = [defaults objectForKey:@"value"];
//    if([value isEqualToString:@"1"]){
        static NMCVoicePrompts *sharedInstance = nil;
        sharedInstance = [[NMCVoicePrompts alloc] init];
        sharedInstance.synthesizer = [[AVSpeechSynthesizer alloc] init];
        return sharedInstance;
//    }
    return nil;
    
}

- (void)speakWithWords:(NSString *)words
{
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:words];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    [self.synthesizer speakUtterance:utterance];
}


@end
