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
    secondPopUp *secondPopup;
    UIImageView *pagesImageView;
    UIImageView *ArrowimageView;
    UITextField *signature;
    UIView *tempView;
    customPopUp *custom;
    NSString *myString;
    NSMutableDictionary *completeData;
    
    NSMutableArray *FieldType;
    float screenWidth;
    float screenHeight;
    float page_width;
    float page_height;
    float page_bottom;
    float width_ratio;
    float height_ratio;
    float UiElement_width;
    float UiElement_height;
    float field_top;
    float field_bottom;
    float field_left;
    float field_width;
    float field_height;
    int fields_count;
    bool video_time;
    bool signature_time;
    bool text_time;
   // UILabel *textLabel;
}
@end

@implementation docShow
{
    NSString * docImage;
}
static NSMutableArray *Data;

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

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    //initializations//
    
    FieldType = [[NSMutableArray alloc]init];
    fields_count = 0;
    text_time = true;
    video_time = true;
    signature_time = true;
    
    //initializations end here//
    
    [self LoadPages];
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
    
    secondPopup = [[secondPopUp alloc] initWithNibName:@"Second" bundle:nil];
    [secondPopup showInView:self.view animated:YES];

    
    //custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
    //[custom showInView:self.view animated:YES];
    
    //NSLog(@"the testing string is %@",[customPopUp returnpopUpString]);
    
    self.testing_label.text = [customPopUp returnpopUpString];
    
    
}

-(void) LoadPages
{
    
    WebService *web = [[WebService alloc]init];
    completeData = [web FilePath:@"http://dev.viditure.com/vts/signrequest/54d44561e4b078093442f58d"parameterOne:nil];
    Data = [completeData valueForKey:@"dataArray"];
    NSString *authTokenValue = [[completeData valueForKey:@"Headers"]valueForKey:@"X-Auth-Token"];
    unsigned long pages_length = [[Data valueForKey:@"pages"]count];
    unsigned long fields_length;
    tempView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,pages_length * 400)];
    
    for(int i =0;i<pages_length;i++){
          //  NSLog(@"the _id is: %@",[[[Data valueForKey:@"pages"]valueForKey:@"pageImage_url"] objectAtIndex:i]);
    
        fields_length = [[[[Data valueForKey:@"pages"]objectAtIndex:i] valueForKey:@"fields"] count];
        NSLog(@"the feilds length is: %lu",fields_length);
        
        
       // NSLog(@"The UiElement width is: %f",UiElement_width);
       // NSLog(@"The UiElement height is: %f",UiElement_height);
        
  //  NSLog(@"the bottom is: %@",page_bottom);
  //  NSLog(@"the width is: %@",page_width);
  //  NSLog(@"the height is: %@",page_height);
        
        
        //    CGRect rect=CGRectMake(0,110,400,250);
        //    [self.scroll setFrame:rect];
        
        
    
   // NSData *ArrowimageData = [web returnImageData:[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"kind"]valueForKey:@"fieldImage_url"] objectAtIndex:0] AuthTokenValue:nil];
    

    //NSLog(@"the image is: %@",img);
    
    signature = [[UITextField alloc]initWithFrame:CGRectMake(80,100,150,30)];
    [signature setBorderStyle:UITextBorderStyleRoundedRect];
    [signature setBackgroundColor:[UIColor lightGrayColor]];
    [signature setPlaceholder:@"Please sign here"];
    [signature setTextColor:[UIColor whiteColor]];
        
        
        NSData *imageData = [web returnImageData:[[[Data valueForKey:@"pages"]valueForKey:@"pageImage_url"] objectAtIndex:i] AuthTokenValue:authTokenValue];
        UIImage *img = [[UIImage alloc]initWithData:imageData];
        pagesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*400, 300, 400)];
        
        pagesImageView.image = img;
        [tempView addSubview:pagesImageView];
        
