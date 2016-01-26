//
//  DSGenrePickerView.m
//  Music_test
//
//  Created by Denis Skripnichenko on 26/01/16.
//  Copyright © 2016 Denis Skripnichenko. All rights reserved.
//

#import "DSGenrePickerView.h"

@interface DSGenrePickerView()
@end

@implementation DSGenrePickerView

- (void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self initContent];
}

- (void) initContent
{
    // Clear old content
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat horizontalItemPadding = 8.0f;
    CGFloat verticalItemPadding = 5.0f;
    CGFloat itemWidth = (self.frame.size.width-horizontalItemPadding*5)/4;
    CGFloat itemHeight = (self.frame.size.height-verticalItemPadding*2)/2;
    
    NSArray * genres = @[@(DSGenreTypeBanjo), @(DSGenreTypeBass), @(DSGenreTypeElectric), @(DSGenreTypeGuitar)];
    for (int i = 0; i < genres.count; i++) {
        DSGenreType genreType = [genres[i] integerValue];
        UIView * genreView = [self genreViewForType:genreType andSize:(CGSize){itemWidth, itemHeight}];
        genreView.frame = CGRectOffset(genreView.frame, i*itemWidth + (i+1)*horizontalItemPadding, verticalItemPadding);
        genreView.alpha = 0.8;
        
        UIView * reflectedGengeView = [self genreViewForType:genreType andSize:(CGSize){itemWidth, itemHeight}];
        reflectedGengeView.userInteractionEnabled = NO;
        reflectedGengeView.frame = CGRectOffset(reflectedGengeView.frame, i*itemWidth + (i+1)*horizontalItemPadding, -itemHeight*0.6);
        reflectedGengeView.alpha = 0.4;
        reflectedGengeView.contentMode = UIViewContentModeScaleAspectFit;
        reflectedGengeView.transform = CGAffineTransformMake(1, 0, 0, -1, 0, 290.0);
        
        [self addSubview:genreView];
        [self addSubview:reflectedGengeView];
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self initContent]; 
}



#pragma mark - Gesture -

- (void) genreViewTap:(UIGestureRecognizer*)gesture
{
    if (self.delegate) {
        [self.delegate genrePickerView:self didSelectGenre:gesture.view.tag];
    }
}



#pragma mark - Genre views -

- (UIView *) genreViewForType:(DSGenreType)genreType andSize:(CGSize)size
{
    UIImage * bgImage    = [DSGenreTypeManager genreBackgroundImageForType:genreType];
    UIImage * genreImage = [DSGenreTypeManager genreImageForType:genreType];
    
    // Use to combine images
    /*UIGraphicsBeginImageContext(size);
    [bgImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [genreImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();*/
    
    UIView * genreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    genreView.tag = genreType;
    genreView.userInteractionEnabled = YES;
    
    // Colored background
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:genreView.bounds];
    backgroundImageView.image = bgImage;
    backgroundImageView.clipsToBounds = YES;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [genreView addSubview:backgroundImageView];
    
    // Instrument image
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:genreView.bounds];
    imageView.image = genreImage;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [genreView addSubview:imageView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(genreViewTap:)];
    tapGesture.numberOfTapsRequired = 1;
    [genreView addGestureRecognizer:tapGesture];
    
    return genreView;
}

@end
