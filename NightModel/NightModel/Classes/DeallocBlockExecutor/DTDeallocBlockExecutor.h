
#import <Foundation/Foundation.h>

@interface DTDeallocBlockExecutor : NSObject

@property (nonatomic, copy) void (^deallocBlock)();

+ (instancetype)executorWithDeallocBlock:(void (^)())deallocBlock;

@end
