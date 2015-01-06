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

@interface docShow ()
{
    FirstPopUp *firstPopUp;
    UIImageView *imageView;
    UITextField *signature;
    UIView *tempView;
    customPopUp *custom;
    NSString *myString;
    NSMutableDictionary *completeData;
    NSMutableArray *Data;
}
@end

@implementation docShow
{
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
    [self.testing_label setTextColor:[UIColor blackColor]];
    
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
    
    
}

-(void) FetchSchoolList
{
    //    CGRect rect=CGRectMake(0,110,400,250);
    //    [self.scroll setFrame:rect];
    
    
    WebService *web = [[WebService alloc]init];
    completeData = [web FilePath:@"http://dev.viditure.com/vts/signrequest/54a6eeb0e4b007dd2fc5beb8"parameterOne:nil];
    Data = [completeData valueForKey:@"dataArray"];
    NSString *authTokenValue = [[completeData valueForKey:@"Headers"]valueForKey:@"X-Auth-Token"];
    NSLog(@"the header is %@", authTokenValue);
    unsigned long pages_length = [[Data valueForKey:@"pages"]count];
    tempView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,pages_length * 400)];
    
    

    for(int i =0;i<2;i++){
          //  NSLog(@"the _id is: %@",[[[Data valueForKey:@"pages"]valueForKey:@"pageImage_url"] objectAtIndex:i]);
    
        id field_top = [[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:0]valueForKey:@"top"] objectAtIndex:i];
        id field_bottom =[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:0]valueForKey:@"bottom"] objectAtIndex:i];
        id field_left = [[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:0]valueForKey:@"left"] objectAtIndex:i];
        id field_width = [[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:0]valueForKey:@"width"] objectAtIndex:i];
        id field_height =[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:0]valueForKey:@"height"] objectAtIndex:i];
    
        id page_bottom = [[[[Data valueForKey:@"pages"]valueForKey:@"pagePosition"]valueForKey:@"bottom" ] objectAtIndex:i];
        id page_width = [[[[Data valueForKey:@"pages"]valueForKey:@"pagePosition"]valueForKey:@"width" ] objectAtIndex:i];
        id page_height = [[[[Data valueForKey:@"pages"]valueForKey:@"pagePosition"]valueForKey:@"height" ] objectAtIndex:i];
    
    NSLog(@"the bottom is: %@",page_bottom);
    NSLog(@"the width is: %@",page_width);
    NSLog(@"the height is: %@",page_height);
    
    NSData *imageData = [web returnImageData:[[[Data valueForKey:@"pages"]valueForKey:@"pageImage_url"] objectAtIndex:i] AuthTokenValue:authTokenValue];
    
    UIImage *img = [[UIImage alloc]initWithData:imageData];
    
    //NSLog(@"the image is: %@",img);
    
    signature = [[UITextField alloc]initWithFrame:CGRectMake(80,100,150,30)];
    [signature setBorderStyle:UITextBorderStyleRoundedRect];
    [signature setBackgroundColor:[UIColor lightGrayColor]];
    [signature setPlaceholder:@"Please sign here"];
    [signature setTextColor:[UIColor whiteColor]];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*400, 300, 400)];
    imageView.image = img;
    [tempView addSubview:imageView];
    [tempView addSubview:signature];
    [self.scroll addSubview:tempView];
    
    }
    self.scroll.contentSize = CGSizeMake(320,pages_length * 400);
    self.scroll.showsVerticalScrollIndicator = YES;
    self.scroll.showsHorizontalScrollIndicator = NO;
    
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return tempView;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)labelTap
{
    custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
    [custom showInView:self.view animated:YES];
    
}
+ (docShow *)sharedInstance {
    // Singleton implementation
    static docShow* instance;
    instance = [[docShow alloc] init];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[docShow alloc] init];
    });
    
    return instance;
}

-(void)textChangingTime{
    NSLog(@"hi");
    myString = [customPopUp returnpopUpString];
    [self.start_vidturing setTitle:[customPopUp returnpopUpString] forState:UIControlStateNormal];
    [self.start_vidturing setBackgroundColor:[UIColor orangeColor]];
    self.testing_label.text = myString;
    
    [self.testing_label setTextColor:[UIColor blackColor]];
    NSLog(@"the string in method is %@",myString);
    [self kardeChange];
}

-(void)kardeChange{
    NSLog(@"hello");
    myString = [customPopUp returnpopUpString];
    [self.start_vidturing setTitle:[customPopUp returnpopUpString] forState:UIControlStateNormal];
    [self.start_vidturing setBackgroundColor:[UIColor orangeColor]];
    self.testing_label.text = myString;
    
    [self.testing_label setTextColor:[UIColor blackColor]];
}

+(void)setText{
    
    //docShow.self.testing_label.text = [customPopUp returnpopUpString];
    NSLog(@"the testing string is %@",[customPopUp returnpopUpString]);
    
    [docShow sharedInstance];
    [[docShow sharedInstance]textChangingTime];
    
}

@end
