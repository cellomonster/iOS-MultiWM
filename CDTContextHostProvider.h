#import "Interfaces.h"

@interface CDTContextHostProvider : NSObject {
	NSMutableDictionary* _hostedApplications;
}

@property (nonatomic, assign) BOOL currentAppHasFinishedLaunching;

+ (instancetype)sharedInstance;

- (UIView *)hostViewForApplication:(id)sbapplication;
- (UIView *)hostViewForApplicationWithBundleID:(NSString *)bundleID;
- (NSString *)bundleIDFromHostView:(UIView *)hostView;

- (void)launchSuspendedApplicationWithBundleID:(NSString *)bundleID;

- (FBScene *)FBSceneForApplication:(id)sbapplication;
- (FBWindowContextHostManager *)contextManagerForApplication:(id)sbapplication;
- (FBSMutableSceneSettings *)sceneSettingsForApplication:(id)sbapplication;

- (BOOL)isHostViewHosting:(UIView *)hostView;
- (void)forceRehostingOnBundleID:(NSString *)bundleID;

- (void)stopHostingForBundleID:(NSString *)bundleID;

@end
