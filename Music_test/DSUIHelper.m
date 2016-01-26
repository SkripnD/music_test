#import "DSUIHelper.h"
#import "MBProgressHUD.h"

@implementation DSUIHelper

+ (void) showProgressHUD
{
    [MBProgressHUD showHUDAddedTo:([UIApplication sharedApplication].delegate).window animated:YES];
}

+ (void) hideProgressHUD
{
    [MBProgressHUD hideHUDForView:([UIApplication sharedApplication].delegate).window animated:YES];
}

@end
