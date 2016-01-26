#import <UIKit/UIKit.h>
#import "DSGenreTypeManager.h"

@class DSGenrePickerView;
@protocol DSGenrePickerViewDelegate <NSObject>
@required
- (void) genrePickerView:(DSGenrePickerView *)pickerView didSelectGenre:(DSGenreType)genreType;

@end

@interface DSGenrePickerView : UIView
@property (nonatomic, weak) id<DSGenrePickerViewDelegate>delegate;
@end
