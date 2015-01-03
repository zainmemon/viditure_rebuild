//
//  thirdPopUp.m
//  NMPopUpView
//
//  Created by Zainu Corporation on 09/08/2014.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

#import "thirdPopUp.h"

@interface thirdPopUp ()

@end

@implementation thirdPopUp

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
    self.name.delegate = self;
    self.date.delegate = self;
    
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.0];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    self.date.text = self.mydate;
    
     UIColor *color = [UIColor grayColor];
    
    CGColorRef border_color = [[UIColor colorWithRed:198.0f/255.0f green:217.0f/255.0f blue:241.0f/255.0f alpha:1.0] CGColor];
    
    self.date.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"DATE" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.date.layer.borderColor= border_color;
    self.date.layer.borderWidth= 1.0f;
    
    self.name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"FULL NAME" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.name.layer.borderColor= border_color;
    self.name.layer.borderWidth= 1.0f;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView * txt in self.view.subviews){
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [txt resignFirstResponder];
        }
    }
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
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

- (IBAction)next:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"camera_time"];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:vc animated:YES completion:nil];
    //[self.navigationController pushViewController:vc animated:YES];
    
    }

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [aView addSubview:self.view];
        
        if (animated) {
            [self showAnimate];
        }
    });
}

- (IBAction)remove:(id)sender {
    [self removeAnimate];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
