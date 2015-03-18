//
//  secondPopUp.m
//  NMPopUpView
//
//  Created by Zainu Corporation on 08/08/2014.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

#import "secondPopUp.h"
#import "Canvas.h"
#import <QuartzCore/QuartzCore.h>

@interface secondPopUp (){
    thirdPopUp *third;
}

@property (unsafe_unretained, nonatomic) IBOutlet Canvas *drawingPad;
- (IBAction)clear:(id)sender;

@end

@implementation secondPopUp

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
    
    
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:self.alphaValue];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    [self.drawingPad setBackgroundColor:[UIColor lightGrayColor]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)callThirdPopUp:(id)sender {
    
    UIGraphicsBeginImageContextWithOptions(self.canvasView.bounds.size, NO, 0);
    
    [self.canvasView drawViewHierarchyInRect:self.canvasView.bounds afterScreenUpdates:YES];
    
    UIImage *copied = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(copied, nil, nil, nil);
    [[NSUserDefaults standardUserDefaults] setObject:@"signature_done" forKey:@"signature"];
    [self removeAnimate];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView * txt in self.view.subviews){
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [txt resignFirstResponder];
        }
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)clear:(id)sender
{
	[self.drawingPad clearToColor:[UIColor clearColor]];
}

@end
