//
//  Tweak.xm
//
//
//  Created by Julian Triveri on 8/11/17.
//

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
	
	CPDistributedMessagingCenter *messagingCenter = [CPDistributedMessagingCenter centerNamed:@"trevir.arcticfox.xpm"];
	rocketbootstrap_distributedmessagingcenter_apply(messagingCenter);
	
	NSDictionary *reply = [messagingCenter sendMessageAndReceiveReplyName:@"trevir.arcticfox.xpm resizeApplicationWindow" userInfo:nil];
	
	if([NSBundle.mainBundle.bundleIdentifier isEqualToString: [reply objectForKey:@"currentApplication"]]){
			[UIApplication.sharedApplication.keyWindow setFrame:CGRectMake(0,0,[[reply valueForKey:@"width"] doubleValue],[[reply valueForKey:@"height"] doubleValue])];
			[UIApplication.sharedApplication.statusBarWindow setFrame:CGRectMake(0,-100,0,0)];
	}
}

%hook UIApplication
-(id)init{
	id toReturn = %orig;
	
	if(IS_SPRINGBOARD){
		[LAActivator.sharedInstance registerListener:[ActivatorAction new] forName:@"New Window"];
		
		CPDistributedMessagingCenter *messagingCenter = [CPDistributedMessagingCenter centerNamed:@"trevir.arcticfox.xpm"];
		rocketbootstrap_distributedmessagingcenter_apply(messagingCenter);
		[messagingCenter runServerOnCurrentThread];
		[messagingCenter registerForMessageName:@"trevir.arcticfox.xpm resizeApplicationWindow" target:self selector:@selector(returnNewApplicationWindowSize:withUserInfo:)];
		
	}else{
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
																		NULL,
																		resizeApplicationWindow,
																		CFSTR("trevir.arcticfox.xpn resizeApplicationWindow"),
																		NULL,
																		CFNotificationSuspensionBehaviorDeliverImmediately);
	}
	
	return toReturn;
}

%new

- (NSDictionary *)returnNewApplicationWindowSize:(NSString *)name withUserInfo:(NSDictionary *)userinfo {
	SBApplication *frontApp = UIApplication.sharedApplication._accessibilityFrontMostApplication;
	
	return @{@"width":@600,@"height":@400,@"currentApplication":frontApp.displayIdentifier};
}

%end
