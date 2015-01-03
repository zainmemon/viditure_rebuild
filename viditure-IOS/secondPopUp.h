//
//  secondPopUp.h
//  NMPopUpView
//
//  Created by Zainu Corporation on 08/08/2014.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "thirdPopUp.h"

@interface secondPopUp : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (IBAction)callThirdPopUp:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *Date;
@property (readwrite, nonatomic) float alphaValue;
- (void)showInView:(UIView *)aView animated:(BOOL)animated;

- (IBAction)remove:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *canvasView;

@end
