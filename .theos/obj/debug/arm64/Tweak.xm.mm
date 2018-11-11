#line 1 "Tweak.xm"







#include <notify.h>
#import <libactivator/libactivator.h>
#import <rocketbootstrap/rocketbootstrap.h>
#import "ActivatorAction.h"
#import "Interfaces.h"

#define IS_SPRINGBOARD [NSBundle.mainBundle.bundleIdentifier isEqual:@"com.apple.springboard"]

void resizeApplicationWindow(CFNotificationCenterRef center,
														 void *observer,
														 CFStringRef name,
														 const void *object,
														 CFDictionaryRef userInfo){
    
	NSString *applicationMessagingCenterName = [NSString stringWithFormat:@"%@ %@", @"trevir.arcticfox.xpm ", NSBundle.mainBundle.bundleIdentifier];
	CPDistributedMessagingCenter *applicationMessagingCenter = [CPDistributedMessagingCenter centerNamed:applicationMessagingCenterName];
	rocketbootstrap_distributedmessagingcenter_apply(applicationMessagingCenter);
	
	NSDictionary *reply = [applicationMessagingCenter sendMessageAndReceiveReplyName:@"trevir.arcticfox.xpm resizeApplicationWindow" userInfo:nil];
	[UIApplication.sharedApplication.keyWindow setFrame:CGRectMake(0,0,[[reply valueForKey:@"width"] doubleValue],[[reply valueForKey:@"height"] doubleValue])];
	[UIApplication.sharedApplication.statusBarWindow setFrame:CGRectMake(0,-100,0,0)];
    
    [UIApplication.sharedApplication setStatusBarOrientation:2 animation:1 duration:0];
    [UIApplication.sharedApplication setStatusBarOrientation:1 animation:1 duration:0];
}


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class UIApplication; 
static UIApplication* (*_logos_orig$_ungrouped$UIApplication$init)(_LOGOS_SELF_TYPE_INIT UIApplication*, SEL) _LOGOS_RETURN_RETAINED; static UIApplication* _logos_method$_ungrouped$UIApplication$init(_LOGOS_SELF_TYPE_INIT UIApplication*, SEL) _LOGOS_RETURN_RETAINED; 

#line 34 "Tweak.xm"

static UIApplication* _logos_method$_ungrouped$UIApplication$init(_LOGOS_SELF_TYPE_INIT UIApplication* __unused self, SEL __unused _cmd) _LOGOS_RETURN_RETAINED{
	id toReturn = _logos_orig$_ungrouped$UIApplication$init(self, _cmd);
	
	if(IS_SPRINGBOARD){
		[LAActivator.sharedInstance registerListener:[ActivatorAction new] forName:@"New Window"];
    
    }else{
		const char *messageName = [[NSString stringWithFormat:@"%@ %@", @"trevir.arcticfox.xpn resizeApplicationWindow ", NSBundle.mainBundle.bundleIdentifier] UTF8String];
		
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
																		NULL,
																		resizeApplicationWindow,
																		CFStringCreateWithCString(NULL, messageName, kCFStringEncodingMacRoman),
																		NULL,
																		CFNotificationSuspensionBehaviorDeliverImmediately);
	}
	
	return toReturn;
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UIApplication = objc_getClass("UIApplication"); MSHookMessageEx(_logos_class$_ungrouped$UIApplication, @selector(init), (IMP)&_logos_method$_ungrouped$UIApplication$init, (IMP*)&_logos_orig$_ungrouped$UIApplication$init);} }
#line 56 "Tweak.xm"
