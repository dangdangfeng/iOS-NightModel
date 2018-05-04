
#import <Foundation/Foundation.h>
#import "DTNightVersionManager.h"
#import "DTNightType.h"

#define kSkinColor @"skin_color"

/**
 *  DTColorPicker block.日夜间颜色
 *
 *  @param key 配置文件中的的key
 *
 *  @return DTColorPicker
 */
#define DTColorPickerWithKey(key) [[DTNColorManager sharedColorTable] pickerWithKey:key]

/**
 *  DTColorPicker block.日夜间颜色(带日间颜色透明度)
 *
 *  @param key    配置文件中的的key
 *  @param alpha  日间颜色透明度
 *
 *  @return DTColorPicker
 */
#define DTColorPickerWithKeyDayalpha(key,alpha) [[DTNColorManager sharedColorTable] pickerWithKey:key dayAlpha:alpha]

/**
 *  DTNColorManager可以在iOS项目中通过设置`ColorPlist`实现颜色变换
 *
 *  也可以通过 `[DTNightVersionManager sharedManager].themeVersion` 去实现功能
 *  如: `RED` `NORMAL` and `NIGHT`. 触发通知以更正相应的颜色
 *
 */
@interface DTNColorManager : NSObject

/**
 *  调用 `- reloadColorTable` 会触发 `DTNColorManager` 去加载配置,
 *  默认配置文件为 `DTNightColorTable.plist 、DTNormalColorTable.plist`. 设置这个属性后不需要调用 `- reloadColorTable`.
 */
@property (nonatomic, strong) NSString *nightFile;
@property (nonatomic, strong) NSString *colorFile;

/**
 *  实现功能同上，不过以数组的形式实现
 */
@property (nonatomic, strong, readonly) NSArray<DTThemeVersion *> *themes;

/// 是否是皮肤模式，正常日间和夜间为NO，换肤为YES(项目中暂时不支持)
@property (nonatomic, assign) BOOL isSkin;

/**
 *
 *  返回一个单例，请使用这个方法以替代`- init`
 *
 *  @return DTNColorManager单例
 */
+ (instancetype)sharedColorTable;

/**
 *  通过该方法可以设置皮肤的颜色
 *
 *  @param color 皮肤的颜色
 */
- (void)setSkinColor:(NSString *)color;

/**
 *  重新加载 `plist` 到内存, 此方法会重新加载颜色配置.
 */
- (void)reloadColorTable;

/**
 *  返回一个带key的`DTColorPicker` , 但是推荐使用 `DTColorPickerWithKey(key)`.
 *
 *  self.view.dt_backgroundColorPicker = DTColorPickerWithKey(@"C8");
 *
 *  如果当前的themeVersion 是 NORMAL, view的 background color 会被设置为 #ff7070. 改变时会自动加载更新.
 *
 *  @param key 指向的key
 *
 *  @return DTColorPicker block
 */
- (DTColorPicker)pickerWithKey:(NSString *)key;

/**
 *  返回一个带key的`DTColorPicker` , 但是推荐使用 `DTColorPickerWithKeyDayalpha(key,alpha)`.
 *
 *  self.view.dt_backgroundColorPicker = DTColorPickerWithKeyDayalpha(@"C7",0.2);
 *
 *  如果当前的themeVersion 是 NORMAL, view的 background color 会被设置为 #ff7070,颜色透明度为0.2. 改变时会自动加载更新.
 *
 *  @param key   指向的key
 *  @param alpha 日间颜色透明度
 *
 *  @return DTColorPicker block
 */
- (DTColorPicker)pickerWithKey:(NSString *)key dayAlpha:(CGFloat)alpha;

/// 一般用于取图片名(或取单独的颜色)
- (NSArray *)arrayWithKey:(NSString *)key;

@end
