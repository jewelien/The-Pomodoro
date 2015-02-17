//
//  POTimer.m
//  The Pomodoro
//
//  Created by Julien Guanzon on 2/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POTimer.h"
#import "TimerViewController.h"



@interface POTimer ()



- (void)endTimer;
- (void)decreaseSecond;
- (void)isActive;

@end

@implementation POTimer

+ (POTimer *)sharedInstance {
    static POTimer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [POTimer new];
    });
    return sharedInstance;
}

- (void)startTimer {
    self.isOn = YES;
    [self isActive];
}

- (void)cancelTimer {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(decreaseSecond) object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:disableButton object:nil];
    TimerViewController *timerViewController = [TimerViewController new];
    [timerViewController updateTimerLabel];
}

- (void)endTimer {
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"roundCompleteNotification" object:nil];
}

-(void)decreaseSecond {
    if (self.seconds > 0) {
        self.seconds--;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"secondTickNotification" object:nil];
    } else if (self.minutes > 0) {
        self.seconds = 59;
        self.minutes--;
    } else if (self.seconds == 0 && self.minutes == 0) {
        [self endTimer];
    }
}

- (void)isActive {
    if (self.isOn) {
        [self decreaseSecond];
        [self performSelector:@selector(isActive) withObject:nil afterDelay:1];

    }
}

@end
