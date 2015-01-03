//
//  customPopUp.h
//  viditure-IOS
//
//  Created by Avialdo on 15/12/2014.
//  Copyright (c) 2014 Zohair Hemani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface customPopUp : UIViewController
- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@property (weak, nonatomic) IBOutlet UITextField *full_name;
- (IBAction)okay_button:(id)sender;
- (IBAction)cancel_button:(id)sender;

+(NSString *)returnpopUpString;

@end
