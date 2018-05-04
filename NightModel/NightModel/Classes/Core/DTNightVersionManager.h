
#import <UIKit/UIKit.h>
#import "DTNightType.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - const
/**
 *  DTThemeVersionNormal 仅仅是@"NORMAL"的宏定义, 可以用 `- isEqualToString:`
 *  去和其他比对.
 */
extern DTThemeVersion * const DTThemeVersionNormal;

/**
 *  DTThemeVersionNight 是 @"NIGHT"的宏定义.
 */
extern DTThemeVersion * const DTThemeVersionNight;

/**
 *  改变当前的主题时都会使用DTNightVersionManager发送通知(内部使用)
 */
extern NSString * const kDTNightVersionThemeChangingNotification;
/**
 *  改变当前的主题时都会使用DTNightVersionManager发送通知(外部使用)
 */
extern NSString * const DTNightVersionThemeChangingNotification;

/**
 *  改变主题时，渐进动画消耗的时间
 */
extern CGFloat const DTNightVersionAnimationDuration;

/**
 *  改变主题时，延迟渐进动画的时间
 */
extern CGFloat const DTNightVersionAnimationDelay;

#pragma mark - DTNightVersionManager

/**
 *  DTNightVersionManager 管理着所有的主题，使用 `- sharedInstance` 代替
 *  `- init` 初始化.
 */
@interface DTNightVersionManager : NSObject

/**
 *  如果 `changeStatusBar` 被设置为 `YES`, 在执行`+ nightFalling`和`+ dawnComing`时，status bar 会改变为相应的`UIStatusBarStyleLightContent`和`UIStatusBarStyleDefault`.
 * 如果使用`-[UIViewController preferredStatusBarStyle]`时，设置此值为`NO`，默认为`YES`.
 */
@property (nonatomic, assign, getter=shouldChangeStatusBar) BOOL changeStatusBar;

/**
 *  当前的主题版本, 默认是 DTThemeVersionNormal, 改变它会改变全局的主题设置, 会发送 `DTNightVersionThemeChangingNotification`通知, 如果您想自定义主题，可以监听此通知.
 *
 *  Ex:
 *
 *      ```objectivec
 *          DTNightVersionManager *manager = [DTNightVersionManager sharedManager];
 *          manager.themeVersion = @"RED"; // DTThemeVersionNormal or DTThemeVersionNight
 *      ```
 */
@property (nonatomic, strong) DTThemeVersion *themeVersion;

/**
 *  跟随themeVersion变化，DTThemeVersionNight返回YES，其他返回NO
 */
@property (nonatomic, assign) BOOL isNightVersion;

/**
 *   当改变为 DTThemeNight时支持 keyboard 类型改变. 如果是YES,如果当前的主题是DTThemeNight,UITextField的
 *  `keyboardType` 会改变为 `UIKeyboardAppearanceDark`. 默认是 YES.
 */
@property (nonatomic, assign) BOOL supportsKeyboard;

/**
 *  单例
 */
+ (DTNightVersionManager *)sharedManager;

/**
 *  当nightFalling调起时，会发送`DTNightVersionThemeChangingNotification`通知.
 *  监听通知可以自定义主题，此时主题设置为`DTNightVersionNight`.
 */
- (void)nightFalling;

/**
 *  发送`DTNightVersionThemeChangingNotification`通知，设置主题为`DTNightVersionNormal`
 */
- (void)dawnComing;

/**
 *  方法弃用, 使用 `- [DTNightVersion sharedManager]` 代替
 */
+ (DTNightVersionManager *)sharedNightVersionManager __deprecated_msg("use `- [DTNightVersion sharedManager]` instead");

@end

NS_ASSUME_NONNULL_END
