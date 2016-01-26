//
//  UIAlertView+DSHelper.m
//  Music_test
//
//  Created by Denis Skripnichenko on 26/01/16.
//  Copyright © 2016 Denis Skripnichenko. All rights reserved.
//

#import "UIAlertView+DSHelper.h"

@implementation UIAlertView (DSHelper)

+ (void)showAlertWithErrorMessage:(NSString *)message {
    [self showAlertWithTitle:@"Error" message:message];
}

+ (void)showAlertWithMessage:(NSString *)message {
    [self showAlertWithTitle:nil message:message];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
