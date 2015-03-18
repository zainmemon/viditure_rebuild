//
//  docShow.m
//  vidture
//
//  Created by Zainu Corporation on 07/08/2014.
//  Copyright (c) 2014 Zainu Corporation. All rights reserved.
//

#import "docShow.h"
#import <QuartzCore/QuartzCore.h>
#import "WebService.h"

@interface docShow ()
{
    FirstPopUp *firstPop;
    secondPopUp *secondPopup;
    customPopUp *custom;
    thirdPopUp *third;
    
    UIImageView *pagesImageView;
    UIImageView *ArrowimageView;
    UITextField *signature;
    UIView *tempView;
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
    int label_count;
    bool video_time;
    bool signature_time;
    bool text_time;
    UILabel *returnedText;
    NSString * docImage;
}
@end

@implementation docShow

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
    
    // initializations begin //
    
    FieldType = [[NSMutableArray alloc]init];
    fields_count = 0;
    label_count = 100;
    text_time = true;
    video_time = true;
    signature_time = true;
    
    // initializations end //
    
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

    BOOL moving_time = true;
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"name"]isEqualToString:@""] || [[[NSUserDefaults standardUserDefaults] stringForKey:@"date"]isEqualToString:@""] || [[[NSUserDefaults standardUserDefaults] stringForKey:@"initials"]isEqualToString:@""])
    {
        firstPop = [[FirstPopUp alloc] initWithNibName:@"FirstPopUp" bundle:nil];
        [firstPop showInView:self.view animated:YES];
        
    }
    else
    {
        for(int i=100; i<=label_count; i++)
        {
            returnedText = (UILabel *)[tempView viewWithTag:i];
            if([returnedText.text isEqualToString:@""] || [returnedText.text isEqualToString:@"Not Filled"])
            {
                moving_time = false;
                returnedText.text = @"Not Filled";
                returnedText.textColor = [UIColor redColor];
            }
        }
        if(moving_time == true)
        {
            custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
            [custom showInView:self.view animated:YES popUpString:@"Lets Go"];
        }
    }
    
}

-(void) LoadPages
{
    
    WebService *web = [[WebService alloc]init];
    completeData = [web FilePath:@"https://test.viditure.com/vts/signrequest/55054c90e4b0bc31b3157e5a"parameterOne:nil];
    Data = [completeData valueForKey:@"dataArray"];
    NSString *authTokenValue = [[completeData valueForKey:@"Headers"]valueForKey:@"X-Auth-Token"];
    unsigned long pages_length = [[Data valueForKey:@"pages"]count];
    unsigned long fields_length;
    tempView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,pages_length * 400)];
    
    for(int i =0;i<pages_length;i++){
          //  NSLog(@"the _id is: %@",[[[Data valueForKey:@"pages"]valueForKey:@"pageImage_url"] objectAtIndex:i]);
    
        fields_length = [[[[Data valueForKey:@"pages"]objectAtIndex:i] valueForKey:@"fields"] count];
        
        pagesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*400, 320, 400)];
        
        dispatch_queue_t myqueue = dispatch_queue_create("myqueue", NULL);
        dispatch_async(myqueue, ^(void) {
            
            NSData *imageData = [web returnImageData:[[[Data valueForKey:@"pages"]valueForKey:@"pageImage_url"] objectAtIndex:i] AuthTokenValue:authTokenValue];
            UIImage *img = [[UIImage alloc]initWithData:imageData];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update UI on main queue
                
                pagesImageView.image = img;
                [tempView addSubview:pagesImageView];
            });
            
        });

        page_width = [[[[[Data valueForKey:@"pages"]valueForKey:@"pagePosition"]valueForKey:@"width" ] objectAtIndex:i]floatValue];
        page_height = [[[[[Data valueForKey:@"pages"]valueForKey:@"pagePosition"]valueForKey:@"height" ] objectAtIndex:i]floatValue];
       // page_bottom = [[[[[Data valueForKey:@"pages"]valueForKey:@"pagePosition"]valueForKey:@"bottom" ] objectAtIndex:i]floatValue];
        
        width_ratio = 320 / page_width;
        height_ratio = 400 / page_height;
        
        
    if(fields_length>0){
        for(int k=0; k <1; k ++){
            
            fields_count += 1;
            label_count +=1;
            
            [FieldType addObject:[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]objectAtIndex:i]valueForKey:@"kind"]valueForKey:@"type"]objectAtIndex:k]];
            
            field_top = [[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:i]valueForKey:@"top"] objectAtIndex:k]floatValue];
          //  field_bottom = [[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:0]valueForKey:@"bottom"] objectAtIndex:k]floatValue];
            field_left = [[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:i]valueForKey:@"left"] objectAtIndex:k]floatValue];
            field_width = [[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:i]valueForKey:@"width"] objectAtIndex:k]floatValue];
            field_height =[[[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]valueForKey:@"screenPos"]objectAtIndex:i]valueForKey:@"height"] objectAtIndex:k]floatValue];

            UiElement_width = field_width * width_ratio;
            UiElement_height = field_height * height_ratio;
            
            docImage  = [[[[[[Data valueForKey:@"pages"]valueForKey:@"fields"]objectAtIndex:i]valueForKey:@"kind"]valueForKey:@"fieldImage_url"]objectAtIndex:k];
            
            NSURL *VendorImageUrl = [NSURL URLWithString:docImage];
            NSData *data = [[NSData alloc]initWithContentsOfURL:VendorImageUrl];
            UIImage *ArrowImg = [[UIImage alloc]initWithData:data];
            
            //field_left * width_ratio,field_top * height_ratio
            
            ArrowimageView = [[UIImageView alloc]initWithFrame:CGRectMake((field_left *width_ratio) ,((field_top * height_ratio)-(field_height *height_ratio)+ i*400),UiElement_width,UiElement_height)];

            ArrowimageView.image = ArrowImg;
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(DynamicLabelTap:)];
            [tapRecognizer setNumberOfTouchesRequired:1];
            [tapRecognizer setDelegate:self];
            ArrowimageView.userInteractionEnabled = YES;
            ArrowimageView.tag = fields_count;
            [ArrowimageView addGestureRecognizer:tapRecognizer];

            [tempView addSubview:ArrowimageView];

            returnedText = [[UILabel alloc]initWithFrame:CGRectMake((field_left *width_ratio) ,((field_top * height_ratio)-(field_height *height_ratio)+ i*400 +5),200,20)];
            
            returnedText.text = @"";
            returnedText.textColor = [UIColor blackColor];
            returnedText.font = [UIFont fontWithName:@"Calibri" size:12.0];
            returnedText.tag = label_count;
            [tempView addSubview:returnedText];
            
            dispatch_queue_t myqueue = dispatch_queue_create("myqueue", NULL);
            dispatch_async(myqueue, ^(void) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Update UI on main queue
                    
                    
                    
                });
                
            });
            
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

