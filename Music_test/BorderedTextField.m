#import "BorderedTextField.h"

@implementation BorderedTextField

- (void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    //self.layer.borderWidth  = 0;
    //self.layer.cornerRadius = 0;
}

- (void) awakeFromNib
{
    self.layer.borderWidth  = 0;
    self.layer.cornerRadius = 0;
    
    self.contentMode        = UIViewContentModeRedraw;
    self.layer.borderWidth  = 0;
    self.layer.cornerRadius = 0;
    self.horizontalPadding  = 0;
    self.verticalPadding    = 0;
    self.border             = BorderedTextFieldBorder_Bottom;
    self.borderSize         = 1.0f;
    self.borderColor        = [UIColor whiteColor];
}

- (void) setBorder:(BorderedTextFieldBorder)border
{
    _border = border;
    [self setNeedsDisplay];
}

- (void) setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self setNeedsDisplay];
}

#pragma mark - Paddings

- (CGRect) editingRectForBounds:(CGRect)bounds
{
    return CGRectMake( bounds.origin.x + _horizontalPadding, bounds.origin.y + _verticalPadding, bounds.size.width - _horizontalPadding * 2, bounds.size.height - _verticalPadding * 2 );
}

#pragma mark - Borders

- (void)drawRect:(CGRect)rect
{
    UIColor * borderColor = self.borderColor;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect( context, self.bounds );
    
    //draw the bottom border
    if ( self.border & BorderedTextFieldBorder_Bottom )
    {
        CGContextSetFillColorWithColor( context, borderColor.CGColor );
        CGContextFillRect( context, CGRectMake( 0.f, self.frame.size.height - self.borderSize, self.frame.size.width, self.borderSize ) );
    }
    
    //draw the top border
    if ( self.border & BorderedTextFieldBorder_Top )
    {
        CGContextSetFillColorWithColor( context, borderColor.CGColor );
        CGContextFillRect( context, CGRectMake( 0.f, 0.f, self.frame.size.width, self.borderSize ) );
    }
    
    if ( self.border & BorderedTextFieldBorder_TopTriangle )
    {
        
        CGContextSetFillColorWithColor( context, borderColor.CGColor );
        CGFloat triangleWidth = self.frame.size.width / 3;
        CGContextFillRect( context, CGRectMake( 0.f, 0.f, triangleWidth, self.borderSize ) );
        CGContextFillRect( context, CGRectMake( triangleWidth * 2, 0.f, triangleWidth, self.borderSize ) );
        
        CGFloat triangleHeight = self.frame.size.height/5;
        self.verticalPadding += triangleHeight;
        
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor );
        CGContextSetLineWidth( context, self.borderSize );
        CGContextMoveToPoint( context, triangleWidth, self.borderSize / 2 );
        CGContextAddLineToPoint( context, triangleWidth + triangleWidth / 2, triangleHeight );
        CGContextStrokePath( context );
        
        CGContextMoveToPoint( context, triangleWidth+triangleWidth / 2, triangleHeight );
        CGContextAddLineToPoint( context, triangleWidth*2, self.borderSize / 2 );
        CGContextStrokePath( context);
        
    }
    
    //draw the left border
    if ( self.border & BorderedTextFieldBorder_Left )
    {
        CGContextSetFillColorWithColor(context, borderColor.CGColor);
        CGContextFillRect(context, CGRectMake(0.0f, 0.0f, self.borderSize, self.frame.size.height));
        
    }
    
    //draw the right border
    if ( self.border & BorderedTextFieldBorder_Right )
    {
        CGContextSetFillColorWithColor( context, borderColor.CGColor );
        CGContextFillRect( context, CGRectMake( self.frame.size.width - self.borderSize, 0.0f, self.borderSize, self.frame.size.height ) );
    }
}


@end
