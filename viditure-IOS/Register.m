//
//  Register.m
//  vidture
//
//  Created by Zainu Corporation on 06/08/2014.
//  Copyright (c) 2014 Zainu Corporation. All rights reserved.
//

#import "Register.h"
#import "WebService.h"
#import "Constants.h"

@interface Register ()

@end

@implementation Register{
    NSString * VendorImage;
    UIScrollView *scroll;
}

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

    [self FetchSchoolList];
    [self.view addSubview:scroll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) FetchSchoolList
{
    VendorImage  = @"http://54.183.77.229:8080/rbs/documents/53f8d90ae4b0e2d5a4aae1c6/pages/0/image";
    
    CGRect rect=CGRectMake(0,110,400,250);
    scroll = [[UIScrollView alloc] initWithFrame:rect];
    
    NSURL *VendorImageUrl = [NSURL URLWithString:VendorImage];
    NSData *data = [[NSData alloc]initWithContentsOfURL:VendorImageUrl];
    UIImage *img = [[UIImage alloc]initWithData:data];
    UITextField *signature = [[UITextField alloc]initWithFrame:CGRectMake(80,100,150,30)];
    [signature setBorderStyle:UITextBorderStyleRoundedRect];
    [signature setBackgroundColor:[UIColor lightGrayColor]];
    [signature setPlaceholder:@"Please sign here"];
    [signature setTextColor:[UIColor whiteColor]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 300, 400)];
    imageView.image = img;
    [scroll addSubview:imageView];
    [scroll addSubview:signature];
    
    scroll.contentSize = CGSizeMake(400,1000);
    scroll.showsVerticalScrollIndicator = YES;
    
}

@end
