//
//  TFTipView.m
//  bosfera
//
//  Created by Dima Avvakumov on 24.04.13.
//  Copyright (c) 2013 East Media LTD. All rights reserved.
//

#import "TFTipView.h"

#define TFTTipShareTipKey @"SharedTipView"

@interface TFTipView() {
    float _textWidth;
    UIEdgeInsets _textInsets;
    
    float _arrowOffset;
    CGSize _arrowSize;
    
    float _cornerRadius;
    
    CGSize _shadowOffset;
    float _shadowBlur;
    
    float _verticalOffset;
}

@property (TFTIP_STRONG, nonatomic) NSString *textMessage;
@property (TFTIP_STRONG, nonatomic) UIFont *textStoreFont;

@property (TFTIP_STRONG, nonatomic) UIColor *textStoreColor;
@property (TFTIP_STRONG, nonatomic) UIColor *shadowStoreColor;
@property (TFTIP_STRONG, nonatomic) UIColor *backgroundStoreColor;

@end

@implementation TFTipView

#pragma mark - Init methods

- (id) init {
    CGRect frame = CGRectMake(0.0, 0.0, 200.0, 50.0);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initFromStyle: TFTipViewStyleDefault];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initFromStyle: TFTipViewStyleDefault];
    }
    return self;
}

- (id) initWithStyle:(TFTipViewStyle)style {
    CGRect frame = CGRectMake(0.0, 0.0, 200.0, 50.0);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initFromStyle: style];
    }
    return self;
}

+ (id) tipWithStyle:(TFTipViewStyle)style {
    TFTipView *view = TFTIP_AUTORELEASE([[TFTipView alloc] initWithStyle:style]);
    
    [TFTipView setShareTip: view];
    
    return view;
}

- (void) initFromStyle: (TFTipViewStyle) style {
    self.alpha = 0.0;
    self.opaque = NO;
    self.userInteractionEnabled = NO;
    
    self.textMessage = @"Simple message";
    
    UIFont *textFont = nil;
    UIColor *textColor = nil;
    NSNumber *textWidth = nil;
    NSString *textInsets = nil;
    NSString *arrowSize = nil;
    NSNumber *cornerRadius = nil;
    UIColor *shadowColor = nil;
    NSString *shadowOffset = nil;
    NSNumber *shadowBlur = nil;
    UIColor *backgroundColor = nil;
    NSNumber *verticalOffset = nil;
    
    NSDictionary *preset = [TFTipView presetForStyle:style];
    if (preset) {
        textFont = [preset objectForKey:TFTipViewParamTextFont];
        if (!textFont || ![textFont isKindOfClass:[UIFont class]]) {
            textFont = nil;
        }
        textColor = [preset objectForKey:TFTipViewParamTextColor];
        if (!textColor || ![textColor isKindOfClass:[UIColor class]]) {
            textColor = nil;
        }
        textWidth = [preset objectForKey:TFTipViewParamTextMaxWidth];
        if (!textWidth || ![textWidth isKindOfClass:[NSNumber class]]) {
            textWidth = nil;
        }
        textInsets = [preset objectForKey:TFTipViewParamTextInsets];
        if (!textInsets || ![textInsets isKindOfClass:[NSString class]]) {
            textInsets = nil;
        }
        arrowSize = [preset objectForKey:TFTipViewParamArrowSize];
        if (!arrowSize || ![arrowSize isKindOfClass:[NSString class]]) {
            arrowSize = nil;
        }
        cornerRadius = [preset objectForKey:TFTipViewParamCornerRadius];
        if (!cornerRadius || ![cornerRadius isKindOfClass:[NSNumber class]]) {
            cornerRadius = nil;
        }
        shadowColor = [preset objectForKey:TFTipViewParamTextShadowColor];
//        if (!shadowColor || ![shadowColor isKindOfClass:[UIColor class]]) {
//            shadowColor = nil;
//        }
        shadowOffset = [preset objectForKey:TFTipViewParamTextShadowOffset];
        if (!shadowOffset || ![shadowOffset isKindOfClass:[NSString class]]) {
            shadowOffset = nil;
        }
        shadowBlur = [preset objectForKey:TFTipViewParamTextShadowBlur];
        if (!shadowBlur || ![shadowBlur isKindOfClass:[NSNumber class]]) {
            shadowBlur = nil;
        }
        backgroundColor = [preset objectForKey:TFTipViewParamBackgroundColor];
        if (!backgroundColor || ![backgroundColor isKindOfClass:[UIColor class]]) {
            backgroundColor = nil;
        }
        verticalOffset = [preset objectForKey:TFTipViewParamVerticalOffset];
        if (!verticalOffset || ![verticalOffset isKindOfClass:[NSNumber class]]) {
            verticalOffset = nil;
        }
    }

    if (textFont == nil) {
        textFont = [UIFont fontWithName:@"Arial" size:14.0];
    }
    if (textColor == nil) {
        textColor = [UIColor whiteColor];
    }
    if (textWidth == nil) {
        _textWidth = 200.0;
    } else {
        _textWidth = [textWidth floatValue];
    }
    if (textInsets == nil) {
        _textInsets = UIEdgeInsetsMake(6.0, 6.0, 6.0, 6.0);
    } else {
        _textInsets = UIEdgeInsetsFromString(textInsets);
    }
    if (arrowSize == nil) {
        _arrowSize = CGSizeMake(14.0, 7.0);
    } else {
        _arrowSize = CGSizeFromString(arrowSize);
    }
    if (cornerRadius == nil) {
        _cornerRadius = 5.0;
    } else {
        _cornerRadius = [cornerRadius floatValue];
    }
    if (backgroundColor == nil) {
        backgroundColor = [UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:0.75];
    }
    if (shadowColor == nil || ![shadowColor isKindOfClass:[UIColor class]]) {
        shadowColor = nil;
    }
    if (shadowOffset == nil) {
        _shadowOffset = CGSizeMake(0.0, 2.0);
    } else {
        _shadowOffset = CGSizeFromString(shadowOffset);
    }
    if (shadowBlur == nil) {
        _shadowBlur = 2.0;
    } else {
        _shadowBlur = [shadowBlur floatValue];
    }
    if (verticalOffset == nil) {
        _verticalOffset = 0.0;
    } else {
        _verticalOffset = [verticalOffset floatValue];
    }
    
    self.textStoreFont = textFont;
    self.textStoreColor = textColor;
    _arrowOffset = 100.0;
    self.shadowStoreColor = shadowColor;
    self.backgroundStoreColor = backgroundColor;
}

