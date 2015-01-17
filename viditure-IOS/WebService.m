//
//  WebService.m
//  Panic AAlaram Application
//
//  Created by Zohair Hemani on 04/05/2014.
//  Copyright (c) 2014 Zohair Hemani - Stanford Assignment. All rights reserved.
//

#import "WebService.h"

@implementation WebService{
    NSMutableDictionary *completeData;
}

-(NSMutableDictionary*)FilePath:(NSString*)filepath parameterOne:(NSString*)parameterOne parameterTwo:(NSString*)parameterTwo parameterThree:(NSString*)parameterThree
{
    
    NSURL *theURL = [NSURL URLWithString:filepath];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL      cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];

    [theRequest setHTTPMethod:@"GET"];

    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    //Now pass your own parameter
    
    [theRequest setValue:@"iosapp" forHTTPHeaderField:@"X-Viditure-App"];
    
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
//    NSDictionary *dataDictionaryResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:0 error:&theError];
    
//    NSString *response = [[NSString alloc] initWithBytes:[theResponseData bytes] length:[theResponseData length] encoding:NSUTF8StringEncoding];

    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: theResponseData options: NSJSONReadingMutableContainers error: nil];

    // NSLog(@"Response String: %@",response);
   // NSLog(@"JsonArray %@", jsonArray);
    
    NSDictionary* headers = [(NSHTTPURLResponse *)theResponse allHeaderFields];
    
    completeData = [[NSMutableDictionary alloc]init];
    
    [completeData setObject:headers forKey:@"Headers"];
    [completeData setObject:jsonArray forKey:@"dataArray"];
    
    return completeData;
    
//    NSURL *jsonFileUrl = [NSURL URLWithString:filepath];
    
//    NSString *myRequestString = [NSString stringWithFormat:@"parameterOne=%@&parameterTwo=%@&parameterThree=%@&session=%@",parameterOne,parameterTwo,parameterThree,@"storedsession"];
    
//    // Create Data from request
//    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: jsonFileUrl];
//    // set Request Type
//    NSError *err = nil;
//    [request setHTTPMethod:@"GET"];
//    // Set content-type
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
//    [request setValue:@"json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"androidapp" forHTTPHeaderField:@"X-Viditure-App"];
//    // Set Request Body
//    [request setHTTPBody: myRequestData];
//    // Now send a request and get Response
//    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
//    // Log Response
//    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
//    
//    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: returnData options: NSJSONReadingMutableContainers error: &err];
//    
//    NSLog(@"Response String: %@",response);
//    NSLog(@"JsonArray %@", jsonArray);
    
    //[NSURLConnection connectionWithRequest:request delegate:self];
    
    // return response;
    //return jsonArray;
    
    
}

-(NSMutableDictionary*)FilePath:(NSString*)filepath parameterOne:(NSString*)parameterOne
{
    
    NSMutableDictionary * responseArray = [self FilePath:filepath parameterOne:parameterOne parameterTwo:nil parameterThree:nil];
    return responseArray;
}

-(NSMutableDictionary*)FilePath:(NSString*)filepath parameterOne:(NSString*)parameterOne parameterTwo:(NSString*)parameterTwo
{
    NSMutableDictionary * responseArray = [self FilePath:filepath parameterOne:parameterOne parameterTwo:parameterTwo parameterThree:nil];
    return responseArray;
}


-(NSData *)returnImageData:(NSString *)URL AuthTokenValue:(NSString *)token
{
    NSURL *theURL = [NSURL URLWithString:URL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];

//Specify method of request(Get or Post)
[theRequest setHTTPMethod:@"GET"];

//Pass some default parameter(like content-type etc.)
[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
[theRequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];

//Now pass your own parameter

[theRequest setValue:token forHTTPHeaderField:@"X-Auth-Token"];

NSURLResponse *theResponse = NULL;
NSError *theError = NULL;
NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    return theResponseData;
}
@end
