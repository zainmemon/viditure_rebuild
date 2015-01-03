//
//  thirdPopUp.h
//  NMPopUpView
//
//  Created by Zainu Corporation on 09/08/2014.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "docShow.h"

@interface thirdPopUp : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *date;

@property (weak,nonatomic) UIWindow *window;
- (IBAction)next:(id)sender;
@property (strong,nonatomic) NSString *mydate;


- (void)showInView:(UIView *)aView withMessage:(NSString *)message animated:(BOOL)animated;
- (IBAction)remove:(id)sender;

@end
