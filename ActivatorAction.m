//
//  ActivatorAction.m
//
//
//  Created by Julian Triveri on 8/11/17.
//

#include <notify.h>
#import <libactivator/libactivator.h>
#import <rocketbootstrap/rocketbootstrap.h>
#import "ActivatorAction.h"
#import "CDTContextHostProvider.h"
#import "AFDApplicationWindow.h"

@implementation ActivatorAction
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event forListenerName:(NSString *)listenerName{
	
	notify_post("trevir.arcticfox.xpn resizeApplicationWindow");
	
	SBApplication *frontApp = UIApplication.sharedApplication._accessibilityFrontMostApplication;
	
	UIView *window = [[AFDApplicationWindow alloc] init];
	[window setFrame:CGRectMake(100,100,600,444)];
	
	UIView *contextView;
	CDTContextHostProvider *contextProvider = CDTContextHostProvider.new;
	contextView = [contextProvider hostViewForApplicationWithBundleID:frontApp.displayIdentifier];
	[contextView setTransform:CGAffineTransformMakeScale(1, 1)];
	[contextView setFrame:CGRectMake(0,44,600,400)];
	[contextView setClipsToBounds:true];
	
	[window addSubview:contextView];
	[UIApplication.sharedApplication.keyWindow addSubview:window];
}

@end
