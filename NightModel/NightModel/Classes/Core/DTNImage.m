
#import "DTNImage.h"
#import "DTNightVersionManager.h"
#import "DTNColorManager.h"

@implementation DTNImage

DTImagePicker DTImagePickerWithNames(NSString *normalName, ...) {
    NSArray<DTThemeVersion *> *themes = [DTNColorManager sharedColorTable].themes;
    NSMutableArray<NSString *> *names = [[NSMutableArray alloc] initWithCapacity:themes.count];
    [names addObject:normalName];
    NSUInteger num_args = themes.count - 1;
    va_list names_list;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wvarargs"
    va_start(names_list, num_args);
#pragma clang diagnostic pop
    for (NSUInteger i = 0; i < num_args; i++) {
        NSString *name = va_arg(names_list, NSString *);
        [names addObject:name];
    }
    va_end(names_list);
    
    return [DTNImage pickerWithNames:names];
}

DTImagePicker DTImagePickerWithKey(NSString *key){
    NSString *key_night = [NSString stringWithFormat:@"%@_night",key];
    if (![UIImage imageNamed:key_night]) {
        return DTImagePickerWithNames(key,key);
    }
    return DTImagePickerWithNames(key,key_night);
}

DTImagePicker DTImagePickerWithImages(UIImage *normalImage, ...) {
    NSArray<DTThemeVersion *> *themes = [DTNColorManager sharedColorTable].themes;
    NSMutableArray<UIImage *> *images = [[NSMutableArray alloc] initWithCapacity:themes.count];
    [images addObject:normalImage];
    NSUInteger num_args = themes.count - 1;
    va_list images_list;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wvarargs"
    va_start(images_list, num_args);
#pragma clang diagnostic pop
    for (NSUInteger i = 0; i < num_args; i++) {
        UIImage *image = va_arg(images_list, UIImage *);
        [images addObject:image];
    }
    va_end(images_list);
    
    return [DTNImage pickerWithImages:images];
}

+ (DTImagePicker)pickerWithNormalImage:(UIImage *)normalImage nightImage:(UIImage *)nightImage {
    NSParameterAssert(normalImage);
    NSParameterAssert(nightImage);
    return ^(DTThemeVersion *themeVersion) {
        return [themeVersion isEqualToString:DTThemeVersionNight] ? nightImage : normalImage;
    };
}

+ (DTImagePicker)pickerWithImage:(UIImage *)image {
    return ^(DTThemeVersion *themeVersion) {
        return image;
    };
}

+ (DTImagePicker)imageNamed:(NSString *)name {
    return [self pickerWithImage:[UIImage imageNamed:name]];
}

+ (DTImagePicker)pickerWithNames:(NSArray<NSString *> *)names {
    DTNColorManager *colorTable = [DTNColorManager sharedColorTable];
    NSParameterAssert(names.count == colorTable.themes.count);
    return ^(DTThemeVersion *themeVersion) {
        NSUInteger index = [colorTable.themes indexOfObject:themeVersion];
        if (index >= colorTable.themes.count) {
            return [UIImage imageNamed:names[[colorTable.themes indexOfObject:DTThemeVersionNormal]]];
        }
        return [UIImage imageNamed:names[index]];
    };
}

+ (DTImagePicker)pickerWithImages:(NSArray<UIImage *> *)images {
    DTNColorManager *colorTable = [DTNColorManager sharedColorTable];
    NSParameterAssert(images.count == colorTable.themes.count);
    return ^(DTThemeVersion *themeVersion) {
        NSUInteger index = [colorTable.themes indexOfObject:themeVersion];
        if (index >= colorTable.themes.count) {
            return images[[colorTable.themes indexOfObject:DTThemeVersionNormal]];
        }
        return images[index];
    };
}


@end
