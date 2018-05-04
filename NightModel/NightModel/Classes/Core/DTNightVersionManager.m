
#import "DTNightVersionManager.h"

#pragma mark - const
NSString * const DTThemeVersionNormal = @"NORMAL";
NSString * const DTThemeVersionNight = @"NIGHT";

NSString * const kDTNightVersionThemeChangingNotification = @"kDTNightVersionThemeChangingNotification";
NSString * const DTNightVersionThemeChangingNotification = @"DTNightVersionThemeChangingNotification";

CGFloat const DTNightVersionAnimationDuration = 0.3;

CGFloat const DTNightVersionAnimationDelay = 1.3;

NSString * const DTNightVersionCurrentThemeVersionKey = @"com.dtnightversion.manager.themeversion";

#pragma mark - DTNightVersionManager

@implementation DTNightVersionManager

+ (DTNightVersionManager *)sharedManager {
    static dispatch_once_t once;
    static DTNightVersionManager *instance;
    dispatch_once(&once, ^{
        instance = [self new];
        instance.changeStatusBar = YES;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        DTThemeVersion *themeVersion = [userDefaults valueForKey:DTNightVersionCurrentThemeVersionKey];
        themeVersion = themeVersion ?: DTThemeVersionNormal;
        instance.themeVersion = themeVersion;
        instance.supportsKeyboard = YES;
    });
    return instance;
}

+ (DTNightVersionManager *)sharedNightVersionManager {
    return [self sharedManager];
}

- (void)nightFalling {
    self.themeVersion = DTThemeVersionNight;
}

- (void)dawnComing {
    self.themeVersion = DTThemeVersionNormal;
}

- (void)setThemeVersion:(DTThemeVersion *)themeVersion {
    if ([_themeVersion isEqualToString:themeVersion]) {
        // 主题未改变，直接返回
        return;
    }
    _themeVersion = themeVersion;
    
    // 保存当前主题
    [[NSUserDefaults standardUserDefaults] setValue:themeVersion forKey:DTNightVersionCurrentThemeVersionKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDTNightVersionThemeChangingNotification
                                                        object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:DTNightVersionThemeChangingNotification
                                                        object:nil];
    
    if (self.shouldChangeStatusBar) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        if ([themeVersion isEqualToString:DTThemeVersionNight]) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        } else {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
#pragma clang diagnostic pop
    }
}

- (BOOL)isNightVersion{
    if ([self.themeVersion isEqualToString:DTThemeVersionNight]) {
        return YES;
    }
    return NO;
}
@end
