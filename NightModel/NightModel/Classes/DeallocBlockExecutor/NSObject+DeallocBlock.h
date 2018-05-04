
#import <Foundation/Foundation.h>

@interface NSObject (DeallocBlock)

- (id)addDeallocBlock:(void (^)())deallocBlock;

@end
