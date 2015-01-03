//
//  LastScreen.m
//  viditure-IOS
//
//  Created by Avialdo on 23/09/2014.
//  Copyright (c) 2014 Zohair Hemani. All rights reserved.
//

#import "LastScreen.h"

@interface LastScreen ()

@end

@implementation LastScreen

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