-(void)DynamicLabelTap: (id)sender
{
    NSString *returnedString = [FirstPopUp returnRequiredString];
    NSLog(@"the returned string is %@",returnedString);
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    int clicked = [tapRecognizer.view tag]+100;
    NSLog(@"the clicked one is %d",clicked);
    returnedText = (UILabel *)[tempView viewWithTag:clicked];

    if([[FieldType objectAtIndex:[tapRecognizer.view tag]-1] isEqualToString:@"TEXT"])
    {
        if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"name"]isEqualToString:@""])
        {
            custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
            [custom showInView:self.view animated:YES popUpString:@"Please press the 'Viditure' button to fill in the required fields"];
        }
        else{
            custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
            [custom showInView:self.view animated:YES popUpString:@"Do you want to continue with the Name you have provided?"];
            
            returnedText.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
            returnedText.textColor = [UIColor blackColor];
        }
    }
    else if ([[FieldType objectAtIndex:[tapRecognizer.view tag]-1] isEqualToString:@"VIDEO"])
    {
        if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"video"]isEqualToString:@""])
        {
            [self performSegueWithIdentifier:@"camera_time" sender:self];
        }
        else{
            custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
            [custom showInView:self.view animated:YES popUpString:@"Do you want to continue with the Video you have provided?"];
            
            returnedText.text = @"video";
            returnedText.textColor = [UIColor blackColor];
        }
    }
    else if ([[FieldType objectAtIndex:[tapRecognizer.view tag]-1] isEqualToString:@"IMAGE"])
    {
        if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"signature"]isEqualToString:@""])
        {
            third = [[thirdPopUp alloc] initWithNibName:@"Third" bundle:nil];
            [third showInView:self.view animated:YES];

        }
        else{
            custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
            [custom showInView:self.view animated:YES popUpString:@"Do you want to continue with the Signature you have provided?"];
           
            returnedText.text = @"image";
            returnedText.textColor = [UIColor blackColor];
        }
    }
    else if ([[FieldType objectAtIndex:[tapRecognizer.view tag]-1] isEqualToString:@"DATE"])
    {
        if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"date"]isEqualToString:@""])
        {
            custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
            [custom showInView:self.view animated:YES popUpString:@"Please press the 'Viditure' button to fill in the required fields"];
        }
        else{
            custom = [[customPopUp alloc] initWithNibName:@"customPopUp" bundle:nil];
            [custom showInView:self.view animated:YES popUpString:@"Do you want to continue with the Date you have provided?"];
            
            returnedText.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"date"];
            returnedText.textColor = [UIColor blackColor];
        }
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
