//
//  PopUpViewController.m
//  NMPopUpView
//
//  Created by Nikos Maounis on 9/12/13.
//  Copyright (c) 2013 Nikos Maounis. All rights reserved.
//

#import "FirstPopUp.h"

@interface FirstPopUp (){
    secondPopUp *second;
    thirdPopUp *third;
}

@end

@implementation FirstPopUp

static NSString *requiredString;

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
    requiredString = @"No value";
    
    [self.dataPicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    UIColor *color = [UIColor grayColor];
    
    CGColorRef border_color = [[UIColor colorWithRed:198.0f/255.0f green:217.0f/255.0f blue:241.0f/255.0f alpha:1.0] CGColor];
    
    self.name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"FULL NAME" attributes:@{NSForegroundColorAttributeName: color}];

    self.initials.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"INITIALS" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.name.layer.borderColor= border_color;
    self.name.layer.borderWidth= 1.0f;
    self.name.delegate = self;
    
    self.initials.layer.borderColor= border_color;
    self.initials.layer.borderWidth= 1.0f;
    self.initials.delegate = self;
    
    
    self.name.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    self.selectedDate.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"date"];
    self.initials.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"initials"];
    originalCenter = self.popUpView.center;
    [super viewDidLoad];
  
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
        requiredString = @"some value";
    } completion:^(BOOL finished) {
        if (finished) {
            requiredString = @"full value";
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

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
    });
}

- (IBAction)OkayPressed:(id)sender {

    [[NSUserDefaults standardUserDefaults] setObject:self.name.text forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:self.selectedDate.text forKey:@"date"];
    [[NSUserDefaults standardUserDefaults] setObject:self.initials.text forKey:@"initials"];

    [self removeAnimate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)remove:(id)sender {
    [self removeAnimate];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

+(NSString *)returnRequiredString{
    return requiredString;
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDate *minDate = [NSDate new];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:30];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setMaximumDate:maxDate];
    [datePicker setMinimumDate:minDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    self.selectedDate.text = strDate;
}

@end
