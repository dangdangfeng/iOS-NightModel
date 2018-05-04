
#import <UIKit/UIKit.h>
#import "DTNightType.h"

// 0x444444... 日夜间
DTColorPicker DTColorPickerWithRGB(NSUInteger normal, ...);

// color1... 日夜间
DTColorPicker DTColorPickerWithColors(UIColor *normalColor, ...);

@interface DTNColor : NSObject

+ (DTColorPicker)pickerWithNormalColor:(UIColor *)normalColor nightColor:(UIColor *)nightColor;

// 设置一种颜色的，日夜间不变
+ (DTColorPicker)colorPickerWithUIColor:(UIColor *)color;

+ (DTColorPicker)colorPickerWithWhite:(CGFloat)white alpha:(CGFloat)alpha;

+ (DTColorPicker)colorPickerWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;

+ (DTColorPicker)colorPickerWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (DTColorPicker)colorPickerWithCGColor:(CGColorRef)cgColor;

+ (DTColorPicker)colorPickerWithPatternImage:(UIImage *)image;

#if __has_include(<CoreImage/CoreImage.h>)
+ (DTColorPicker)colorPickerWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0);
#endif

+ (DTColorPicker)blackColor;
+ (DTColorPicker)darkGrayColor;
+ (DTColorPicker)lightGrayColor;
+ (DTColorPicker)whiteColor;
+ (DTColorPicker)grayColor;
+ (DTColorPicker)redColor;
+ (DTColorPicker)greenColor;
+ (DTColorPicker)blueColor;
+ (DTColorPicker)cyanColor;
+ (DTColorPicker)yellowColor;
+ (DTColorPicker)magentaColor;
+ (DTColorPicker)orangeColor;
+ (DTColorPicker)purpleColor;
+ (DTColorPicker)brownColor;
+ (DTColorPicker)clearColor;

@end
