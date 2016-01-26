#import "Singleton.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UIColorFromHEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// Base colors
#define DSRedColor UIColorFromHEXRGB(0xFF3B30)

// UI colors
#define DSHeaderColor DSRedColor

@interface DSUI : Singleton

- (NSString *)defaultFontName;

- (UIFont *)defaultFont;
- (UIFont *)defaultFontOfSize:(float)size;

- (UIFont *)defaultMediumFont;
- (UIFont *)defaultMediumFontOfSize:(float)size;

@end