//        dispatch_queue_t myqueue = dispatch_queue_create("myqueue", NULL);
//        dispatch_async(myqueue, ^(void) {
//            
//
//
//            
//            
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // Update UI on main queue
//                
//                
//                
//            });
//            
//        });

        page_width = [[[[[Data valueForKey:@"pages"]valueForKey:@"pagePosition"]valueForKey:@"width" ] objectAtIndex:i]floatValue];
        page_height = [[[[[Data valueForKey:@"pages"]valueForKey:@"pagePosition"]valueForKey:@"height" ] objectAtIndex:i]floatValue];
       // page_bottom = [[[[[Data valueForKey:@"pages"]valueForKey:@"pagePosition"]valueForKey:@"bottom" ] objectAtIndex:i]floatValue];
        
        width_ratio = screenWidth / page_width;
        height_ratio = screenHeight / page_height;
        
        //NSLog(@"The heigth ratio is: %f",height_ratio);
        
    if(fields_length>0){
        for(int k=0; k <fields_length; k ++){
            
            NSLog(@"times in loop %d",k);
            fields_count += 1;
            
            [FieldType addObject:[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]objectAtIndex:i]valueForKey:@"kind"]valueForKey:@"type"]objectAtIndex:k]];
            
            field_top = [[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:i]valueForKey:@"top"] objectAtIndex:k]floatValue];
          //  field_bottom = [[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:0]valueForKey:@"bottom"] objectAtIndex:k]floatValue];
            field_left = [[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:i]valueForKey:@"left"] objectAtIndex:k]floatValue];
            field_width = [[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:i]valueForKey:@"width"] objectAtIndex:k]floatValue];
            field_height =[[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:i]valueForKey:@"height"] objectAtIndex:k]floatValue];
            
            
            UiElement_width = field_width * width_ratio;
            UiElement_height = field_height * height_ratio;
            
            docImage  = @"http://dev.viditure.com/UIFW/images/date-arrow.png";
            NSURL *VendorImageUrl = [NSURL URLWithString:docImage];
            NSData *data = [[NSData alloc]initWithContentsOfURL:VendorImageUrl];
            UIImage *ArrowImg = [[UIImage alloc]initWithData:data];
            
            //field_left * width_ratio,field_top * height_ratio
            
            ArrowimageView = [[UIImageView alloc]initWithFrame:CGRectMake(field_left * width_ratio,(((field_top * height_ratio)- UiElement_height)+ i*400)-200,UiElement_width,UiElement_height)];
            ArrowimageView.image = ArrowImg;
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(DynamicLabelTap:)];
            [tapRecognizer setNumberOfTouchesRequired:1];
            [tapRecognizer setDelegate:self];
            ArrowimageView.userInteractionEnabled = YES;
            ArrowimageView.tag = fields_count;
            [ArrowimageView addGestureRecognizer:tapRecognizer];
            
            NSLog(@"The arrow left margin is: %f",field_left * width_ratio);
            NSLog(@"The arrow top margin is: %f",field_top * height_ratio);
            
            [tempView addSubview:ArrowimageView];

//            dispatch_queue_t myqueue = dispatch_queue_create("myqueue", NULL);
//            dispatch_async(myqueue, ^(void) {
//                
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    // Update UI on main queue
//                    
//                    
//                    
//                });
//                
//            });
            
            }
        }
    
    //[tempView addSubview:signature];
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
   // [custom showInView:self.view animated:YES];
    
}
+ (docShow *)sharedInstance {
    // Singleton implementation
    static docShow* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[docShow alloc] init];
    });
    [[docShow sharedInstance]textChangingTime];
    return instance;
}

-(void)textChangingTime{
    NSLog(@"hi");
    myString = [customPopUp returnpopUpString];
    [self.start_vidturing setTitle:[customPopUp returnpopUpString] forState:UIControlStateNormal];
    [self.start_vidturing setBackgroundColor:[UIColor orangeColor]];
    self.testing_label.text = myString;
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.testing_label setTextColor:[UIColor blackColor]];
    NSLog(@"the string in method is %@",myString);
    [self kardeChange];
}

-(void)kardeChange{
   // NSLog(@"hello");
    myString = [customPopUp returnpopUpString];
    [self.start_vidturing setTitle:[customPopUp returnpopUpString] forState:UIControlStateNormal];
    [self.start_vidturing setBackgroundColor:[UIColor orangeColor]];
    self.testing_label.text = myString;
    
    [self.testing_label setTextColor:[UIColor blackColor]];
}

+(void)setText{
    
    NSLog(@"the testing string is %@",[customPopUp returnpopUpString]);
    
    [docShow sharedInstance];
    [[docShow sharedInstance]textChangingTime];
    
}
-(void)DynamicLabelTap: (id)sender
{
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;

    if([[FieldType objectAtIndex:[tapRecognizer.view tag]-1] isEqualToString:@"TEXT"])
    {
        if (text_time) {
            
        }
        else{
            custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
            [custom showInView:self.view animated:YES popUpString:@"Do you want to continue with the initials you have provided?"];
        }
    }
    else if ([[FieldType objectAtIndex:[tapRecognizer.view tag]-1]  isEqualToString:@"VIDEO"])
    {
        if (video_time)
        {
            video_time = false;
            [self performSegueWithIdentifier:@"camera_time" sender:self];
        }
        else{
            custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
            [custom showInView:self.view animated:YES popUpString:@"Do you want to continue with the Video you have provided?"];
        }
    }
    else if ([[FieldType objectAtIndex:[tapRecognizer.view tag]-1]  isEqualToString:@"IMAGE"])
    {
        if (signature_time)
        {
            signature_time = false;
            secondPopup = [[secondPopUp alloc] initWithNibName:@"Second" bundle:nil];
            [secondPopup showInView:self.view animated:YES];
        }
        else{
            custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
            [custom showInView:self.view animated:YES popUpString:@"Do you want to continue with the Signature you have provided?"];
        }
    }
    else
    {
        custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
        [custom showInView:self.view animated:YES popUpString:@"hello"];
    }
    
    
}

- (IBAction)unwindToVC1:(UIStoryboardSegue*)sender
{
    
}

+(NSMutableArray *)returnDataArray
{
    return Data;
}


@end
