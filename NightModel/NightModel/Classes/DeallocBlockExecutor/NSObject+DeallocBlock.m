
#import "NSObject+DeallocBlock.h"
#import "DTDeallocBlockExecutor.h"
#import <objc/runtime.h>

static void *kNSObject_DeallocBlocks;

@implementation NSObject (DeallocBlock)

- (id)addDeallocBlock:(void (^)())deallocBlock {
    if (deallocBlock == nil) {
        return nil;
    }
    
    NSMutableArray *deallocBlocks = objc_getAssociatedObject(self, &kNSObject_DeallocBlocks);
    if (deallocBlocks == nil) {
        deallocBlocks = [NSMutableArray array];
        objc_setAssociatedObject(self, &kNSObject_DeallocBlocks, deallocBlocks, OBJC_ASSOCIATION_RETAIN);
    }
    
    // 检查block是否存在
    for (DTDeallocBlockExecutor *executor in deallocBlocks) {
        if (executor.deallocBlock == deallocBlock) {
            return nil;
        }
    }
    
    DTDeallocBlockExecutor *executor = [DTDeallocBlockExecutor executorWithDeallocBlock:deallocBlock];
    [deallocBlocks addObject:executor];
    return executor;
}

@end
