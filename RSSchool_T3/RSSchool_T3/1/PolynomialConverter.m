#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    
    NSMutableString *polinomial = [[NSMutableString alloc] init];
    if (numbers.count == 0) {
        return nil;
    }
    
    for (int i = 0; i < numbers.count; i++) {
        
        int currentValue = [numbers[i] intValue];
        
        if (currentValue == 0) {
            continue;
        };
        
        if (currentValue > 0 && i != 0){
            [polinomial appendString:@" + "];
        } else if (currentValue < 0) {
            [polinomial appendString:@" - "];
        }
        
        if (currentValue != 1 && currentValue != -1) {
            if (currentValue < 0) {
                currentValue = currentValue * -1;
            }
            [polinomial appendString:[NSString stringWithFormat:@"%d", currentValue]];
        }
        if (i < numbers.count-1) {
            [polinomial appendString:@"x"];
        }
        if (i < numbers.count-2) {
            [polinomial appendString:@"^"];
            [polinomial appendString: [[NSNumber numberWithUnsignedLong:(numbers.count - i - 1)] stringValue]];
        };
        
    }
    
    NSLog(@"resul - %@", polinomial);
    
    return polinomial;
}
@end

