
#import <UIKit/UIKit.h>

/**
 * string 的别名，使用‘- isEqualToString`去比对每个`DTThemeVersion`，而不是单纯的‘==’
 */
typedef NSString DTThemeVersion;

typedef UIColor *(^DTColorPicker)(DTThemeVersion *themeVersion);


