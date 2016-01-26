typedef enum
{
    BorderedTextFieldBorder_Left        = 1,
    BorderedTextFieldBorder_Right       = 2,
    BorderedTextFieldBorder_Bottom      = 4,
    BorderedTextFieldBorder_Top         = 8,
    BorderedTextFieldBorder_TopTriangle    = 16,
} BorderedTextFieldBorder;

@interface BorderedTextField : UITextField

@property (nonatomic) BorderedTextFieldBorder border;
@property (nonatomic) CGFloat            borderSize;
@property (strong, nonatomic) UIColor * borderColor;

@property (nonatomic) float verticalPadding;
@property (nonatomic) float horizontalPadding;

@end