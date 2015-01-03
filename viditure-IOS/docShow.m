//
//  docShow.m
//  vidture
//
//  Created by Zainu Corporation on 07/08/2014.
//  Copyright (c) 2014 Zainu Corporation. All rights reserved.
//

#import "docShow.h"
#import <QuartzCore/QuartzCore.h>
#import "customPopUp.h"
#import "WebService.h"

@interface docShow (){
    FirstPopUp *firstPopUp;
    UIImageView *imageView;
    UITextField *signature;
    UIView *tempView;
    customPopUp *custom;
}
@end

@implementation docShow{
    NSString * docImage;
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
    [self.view addSubview:self.scroll];
    signature.delegate = self;
    
    [[self scroll]setMaximumZoomScale:3.0f];
    
    self.testing_label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [self.testing_label addGestureRecognizer:tapGesture];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]}];
}

- (IBAction)vidture_action:(id)sender {

    //firstPopUp = [[FirstPopUp alloc] initWithNibName:@"FirstPopUp" bundle:nil];

    //[firstPopUp showInView:self.view animated:YES];
    
    custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
    [custom showInView:self.view animated:YES];
    
    NSLog(@"the testing string is %@",[customPopUp returnpopUpString]);
    
    self.testing_label.text = [customPopUp returnpopUpString];
    [self.testing_label setTextColor:[UIColor blackColor]];
    
}

-(void) FetchSchoolList
{
    WebService *w = [[WebService alloc]init];
    [w FilePath:@"http://dev.viditure.com/vts/signrequest/54a6eeb0e4b007dd2fc5beb8"parameterOne:nil];
    
    
    docImage  = @"http://54.183.77.229:8080/rbs/documents/53f8d90ae4b0e2d5a4aae1c6/pages/0/image";
    
//    CGRect rect=CGRectMake(0,110,400,250);
//    [self.scroll setFrame:rect];
    
    NSURL *VendorImageUrl = [NSURL URLWithString:docImage];
    tempView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,1000)];
    NSData *data = [[NSData alloc]initWithContentsOfURL:VendorImageUrl];
    UIImage *img = [[UIImage alloc]initWithData:data];
    
    signature = [[UITextField alloc]initWithFrame:CGRectMake(80,100,150,30)];
    [signature setBorderStyle:UITextBorderStyleRoundedRect];
    [signature setBackgroundColor:[UIColor lightGrayColor]];
    [signature setPlaceholder:@"Please sign here"];
    [signature setTextColor:[UIColor whiteColor]];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 300, 400)];
    imageView.image = img;
    [tempView addSubview:imageView];
    [tempView addSubview:signature];
    [self.scroll addSubview:tempView];
    
    self.scroll.contentSize = CGSizeMake(320,1000);
    self.scroll.showsVerticalScrollIndicator = YES;
    self.scroll.showsHorizontalScrollIndicator = NO;
    
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return tempView;

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)labelTap{
    custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
    [custom showInView:self.view animated:YES];
    
}

-(void)hello{
    
}

+(void)setText{
    
    //docShow.self.testing_label.text = [customPopUp returnpopUpString];
    NSLog(@"the testing string is %@",[customPopUp returnpopUpString]);
    
}

@end
