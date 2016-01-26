#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

- (NSString *) toJSON
{
    NSError  * error;
    NSData   * jsonData;
    
    jsonData = [NSJSONSerialization dataWithJSONObject:self
                                               options:0
                                                 error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


@end
