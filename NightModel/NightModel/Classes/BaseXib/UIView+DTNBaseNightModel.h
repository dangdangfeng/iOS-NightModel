
#import <UIKit/UIKit.h>

@interface UIView (DTNBaseNightModel)
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
@property (nonatomic, strong)IBInspectable UIColor *borderColor;

@property (nonatomic, copy)IBInspectable NSString *borderC4N;// 夜间边框色
@property (nonatomic, copy)IBInspectable NSString *bgColor4N;// 夜间背景色

@property (nonatomic, assign)IBInspectable BOOL hidden4N;// 显隐
@end
