#import "DSUI.h"

NSString *const DefaultFontName = @"HelveticaNeue";

@implementation DSUI


#pragma Regular

- (NSString *)defaultFontName
{
    return [NSString stringWithFormat:@"%@", DefaultFontName];
}

- (UIFont *)defaultFont
{
    return [self defaultFontOfSize:17];
}

- (UIFont *)defaultFontOfSize:(float)size
{
    return [UIFont fontWithName:[self defaultFontName] size:size];
}


#pragma Medium

- (UIFont *)defaultMediumFont
{
    return [self defaultMediumFontOfSize:17];
}

- (UIFont *)defaultMediumFontOfSize:(float)size
{
    return [UIFont fontWithName:[self defaultMediumFontName] size:size];
}

- (NSString *)defaultMediumFontName
{
    return [NSString stringWithFormat:@"%@-Medium", DefaultFontName];
}

@end
