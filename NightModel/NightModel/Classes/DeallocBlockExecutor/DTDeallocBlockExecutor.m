
#import "DTDeallocBlockExecutor.h"

@implementation DTDeallocBlockExecutor

+ (instancetype)executorWithDeallocBlock:(void (^)())deallocBlock {
    DTDeallocBlockExecutor *o = [DTDeallocBlockExecutor new];
    o.deallocBlock = deallocBlock;
    return o;
}

- (void)dealloc {
    if (self.deallocBlock) {
        self.deallocBlock();
        self.deallocBlock = nil;
    }
}
@end
