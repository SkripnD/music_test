//
//  DSBaseController.m
//  Music_test
//
//  Created by Denis Skripnichenko on 26/01/16.
//  Copyright © 2016 Denis Skripnichenko. All rights reserved.
//

#import "DSBaseController.h"

@interface DSBaseController ()

@end

@implementation DSBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIGraphicsBeginImageContext((CGSize){100, 100});
    [[UIImage imageNamed:@"background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
