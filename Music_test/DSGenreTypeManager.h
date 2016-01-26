#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DSGenreType) {
    DSGenreTypeBanjo,
    DSGenreTypeBass,
    DSGenreTypeElectric,
    DSGenreTypeGuitar
};

@interface DSGenreTypeManager : NSObject

+ (UIImage *) genreImageForType:(DSGenreType)genreType;
+ (UIImage *) genreBackgroundImageForType:(DSGenreType)genreType;
+ (NSString *) genreValueForType:(DSGenreType)genreType;
+ (DSGenreType) genreTypeForValue:(NSString *)value;
+ (NSString *) genreColoredTitleForType:(DSGenreType)genreType;

@end
