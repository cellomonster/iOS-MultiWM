//
//  ARWindow.m
//
//
//  Created by Julian Triveri on 10/22/17.
//

#import "AFDApplicationWindow.h"
#import "UIView+draggable.h"
#import "CDTContextHostProvider.h"
#import <rocketbootstrap/rocketbootstrap.h>
#include <notify.h>

@interface AFDApplicationWindow()
@property (assign) UIView* contextView;
@property (assign) CPDistributedMessagingCenter* messagingCenter;
@end

@implementation AFDApplicationWindow
-(AFDApplicationWindow*)initWithApplication:(NSString*)applicationBundleId{
	self = super.init;
	
	self.applicationBundleId = applicationBundleId;
	
	self.messagingCenter = [CPDistributedMessagingCenter centerNamed:[NSString stringWithFormat:@"%@ %@", @"trevir.arcticfox.xpm ", self.applicationBundleId]];
	rocketbootstrap_distributedmessagingcenter_apply(self.messagingCenter);
	[self.messagingCenter runServerOnCurrentThread];
	[self.messagingCenter registerForMessageName:@"trevir.arcticfox.xpm resizeApplicationWindow" target:self selector:@selector(returnNewApplicationWindowSize:withUserInfo:)];
	
	[self setBackgroundColor:UIColor.whiteColor];
	[self enableDragging];
	[self setTransform:CGAffineTransformMakeScale(1, 1)];
	[self.layer setCornerRadius:10];
	[self.layer setShadowOffset:CGSizeMake(0, 5)];
	[self.layer setShadowRadius:20];
	[self.layer setShadowOpacity:0.3];
	
	CDTContextHostProvider *contextProvider = CDTContextHostProvider.new;
	self.contextView = [contextProvider hostViewForApplicationWithBundleID:applicationBundleId];
	[self.contextView setTransform:CGAffineTransformMakeScale(1, 1)];
	[self.contextView setFrame:CGRectMake(0,44,600,400)];
	[self.contextView setClipsToBounds:true];
	
	[self addSubview:self.contextView];
	
	UIButton *closeButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	[closeButton setTitle:@"X" forState:UIControlStateNormal];
	[closeButton setFrame:CGRectMake(0,0,44,44)];
	[self addSubview:closeButton];
	
	[closeButton addTarget:self action:@selector(closeWindow:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *resizeButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	[resizeButton setTitle:@"R" forState:UIControlStateNormal];
	[resizeButton setFrame:CGRectMake(44,0,44,44)];
	[self addSubview:resizeButton];
	
	UIPanGestureRecognizer *resizeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(isResizingWindow:)];
	[resizeButton addGestureRecognizer:resizeGesture];
	
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.superview bringSubviewToFront:self];
}

- (void)closeWindow:(id)sender{
	[self.messagingCenter stopServer];
	[self removeFromSuperview];
}

-(void)setWindowFrame:(CGRect)frame{
	[self setFrame:frame];
	[self.contextView setFrame:CGRectMake(0, 44, frame.size.width, frame.size.height - 44)];
	
	const char *messageName = [[NSString stringWithFormat:@"%@ %@", @"trevir.arcticfox.xpn resizeApplicationWindow ", self.applicationBundleId] UTF8String];
	
	notify_post(messageName);
}

- (NSDictionary *)returnNewApplicationWindowSize:(NSString *)name withUserInfo:(NSDictionary *)userinfo {
	return @{@"width":@(self.frame.size.width),@"height":@(self.frame.size.height - 44)};
}

-(void)isResizingWindow:(UIPanGestureRecognizer *)gesture{
	CGPoint translate = [gesture translationInView:self];
	if (gesture.state == UIGestureRecognizerStateEnded) {
		[self setWindowFrame:self.frame];
	}else{
		[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.contextView.frame.size.width + translate.x, self.contextView.frame.size.height + 44 + translate.y)];
	}
}
@end
