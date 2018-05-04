
#import "DTNColorManager.h"
#import "DTNColor.h"

@interface DTNColorManager ()

/// 键值组合
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, UIColor *> *> *colorTable;
/// 主题
@property (nonatomic, strong, readwrite) NSArray<DTThemeVersion *> *themes;
/// 颜色
@property (nonatomic, assign) NSString *color;

@end

@implementation DTNColorManager

/// 取色
UIColor *DTColorFromRGB(NSUInteger hex) {
    return [UIColor colorWithRed:((CGFloat)((hex >> 16) & 0xFF)/255.0) green:((CGFloat)((hex >> 8) & 0xFF)/255.0) blue:((CGFloat)(hex & 0xFF)/255.0) alpha:1.0];
}

/// 取色带透明度
UIColor *DTColorFromRGBA(NSUInteger hex) {
    return [UIColor colorWithRed:((CGFloat)((hex >> 24) & 0xFF)/255.0) green:((CGFloat)((hex >> 16) & 0xFF)/255.0) blue:((CGFloat)((hex >> 8) & 0xFF)/255.0) alpha:((CGFloat)(hex & 0xFF)/255.0)];
}

/// 单例
+ (instancetype)sharedColorTable {
    static DTNColorManager *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[DTNColorManager alloc] init];
        sharedInstance.nightFile = @"DTNightColorTable.plist";
        sharedInstance.color = [[NSUserDefaults standardUserDefaults] objectForKey:kSkinColor];
        if (sharedInstance.color == nil) { // 之前没有存储，取出为空
            sharedInstance.color = @"Normal";
            [[NSUserDefaults standardUserDefaults] setObject:@"Normal" forKey:kSkinColor];
//            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        sharedInstance.colorFile = [NSString stringWithFormat:@"DT%@ColorTable.plist",sharedInstance.color];
    });
    return sharedInstance;
}

/**
 *  通过该方法可以设置皮肤的颜色
 *
 *  @param color 皮肤的颜色
 */
- (void)setSkinColor:(NSString *)color{
    if ([_color isEqualToString:color]) return;
    
    _color = color;
    
    // 将用户设置的皮肤颜色进行保存
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:kSkinColor];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    if (!self.nightFile || [self.nightFile length] == 0) {
        self.nightFile = @"DTNightColorTable.plist";
    }
    self.colorFile = [NSString stringWithFormat:@"DT%@ColorTable.plist",color];
}

/// 重新加载颜色表
- (void)reloadColorTable {
    NSString *currentColor = [[NSUserDefaults standardUserDefaults] objectForKey:kSkinColor];
    if (currentColor && ![currentColor isEqualToString:self.color]) {
        self.colorFile = [NSString stringWithFormat:@"DT%@ColorTable.plist",currentColor];
    }
    
    // 从文件中加载
    NSString *strResourcesBundle = [[NSBundle bundleForClass:[self class]] pathForResource:@"NightModel" ofType:@"bundle"];
    
    NSString *colorFilepath = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:self.colorFile.stringByDeletingPathExtension ofType:self.colorFile.pathExtension];
    
    NSString *nightFilepath = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:self.nightFile.stringByDeletingPathExtension ofType:self.nightFile.pathExtension];
    NSDictionary<NSString *,NSString *> *colorDic = [[NSDictionary alloc] initWithContentsOfFile:colorFilepath];
    NSDictionary<NSString *,NSString *> *nightDic = [[NSDictionary alloc] initWithContentsOfFile:nightFilepath];
    if (!colorDic || !nightDic || [colorDic count] == 0 || [nightDic count] == 0 || [colorDic count] != [nightDic count]) {
        NSLog(@"Error reading file: %@", self.colorFile);
        return;
    }
    
    // 清理预置颜色表
    self.colorTable = nil;
    self.themes = nil;

    self.themes = @[DTThemeVersionNormal,DTThemeVersionNight];
    
    for (int i = 0; i < [colorDic count]; i++) {
        NSString *keys = [colorDic allKeys][i];
        NSArray *colors = @[[colorDic objectForKey:keys],[nightDic objectForKey:keys]];
        [self addEntryWithKey:keys colors:colors themes:self.themes];
    }
}

/// 组合
- (void)addEntryWithKey:(NSString *)key colors:(NSArray *)colors themes:(NSArray *)themes {
    NSParameterAssert(themes.count == colors.count);
    NSMutableArray *result = [@[] mutableCopy];
    for (NSString *number in colors) {
        [result addObject:[self colorFromString:number]?[self colorFromString:number]:number];
    }

    __block NSMutableDictionary *themeToColorDictionary = [@{} mutableCopy];
    
    [themes enumerateObjectsUsingBlock:^(NSString * _Nonnull theme, NSUInteger idx, BOOL * _Nonnull stop) {
        [themeToColorDictionary setValue:result[idx] forKey:theme];
    }];
    
    [self.colorTable setValue:themeToColorDictionary forKey:key];
}

/// 取值
- (DTColorPicker)pickerWithKey:(NSString *)key {
    NSParameterAssert(key);
    // 此处取值，后期加入皮肤
    NSDictionary *themeToColorDictionary = [self.colorTable valueForKey:key];
    DTColorPicker picker = ^(DTThemeVersion *themeVersion) {
        return [themeToColorDictionary valueForKey:themeVersion];
    };
    return picker;
}

- (DTColorPicker)pickerWithKey:(NSString *)key dayAlpha:(CGFloat)alpha{
    NSArray *colorAry = [self arrayWithKey:key];
    UIColor *normalColor = colorAry[0];
    UIColor *nightColor = colorAry[1];
    return [DTNColor pickerWithNormalColor:[normalColor colorWithAlphaComponent:alpha] nightColor:nightColor];
}

- (NSArray *)arrayWithKey:(NSString *)key{
    NSDictionary *dic = [self.colorTable valueForKey:key];
    NSArray *res = @[dic[DTThemeVersionNormal],dic[DTThemeVersionNight]];
    return res;
}


#pragma mark - Getter/Setter

- (NSMutableDictionary *)colorTable {
    if (!_colorTable) {
        _colorTable = [[NSMutableDictionary alloc] init];
    }
    return _colorTable;
}

- (void)setColorFile:(NSString *)colorFile{
    _colorFile = colorFile;
    [self reloadColorTable];
}

#pragma mark - Helper

- (UIColor*)colorFromString:(NSString*)hexStr {
    hexStr = [hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([hexStr hasPrefix:@"0x"]) {
        hexStr = [hexStr substringFromIndex:2];
    }else if([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    }else{
        return nil;
    }
    
    NSUInteger hex = [self intFromHexString:hexStr];
    if(hexStr.length > 6) {
        return DTColorFromRGBA(hex);
    }
    
    return DTColorFromRGB(hex);
}

- (NSUInteger)intFromHexString:(NSString *)hexStr {
    unsigned int hexInt = 0;
    
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

@end
