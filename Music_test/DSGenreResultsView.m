//
//  DSGenreResultsView.m
//  Music_test
//
//  Created by Denis Skripnichenko on 26/01/16.
//  Copyright © 2016 Denis Skripnichenko. All rights reserved.
//

#import "DSGenreResultsView.h"

// Logic
#import "DSGenreTypeManager.h"

@implementation DSGenreResultsView

- (void) setDict_percents:(NSDictionary *)dict_percents
{
    _dict_percents = dict_percents;
    // Clear old content
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat horizontalItemPadding = 8.0f;
    CGFloat verticalItemPadding   = 16.0f;
    CGFloat itemWidth = self.frame.size.width-horizontalItemPadding*2;
    CGFloat itemHeight = (self.frame.size.height-verticalItemPadding*5)/4;
    itemHeight = MIN(44, itemHeight);
    
    for (int i = 0; i < [_dict_percents allKeys].count; i++) {
        NSLog(@"%@", [_dict_percents allKeys][i]);
        DSGenreType genreType = [DSGenreTypeManager genreTypeForValue:[_dict_percents allKeys][i]];
        UIView * genreView = [self percentItemForType:genreType andSize:(CGSize){itemWidth, itemHeight}];
        genreView.frame = CGRectOffset(genreView.frame, horizontalItemPadding, i*itemHeight + (i+1)*verticalItemPadding);
        [self addSubview:genreView];
    }
}

- (UIView *) percentItemForType:(DSGenreType)genreType andSize:(CGSize)size
{
    NSNumber * percents = [self.dict_percents valueForKey:[DSGenreTypeManager genreValueForType:genreType]] != nil ? [self.dict_percents valueForKey:[DSGenreTypeManager genreValueForType:genreType]] : @(0);
    
    CGFloat percentLabelWidth = size.width*0.15;
    CGFloat contentWidth = size.width - percentLabelWidth;
    
    UIView * genreView = [[UIView alloc] initWithFrame:(CGRect) {
        .origin = {0,0},
        .size   = {size.width, size.height}
    }];
    
    UILabel * percentLabel = [[UILabel alloc] initWithFrame:(CGRect){
        .origin = {0,0},
        .size   = {percentLabelWidth, size.height}
    }];
    percentLabel.textColor = [UIColor whiteColor];
    percentLabel.font = [[DSUI sharedInstance] defaultMediumFontOfSize:14.0f];
    percentLabel.text = [NSString stringWithFormat:@"%ld%%", [percents integerValue]];
    percentLabel.textAlignment = NSTextAlignmentCenter;
    [genreView addSubview:percentLabel];
    
    UIImage * bgImage   = [DSGenreTypeManager genreBackgroundImageForType:genreType];
    CGSize percentsSize = (CGSize){contentWidth*([percents integerValue]/100.0f), size.height};
    
    UIView * backgroundView = [[UIView alloc] initWithFrame:(CGRect){
        .origin = {percentLabelWidth-8,0},
        .size   = percentsSize
    }];
    backgroundView.backgroundColor = [[UIColor
                                           colorWithPatternImage:bgImage] colorWithAlphaComponent:0.8];
    [backgroundView setOpaque:YES];
    backgroundView.clipsToBounds   = YES;
    [genreView addSubview:backgroundView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:(CGRect){
        .origin = {percentLabelWidth,0},
        .size   = {contentWidth, size.height}
    }];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [[DSUI sharedInstance] defaultMediumFontOfSize:14.0f];
    titleLabel.text = [[DSGenreTypeManager genreValueForType:genreType] capitalizedString];
    [genreView addSubview:titleLabel];
    
    return genreView;
}

@end