#pragma mark - Shared tip

+ (NSMutableDictionary *) sharedTipStore {
    static NSMutableDictionary *store = nil;
    if (store == nil) {
        store = TFTIP_RETAIN([NSMutableDictionary dictionaryWithCapacity: 1]);
    }
    
    return store;
}

+ (void) setShareTip: (TFTipView *) tipView {
    NSMutableDictionary *store = [TFTipView sharedTipStore];
    if (tipView) {
        [store setObject:tipView forKey:TFTTipShareTipKey];
    } else {
        [store removeObjectForKey:TFTTipShareTipKey];
    }
}

+ (TFTipView *) sharedTip {
    NSMutableDictionary *store = [TFTipView sharedTipStore];
    return [store objectForKey:TFTTipShareTipKey];
}

#pragma mark - Show and hide methods

- (void) attachToView:(UIView *)view fromField:(UIView *)textField {
    [self redraw];
    
    // calculate position
    CGPoint pos = [view convertPoint:CGPointZero fromView:textField];
    pos.y += textField.frame.size.height + _verticalOffset;
    
    BOOL isRightSide = NO;
    if (pos.x + self.frame.size.width > view.frame.size.width) {
        pos.x = pos.x + textField.frame.size.width - self.frame.size.width;
        
        isRightSide = YES;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    
    CGRect viewFrame = self.frame;
    viewFrame.origin = pos;
    [self setFrame: viewFrame];
    
    // calculate arrow position
    if (textField.frame.size.width > self.frame.size.width) {
        _arrowOffset = roundf((self.frame.size.width / 2.0) - (_arrowSize.width / 2.0));
    } else {
        if (isRightSide) {
            float offset = self.frame.size.width - textField.frame.size.width;
            _arrowOffset = offset + roundf((textField.frame.size.width / 2.0) - (_arrowSize.width / 2.0));
        } else {
            _arrowOffset = roundf((textField.frame.size.width / 2.0) - (_arrowSize.width / 2.0));
        }
    }
    
    // attach
    [view addSubview: self];
    
    // animated show
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha: 1.0];
    }];
    
    [self setNeedsDisplay];
}

- (void) hideAnimated: (BOOL) animated {
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self setAlpha: 0.0];
        } completion:^(BOOL finished) {
            [_delegate tftViewDidHide: self];
        }];
    } else {
        [_delegate tftViewDidHide: self];
    }
}

