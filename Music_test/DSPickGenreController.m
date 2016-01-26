//
//  DSPickGenreController.m
//  Music_test
//
//  Created by Denis Skripnichenko on 26/01/16.
//  Copyright © 2016 Denis Skripnichenko. All rights reserved.
//

#import "DSPickGenreController.h"

// Controllers
#import "DSResultsController.h"

// Logic
#import "UIAlertView+DSHelper.h"
#import "NSDictionary+JSON.h"
#import "AFNetworking.h"
#import "DSGenreTypeManager.h"

// UI
#import "BorderedTextField.h"
#import "DSGenrePickerView.h"
#import "DSUIHelper.h"

// Segues identifiers
static NSString * kSegueShowResults = @"DSPickGenreControllerToDSResultsController";

@interface DSPickGenreController ()<DSGenrePickerViewDelegate>
@property (nonatomic, strong) IBOutlet UILabel * label_header;
@property (nonatomic, strong) IBOutlet BorderedTextField * textField_userName;
@property (nonatomic, strong) IBOutlet DSGenrePickerView * view_genres;

@property (nonatomic, strong, readonly) NSString * selectedUserName;
@property (nonatomic) DSGenreType selectedGenreType;
@property (nonatomic) BOOL genreSelectionEnabled;
@end

@implementation DSPickGenreController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) sendGenreToServer:(NSString *)genre withUserName:(NSString *)userName
{
    NSString * requestString = @"https://demo7130406.mockable.io/submit-poll";
    NSString *options = [@{@"name":userName, @"genre":genre} toJSON];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:requestString]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[options dataUsingEncoding:NSUTF8StringEncoding]];

    AFHTTPRequestOperation *operation =[[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.securityPolicy.allowInvalidCertificates = YES;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        self.genreSelectionEnabled = YES;
        [DSUIHelper hideProgressHUD];
        [self showResultsController];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.genreSelectionEnabled = YES;
        [DSUIHelper hideProgressHUD];
        [self showError:@"Server error"];
    }];
    
    self.genreSelectionEnabled = NO;
    [DSUIHelper showProgressHUD];
    [operation start];
}

- (void) showResultsController
{
    [self performSegueWithIdentifier:kSegueShowResults sender:nil];
}



#pragma mark - UI -

- (void) initializeUI
{
    // Header label
    self.label_header.text = @"Pick your genre";
    self.label_header.textColor = DSHeaderColor;
    self.label_header.font = [[DSUI sharedInstance] defaultMediumFontOfSize:35.0f];
    self.label_header.alpha = defaultContentAlpha;
    
    // User name textfield
    self.textField_userName.textColor = [UIColor whiteColor];
    self.textField_userName.textAlignment = NSTextAlignmentCenter;
    // iOS 6.0+
    if ([self.textField_userName respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithWhite:1 alpha:defaultContentAlpha];
        UIFont * font = [[DSUI sharedInstance] defaultFontOfSize:16.0f];
        self.textField_userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type your name here" attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: font}];
    } else {
        self.textField_userName.placeholder = @"Type your name here";
    }
    
    self.view_genres.delegate = self;
}

- (void) setGenreSelectionEnabled:(BOOL)genreSelectionEnabled
{
    _genreSelectionEnabled = genreSelectionEnabled;
    self.view_genres.userInteractionEnabled = _genreSelectionEnabled;
}

- (void) showError:(NSString *)errorText
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please, type your name before selection genre" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}



#pragma mark - Getters -

- (NSString *) selectedUserName
{
    return self.textField_userName.text;
}



#pragma mark - DSGenrePickerViewDelegate -

- (void) genrePickerView:(DSGenrePickerView *)pickerView didSelectGenre:(DSGenreType)genreType
{
    if (self.selectedUserName == nil || self.selectedUserName.length == 0) {
        [UIAlertView showAlertWithErrorMessage:@"Please, enter your name"];
        return;
    }
    
    _selectedGenreType = genreType;
    [self sendGenreToServer:[DSGenreTypeManager genreValueForType:genreType] withUserName:self.selectedUserName];
}



#pragma mark - Segues -

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSegueShowResults]) {
        DSResultsController * controller = segue.destinationViewController;
        controller.selectedUserName = self.selectedUserName;
        controller.selectedGenreType = self.selectedGenreType;
    }
}

@end
