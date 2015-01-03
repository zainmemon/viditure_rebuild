//
//  WebService.m
//  Panic AAlaram Application
//
//  Created by Zohair Hemani on 04/05/2014.
//  Copyright (c) 2014 Zohair Hemani - Stanford Assignment. All rights reserved.
//

#import "WebService.h"

@implementation WebService
NSDictionary *greeting;

-(NSDictionary*)FilePath:(NSString*)filepath parameterOne:(NSString*)parameterOne parameterTwo:(NSString*)parameterTwo parameterThree:(NSString*)parameterThree
{
    NSURL *jsonFileUrl = [NSURL URLWithString:filepath];
    
    // Create the NSURLConnection
    //NSString * username = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    //NSString *number = @"03432637576";
    
    // Posting the values of edit text field to database to query the results.
    
 //   NSString *myRequestString = [NSString stringWithFormat:@"parameterOne=%@&parameterTwo=%@&parameterThree=%@&username=%@",parameterOne,parameterTwo,parameterThree,storedNumber];
    
    // Create Data from request
  //  NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
  
    

    // Log Response
   // NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    
    //NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: returnData options: NSJSONReadingMutableContainers error: &err];
    
  //  NSLog(@"response is %@",response);
  //  NSLog(@"JsonArray %@", jsonArray);
    
    // return response;
    return greeting;
}

-(NSArray*)FilePath:(NSString*)filepath parameterOne:(NSString*)parameterOne
{
    
    NSArray * responseArray = [self FilePath:filepath parameterOne:parameterOne parameterTwo:nil parameterThree:nil];
    return responseArray;
}

-(NSArray*)FilePath:(NSString*)filepath parameterOne:(NSString*)parameterOne parameterTwo:(NSString*)parameterTwo
{
    NSArray * responseArray = [self FilePath:filepath parameterOne:parameterOne parameterTwo:parameterTwo parameterThree:nil];
    return responseArray;
}

@end
