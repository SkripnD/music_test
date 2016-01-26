#import "DSBaseController.h"
#import "DSGenreTypeManager.h"

@interface DSResultsController : DSBaseController

@property (nonatomic, strong) NSString * selectedUserName;
@property (nonatomic) DSGenreType selectedGenreType;

@end
