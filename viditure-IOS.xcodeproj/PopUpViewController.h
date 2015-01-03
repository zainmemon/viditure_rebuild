//
//  PopUpViewController.h
//  NMPopUpView
//
//  Created by Nikos Maounis on 9/12/13.
//  Copyright (c) 2013 Nikos Maounis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "secondPopUp.h"

@interface PopUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;
- (void)showInView:(UIView *)aView withMessage:(NSString *)message animated:(BOOL)animated;
- (IBAction)callSecondPopUp:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *name;
- (IBAction)remove:(id)sender;

@end
