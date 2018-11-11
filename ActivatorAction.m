//
//  ActivatorAction.m
//
//
//  Created by Julian Triveri on 8/11/17.
//
#import <libactivator/libactivator.h>
#import "ActivatorAction.h"
#import "CDTContextHostProvider.h"
#import "AFDApplicationWindow.h"

@implementation ActivatorAction
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event forListenerName:(NSString *)listenerName{
	
	SBApplication *frontApp = UIApplication.sharedApplication._accessibilityFrontMostApplication;
	
	AFDApplicationWindow *window = [[AFDApplicationWindow alloc] initWithApplication:frontApp.bundleIdentifier];
	[window setWindowFrame:CGRectMake(100,100,600,444)];
	
	[UIApplication.sharedApplication.keyWindow addSubview:window];
}

@end
