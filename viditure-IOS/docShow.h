//
//  docShow.h
//  vidture
//
//  Created by Zainu Corporation on 07/08/2014.
//  Copyright (c) 2014 Zainu Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstPopUp.h"
#import "customPopUp.h"
#import "secondPopUp.h"
#import "thirdPopUp.h"

@interface docShow : UIViewController<UIScrollViewDelegate , UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *start_vidturing;
- (IBAction)vidture_action:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (nonatomic, retain) NSString* inputData;
- (IBAction)editButtonClick:(id)sender;

+(NSMutableArray *)returnDataArray;
@end
