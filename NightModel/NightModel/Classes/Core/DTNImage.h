
#import <UIKit/UIKit.h>
#import "DTNightType.h"

#pragma mark - 扩展方法
typedef UIImage *(^DTImagePicker)(DTThemeVersion *themeVersion);

/**
 *  一组图片，使用对应DTNColorManager.txt
 *
 *  @param normalImage 当前主题为DTThemeVersionNormal时的图片
 *  @param ...         其他图片，对应DTNColorManager
 *
 *  @return DTImagePicker
 */
DTImagePicker DTImagePickerWithImages(UIImage *normalImage, ...);

// 默认图片名规则，夜间_night
DTImagePicker DTImagePickerWithKey(NSString *key);

/**
 *  一组图片名，使用对应DTNColorManager.txt.
 *
 *  @param normalName 当前主题为DTThemeVersionNormal时的图片名
 *  @param ...        其他图片名，对应DTNColorManager
 *
 *  @return DTImagePicker
 */
DTImagePicker DTImagePickerWithNames(NSString *normalName, ...);

#pragma mark - DTNImage

@interface DTNImage : NSObject

/**
 *  一组图片名，使用对应DTNColorManager.txt.
 *
 *  @param names 一组图片名
 *
 *  @return DTImagePicker
 */
+ (DTImagePicker)pickerWithNames:(NSArray<NSString *> *)names;

/**
 *  一组图片，使用对应DTNColorManager.txt.
 *
 *  @param images 一组图片
 *
 *  @return DTImagePicker
 */
+ (DTImagePicker)pickerWithImages:(NSArray<UIImage *> *)images;

/**
 *  通过图片名取DTImagePicker
 *
 *  @param name 图片名
 *
 *  @return DTImagePicker
 */
+ (DTImagePicker)imageNamed:(NSString *)name;

/**
 *  返回带DTThemeVersionNight和normal图片的image picker
 *
 *  @param normalImage 正常图片
 *  @param nightImage  DTThemeVersionNight图片
 *
 *  @return DTImagePicker
 */
+ (DTImagePicker)pickerWithNormalImage:(UIImage *)normalImage nightImage:(UIImage *)nightImage;

@end
