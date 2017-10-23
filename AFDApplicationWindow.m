//
//  ARWindow.m
//
//
//  Created by Julian Triveri on 10/22/17.
//

#import "AFDApplicationWindow.h"
#import "UIView+draggable.h"

@implementation AFDApplicationWindow
-(AFDApplicationWindow*)init{
	self = super.init;
	
	[self setBackgroundColor:UIColor.whiteColor];
	[self enableDragging];
	[self setTransform:CGAffineTransformMakeScale(1, 1)];
	
	UIButton *closeButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	[closeButton addTarget:self action:@selector(closeWindow:) forControlEvents:UIControlEventTouchUpInside];
	[closeButton setTitle:@"X" forState:UIControlStateNormal];
	[closeButton setFrame:CGRectMake(0,0,44,44)];
	[self.layer setCornerRadius:10];
	[self.layer setShadowOffset:CGSizeMake(0, 5)];
	[self.layer setShadowRadius:20];
	[self.layer setShadowOpacity:0.3];
	[self addSubview:closeButton];
	
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.superview bringSubviewToFront:self];
}

- (void)closeWindow:(id)sender{
	[self removeFromSuperview];
}
@end
