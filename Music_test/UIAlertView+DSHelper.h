//
//  UIAlertView+DSHelper.h
//  Music_test
//
//  Created by Denis Skripnichenko on 26/01/16.
//  Copyright © 2016 Denis Skripnichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (DSHelper)

+ (void)showAlertWithErrorMessage:(NSString *)message;
+ (void)showAlertWithMessage:(NSString *)message;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
