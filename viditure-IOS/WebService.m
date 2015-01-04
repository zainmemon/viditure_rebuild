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
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[filepath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                        timeoutInterval:60.0];
    //do post request for parameter passing
    [theRequest setHTTPMethod:@"POST"];
    
    //set the content type to JSON
    [theRequest setValue:@"json" forHTTPHeaderField:@"Content-Type"];
    
    //passing key as a http header request
    [theRequest addValue:@"54a7afc9e4b007dd2fc5bf07" forHTTPHeaderField:@"X-Auth-Token"];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        return greeting;
        
    }
    else
    {
        NSLog(@"theConnection is NULL");
        return 0;
    }
    
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
-(NSData *)returnImageData:(NSString *)URL{
NSURL *theURL = [NSURL URLWithString:URL];
NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL      cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];

//Specify method of request(Get or Post)
[theRequest setHTTPMethod:@"GET"];

//Pass some default parameter(like content-type etc.)
[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
[theRequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];

//Now pass your own parameter

[theRequest setValue:@"54a7afc9e4b007dd2fc5bf07" forHTTPHeaderField:@"X-Auth-Token"];

NSURLResponse *theResponse = NULL;
NSError *theError = NULL;
NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    return theResponseData;
}
@end
