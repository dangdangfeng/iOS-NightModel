
#import "DTNAlpha.h"
#import "DTNightVersionManager.h"
#import "DTNColorManager.h"

DTAlphaPicker DTAlphaPickerWithAlphas(CGFloat normal, ...) {
    
    NSArray<DTThemeVersion *> *themes = [DTNColorManager sharedColorTable].themes;
    NSMutableArray<NSNumber *> *alphas = [[NSMutableArray alloc] initWithCapacity:themes.count];
    [alphas addObject:@(normal)];
    NSUInteger num_args = themes.count - 1;
    va_list args;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wvarargs"
    va_start(args, num_args);
#pragma clang diagnostic pop
    for (NSUInteger i = 0; i < num_args; i++) {
        double alpha = va_arg(args, double);
        [alphas addObject:@(alpha)];
    }
    va_end(args);
    
    return ^(DTThemeVersion *themeVersion) {
        NSUInteger index = [themes indexOfObject:themeVersion];
        return (CGFloat)[alphas[index] floatValue];
    };
}

DTAlphaPicker DTAlphaPickerWithKey(CGFloat night){
    return DTAlphaPickerWithAlphas(0,night);
}


@implementation DTNAlpha

+ (DTAlphaPicker)alphaPickerWithAlpha:(CGFloat)alpha {
    return ^(DTThemeVersion *themeVersion) {
        return alpha;
    };
}

@end
