//
//  DSResultsController.m
//  Music_test
//
//  Created by Denis Skripnichenko on 26/01/16.
//  Copyright © 2016 Denis Skripnichenko. All rights reserved.
//

#import "DSResultsController.h"

// Logic
#import "UIAlertView+DSHelper.h"
#import "NSDictionary+JSON.h"
#import "AFNetworking.h"
#import "DSGenreTypeManager.h"

// UI
#import "DSUIHelper.h"
#import "DSGenreResultsView.h"

@interface DSResultsController ()
@property (nonatomic, strong) IBOutlet UILabel * label_header;
@property (nonatomic, strong) IBOutlet UILabel * label_percents;
@property (nonatomic, strong) IBOutlet DSGenreResultsView * view_genreResults;
@property (nonatomic, strong) NSDictionary * dict_percents;
@end

@implementation DSResultsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeUI];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadInfoFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) loadInfoFromServer
{
    NSString * requestString = @"https://demo7130406.mockable.io/poll-results";
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:requestString]];
    [request setHTTPMethod:@"GET"];
    AFHTTPRequestOperation *operation =[[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.securityPolicy.allowInvalidCertificates = YES;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        [DSUIHelper hideProgressHUD];
        [self parseResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [DSUIHelper hideProgressHUD];
        [self showError:@"Server error"];
    }];
    
    [DSUIHelper showProgressHUD];
    [operation start];
}

- (void) parseResponse:(NSDictionary *)response
{
    self.dict_percents = @{
                                [DSGenreTypeManager genreValueForType:DSGenreTypeBanjo]: [response valueForKey:@"banjo"] != nil ? [response valueForKey:@"banjo"] : @(0),
                                [DSGenreTypeManager genreValueForType:DSGenreTypeBass]: [response valueForKey:@"bass"] != nil ? [response valueForKey:@"bass"] : @(0),
                                [DSGenreTypeManager genreValueForType:DSGenreTypeElectric]: [response valueForKey:@"electric"] != nil ? [response valueForKey:@"electric"] : @(0),
                                [DSGenreTypeManager genreValueForType:DSGenreTypeGuitar]: [response valueForKey:@"guitar"] != nil ? [response valueForKey:@"guitar"] : @(0),
                                };
    [self updateResultsUI];
}



#pragma mark - UI -

- (void) initializeUI
{
    // Header label
    self.label_header.text = @"Results";
    self.label_header.textColor = DSHeaderColor;
    self.label_header.font = [[DSUI sharedInstance] defaultMediumFontOfSize:35.0f];
    self.label_header.alpha = defaultContentAlpha;
    
    self.label_percents.hidden = YES;
    self.view_genreResults.hidden = YES;
}

- (void) updateResultsUI
{
    self.label_percents.hidden = NO;
    self.view_genreResults.hidden = NO;
    
    NSNumber * similarPercents = [self.dict_percents valueForKey:[DSGenreTypeManager genreValueForType:self.selectedGenreType]] != nil ? [self.dict_percents valueForKey:[DSGenreTypeManager genreValueForType:self.selectedGenreType]] : @(0);
    
    self.label_percents.text = [NSString stringWithFormat:@"%@,\n %ld%% also like the %@", self.selectedUserName, [similarPercents integerValue], [DSGenreTypeManager genreColoredTitleForType:self.selectedGenreType]];
    
    self.view_genreResults.dict_percents = self.dict_percents;
}

- (void) showError:(NSString *)errorText
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please, type your name before selection genre" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

@end
