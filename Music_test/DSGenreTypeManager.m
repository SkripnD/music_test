//
//  DSGenreTypeManager.m
//  Music_test
//
//  Created by Denis Skripnichenko on 26/01/16.
//  Copyright © 2016 Denis Skripnichenko. All rights reserved.
//

#import "DSGenreTypeManager.h"

@implementation DSGenreTypeManager

+ (UIImage *) genreImageForType:(DSGenreType)genreType
{
    switch (genreType) {
        case DSGenreTypeBanjo:
            return [UIImage imageNamed:@"banjo"];
        case DSGenreTypeBass:
            return [UIImage imageNamed:@"bass"];
        case DSGenreTypeElectric:
            return [UIImage imageNamed:@"electric-guitar"];
        case DSGenreTypeGuitar:
            return [UIImage imageNamed:@"guitar"];
        default:
            return nil;
    }
}

+ (UIImage *) genreBackgroundImageForType:(DSGenreType)genreType
{
    switch (genreType) {
        case DSGenreTypeBanjo:
            return [UIImage imageNamed:@"banjo_background"];
        case DSGenreTypeBass:
            return [UIImage imageNamed:@"bass_background"];
        case DSGenreTypeElectric:
            return [UIImage imageNamed:@"electric_background"];
        case DSGenreTypeGuitar:
            return [UIImage imageNamed:@"guitar_background"];
        default:
            return nil;
    }
}

+ (NSString *) genreValueForType:(DSGenreType)genreType
{
    switch (genreType) {
        case DSGenreTypeBanjo:
            return @"banjo";
        case DSGenreTypeBass:
            return @"bass";
        case DSGenreTypeElectric:
            return @"electric";
        case DSGenreTypeGuitar:
            return @"guitar";
        default:
            return nil;
    }
}

+ (NSString *) genreColoredTitleForType:(DSGenreType)genreType
{
    switch (genreType) {
        case DSGenreTypeBanjo:
            return @"green one";
        case DSGenreTypeBass:
            return @"red one";
        case DSGenreTypeElectric:
            return @"purple one";
        case DSGenreTypeGuitar:
            return @"blue one";
        default:
            return nil;
    }
}

+ (DSGenreType) genreTypeForValue:(NSString *)value
{
    if ([value isEqualToString:@"banjo"]) {
        return DSGenreTypeBanjo;
    } else if ([value isEqualToString:@"bass"]) {
        return DSGenreTypeBass;
    } else if ([value isEqualToString:@"electric"]) {
        return DSGenreTypeElectric;
    } else if ([value isEqualToString:@"guitar"]) {
        return DSGenreTypeGuitar;
    }
    return 0;
}

@end
