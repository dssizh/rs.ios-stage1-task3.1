#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    
    int choice = 1;
    
    while ([[self getCombination:array[1] with:[NSNumber numberWithInt:choice]] intValue] != [array[0] intValue] && [array[1] intValue] >= choice) {
        choice++;
    }
    
    return ([array[1] intValue] < choice) ? nil : [NSNumber numberWithInt:choice];
}

-(NSNumber*) getCombination:(NSNumber *) elements with:(NSNumber *) choice {
    
    int intElements = [elements intValue];
    int intChoice = [choice intValue];
    
    long combination = [self factorial:intElements] / ([self factorial:(intElements - intChoice)] * [self factorial:intChoice]);
    
    return [NSNumber numberWithLong:combination];
}

-(long) factorial: (int) n {
    long result = 1;
    if (n == 0 || n == 1) {
        return 1;
    }
    for (int i = 1; i <= n; i++){
        result = result * i;
    }
    
    return result;
}

@end
