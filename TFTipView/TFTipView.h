//
//  TFTipView.h
//  bosfera
//
//  Created by Dima Avvakumov on 24.04.13.
//  Copyright (c) 2013 East Media LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFTipPrefix.h"

typedef enum {
    TFTipViewStyleDefault = 0,
    TFTipViewStylePreset1,
    TFTipViewStylePreset2,
    TFTipViewStylePreset3,
    TFTipViewStylePreset4,
    TFTipViewStylePreset5
} TFTipViewStyle;

#define TFTipViewParamTextColor     @"TextColor"
#define TFTipViewParamTextFont      @"TextFont"
#define TFTipViewParamTextMaxWidth  @"TextWidth"
#define TFTipViewParamTextInsets    @"TextInsets"

#define TFTipViewParamTextShadowColor   @"TextShadowColor"
#define TFTipViewParamTextShadowOffset  @"TextShadowOffset"
#define TFTipViewParamTextShadowBlur    @"TextShadowBlur"

#define TFTipViewParamArrowSize @"ArrowSize"

#define TFTipViewParamCornerRadius      @"CornerRadius"
#define TFTipViewParamBackgroundColor   @"BackgroundColor"

#define TFTipViewParamVerticalOffset @"VerticalOffset"

@class TFTipView;
@protocol TFTipViewDelegate <NSObject>

- (void) tftViewDidHide: (TFTipView *) view;

@end

@interface TFTipView : UIView

@property (TFTIP_WEAK, nonatomic) id<TFTipViewDelegate> delegate;

#pragma mark - Presets
+ (void) setPreset: (NSDictionary *) preset forStyle: (TFTipViewStyle) style;
+ (NSDictionary *) presetForStyle: (TFTipViewStyle) style;

#pragma mark - Init methods
+ (id) tipWithStyle: (TFTipViewStyle) style;
- (id) initWithStyle: (TFTipViewStyle) style;

#pragma mark - Shared tip
+ (TFTipView *) sharedTip;

#pragma mark - Show and hide methods
- (void) attachToView: (UIView *) view fromField: (UIView *) textField;
- (void) hideAnimated: (BOOL) animated;

#pragma mark - Customization
- (void) setText: (NSString *) text;
- (void) setTextFont: (UIFont *) font;
- (void) setTextColor: (UIColor *) color;
- (void) setTextMaxWidth: (float) maxWidth;
- (void) setTextInsets: (UIEdgeInsets) textInsets;

- (void) setTextShadowColor: (UIColor *) shadowColor;
- (void) setTextShadowOffset: (CGSize) sharowOffset;
- (void) setTextShadowBlur: (float) sharowBlur;

- (void) setArrowSize: (CGSize) arrowSize;

- (void) setCornerRadius: (float) cornerRadius;
- (void) setBackgroundColor:(UIColor *)backgroundColor;

- (void) setVerticalOffset: (float) offset;

@end
