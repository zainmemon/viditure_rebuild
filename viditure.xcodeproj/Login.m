//
//  ViewController.m
//  vidture
//
//  Created by Zainu Corporation on 06/08/2014.
//  Copyright (c) 2014 Zainu Corporation. All rights reserved.
//

#import "Login.h"

@interface Login ()

@end

@implementation Login

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    UIColor *color = [UIColor grayColor];
    self.email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Email" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.email.layer.borderColor=[[UIColor colorWithRed:198.0f/255.0f green:217.0f/255.0f blue:241.0f/255.0f alpha:1.0] CGColor];
    self.email.layer.borderWidth= 1.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