- (void) redraw {
    CGSize maxSize = CGSizeMake(_textWidth, 3000.0);
    CGSize textSize = [_textMessage sizeWithFont:_textStoreFont constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect viewFrame = self.frame;
    viewFrame.size.width  = textSize.width  + _textInsets.left + _textInsets.right;
    viewFrame.size.height = textSize.height + _textInsets.top  + _textInsets.bottom + 2.0 * _arrowSize.height;
    [self setFrame: viewFrame];
}

- (void) drawRect:(CGRect)rect1 {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState( context );
    
    CGContextSetFillColorWithColor(context, _backgroundStoreColor.CGColor);
    // CGContextSetRGBFillColor(context, 0.27, 0.27, 0.27, 0.75);
    
    float radius = _cornerRadius;
    CGRect rect = CGRectZero;
    rect.origin.y = _arrowSize.height;
    rect.size.width  = self.frame.size.width;
    rect.size.height = self.frame.size.height - 2.0 * _arrowSize.height;
    
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius,
                    radius, M_PI, M_PI / 2, 1); //STS fixed
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius,
                            rect.origin.y + rect.size.height);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius,
                    rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius,
                    radius, 0.0f, -M_PI / 2, 1);
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius,
                    -M_PI / 2, M_PI, 1);
    
    // draw arrow
    CGContextMoveToPoint(context, _arrowOffset, _arrowSize.height);
    CGContextAddLineToPoint(context, _arrowOffset + _arrowSize.width, _arrowSize.height);
    CGContextAddLineToPoint(context, _arrowOffset + roundf(_arrowSize.width / 2.0), 0);
    
    CGContextFillPath(context);
    
    // draw text
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    
    if (_shadowStoreColor) {
        CGContextSetShadowWithColor(context, _shadowOffset, _shadowBlur, _shadowStoreColor.CGColor);
    }
    
    CGContextSetFillColorWithColor(context, _textStoreColor.CGColor);
    CGRect textRect = CGRectZero;
    textRect.origin = CGPointMake(_textInsets.left, _textInsets.top + _arrowSize.height);
    textRect.size.width = _textWidth;
    textRect.size.height = 3000.0;
    
    [_textMessage drawInRect:textRect withFont:_textStoreFont lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
    CGContextRestoreGState( context );
//    [super drawRect: rect];
}

#pragma mark - Customization

+ (void) setPreset: (NSDictionary *) preset forStyle: (TFTipViewStyle) style {
    if (!preset || ![preset isKindOfClass:[NSDictionary class]]) return;
    
    [[self sharedPresets] setObject:preset forKey:[NSString stringWithFormat:@"%d", style]];
}

+ (NSDictionary *) presetForStyle:(TFTipViewStyle)style {
    NSString *key = [NSString stringWithFormat:@"%d", style];
    NSDictionary *preset = [[self sharedPresets] objectForKey: key];
    
    if (preset) {
        return preset;
    } else {
        return [NSDictionary dictionary];
    }
}

+ (NSMutableDictionary *) sharedPresets {
    static NSMutableDictionary *sharedPresets = nil;
    if (sharedPresets == nil) {
        sharedPresets = TFTIP_RETAIN([NSMutableDictionary dictionaryWithCapacity: 1]);
    }
    
    return sharedPresets;
}

- (void) setText: (NSString *) text {
    self.textMessage = text;
    
    [self redraw];
    [self setNeedsDisplay];
}

- (void) setTextFont: (UIFont *) font {
    self.textStoreFont = font;
    
    [self redraw];
    [self setNeedsDisplay];
}

- (void) setTextColor: (UIColor *) color {
    self.textStoreColor = color;
    
    [self setNeedsDisplay];
}

- (void) setTextMaxWidth: (float) maxWidth {
    _textWidth = maxWidth;
    
    [self redraw];
    [self setNeedsDisplay];
}

- (void) setTextInsets: (UIEdgeInsets) textInsets {
    _textInsets = textInsets;
    
    [self redraw];
    [self setNeedsDisplay];
}

- (void) setTextShadowColor: (UIColor *) shadowColor {
    self.shadowStoreColor = shadowColor;
    
    [self setNeedsDisplay];
}

- (void) setTextShadowOffset: (CGSize) sharowOffset {
    _shadowOffset = sharowOffset;
    
    [self setNeedsDisplay];
}

- (void) setTextShadowBlur: (float) sharowBlur {
    _shadowBlur = sharowBlur;
    
    [self setNeedsDisplay];
}

- (void) setArrowSize: (CGSize) arrowSize {
    _arrowSize = arrowSize;
    
    [self redraw];
    [self setNeedsDisplay];
}

- (void) setCornerRadius: (float) cornerRadius {
    _cornerRadius = cornerRadius;
    
    [self setNeedsDisplay];
}

- (void) setBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundStoreColor = backgroundColor;
    
    [self setNeedsDisplay];
}

- (void) setVerticalOffset: (float) offset {
    _verticalOffset = offset;
    
    [self setNeedsDisplay];
}

@end
