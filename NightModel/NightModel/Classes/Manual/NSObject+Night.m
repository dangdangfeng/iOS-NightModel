
#import "NSObject+Night.h"
#import "NSObject+DeallocBlock.h"
#import <objc/runtime.h>

static void *DTViewDeallocHelperKey;

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DTColorPicker> *pickers;

@end

@implementation NSObject (Night)

- (NSMutableDictionary<NSString *, DTColorPicker> *)pickers {
    NSMutableDictionary<NSString *, DTColorPicker> *pickers = objc_getAssociatedObject(self, @selector(pickers));
    if (!pickers) {
        @autoreleasepool {
            // 在 dealloc 中移除 Observer
            if (objc_getAssociatedObject(self, &DTViewDeallocHelperKey) == nil) {
                // NOTE: __weak在dealloc时会被重置为nil，使用__unsafe_unretained
                __unsafe_unretained __typeof(self) weakSelf = self;
                id deallocHelper = [self addDeallocBlock:^{
                    [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
                }];
                objc_setAssociatedObject(self, &DTViewDeallocHelperKey, deallocHelper, OBJC_ASSOCIATION_ASSIGN);
            }
        }
        
        pickers = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, @selector(pickers), pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kDTNightVersionThemeChangingNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(night_updateColor) name:kDTNightVersionThemeChangingNotification object:nil];
    }
    return pickers;
}

- (DTNightVersionManager *)dt_manager {
    return [DTNightVersionManager sharedManager];
}

- (void)night_updateColor {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DTColorPicker  _Nonnull picker, BOOL * _Nonnull stop) {
        SEL sel = NSSelectorFromString(selector);
        id result = picker(self.dt_manager.themeVersion);
        [UIView animateWithDuration:DTNightVersionAnimationDuration
                         animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [self performSelector:sel withObject:result];
#pragma clang diagnostic pop
                         }];
    }];
}

@end
