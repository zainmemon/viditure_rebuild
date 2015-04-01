//
//  PopUpViewController.m
//  NMPopUpView
//
//  Created by Nikos Maounis on 9/12/13.
//  Copyright (c) 2013 Nikos Maounis. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController (){
    secondPopUp *second;
}

@end

@implementation PopUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    UIColor *color = [UIColor grayColor];
    
    CGColorRef border_color = [[UIColor colorWithRed:198.0f/255.0f green:217.0f/255.0f blue:241.0f/255.0f alpha:1.0] CGColor];
    
    self.name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"FULL NAME" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.name.layer.borderColor= border_color;
    self.name.layer.borderWidth= 1.0f;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    //self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
       // self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
        
    }];
 
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView * txt in self.view.subviews){
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [txt resignFirstResponder];
        }
    }
}


- (void)showInView:(UIView *)aView withMessage:(NSString *)message animated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
    });
}

- (IBAction)callSecondPopUp:(id)sender {
    second = [[secondPopUp alloc] initWithNibName:@"Second" bundle:nil];
    [second setTitle:@"This is a popup view"];
    //third.mydate = self.Date.text;
    [second showInView:self.view withMessage:@"You just triggered a great popup window" animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)remove:(id)sender {
    [self removeAnimate];
}
@end
