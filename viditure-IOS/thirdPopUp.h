//
//  thirdPopUp.h
//  NMPopUpView
//
//  Created by Zainu Corporation on 09/08/2014.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "docShow.h"

@interface thirdPopUp : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak,nonatomic) UIWindow *window;
- (IBAction)TakePicture:(id)sender;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (IBAction)remove:(id)sender;

@end
