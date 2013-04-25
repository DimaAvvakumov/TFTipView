//
//  ViewController.m
//  TipView
//
//  Created by Dima Avvakumov on 25.04.13.
//  Copyright (c) 2013 Dima Avvakumov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) TFTipView *tipView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (IBAction)hideTip:(UIButton *)sender {
    [self hideTip];
}

- (void) hideTip {
    if (_tipView) {
        [_tipView hideAnimated: YES];
        
        self.tipView = nil;
    }
}

#pragma mark - UITextFieldDelegate

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    [self hideTip];
    
    TFTipView *view = [TFTipView tipWithStyle:TFTipViewStyleDefault];
    [view setDelegate: self];
    if (textField.tag == 1) {
        [view setTextMaxWidth: 140.0];
    }
    [view setText:@"This is only demonstration variant. You can put there own text."];
    [view attachToView:self.view fromField:textField];
    
    self.tipView = view;
}

#pragma mark - TFTipViewDelegate

- (void) tftViewDidHide:(TFTipView *)view {
    [view removeFromSuperview];
}

@end
