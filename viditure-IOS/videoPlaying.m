//
//  videoTesting.m
//  vidture
//
//  Created by Zohair Hemani on 21/08/2014.
//  Copyright (c) 2014 Zainu Corporation. All rights reserved.
//

#import "videoPlaying.h"


@implementation videoPlaying
{
    MPMoviePlayerController *_moviePlayer;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *file = [documentPath stringByAppendingPathComponent:@"movie.mov"];
    NSURL *url = [NSURL fileURLWithPath:file];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:file];
    if(fileExists)
    {
        _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame = CGRectMake(20, 80, 280, 260);
         [self.view addSubview:_moviePlayer.view];
         [_moviePlayer play];
    }
    
    //NSString *url = [[NSBundle mainBundle]pathForResource:@"movie" ofType:@"mov"];
    
//    _moviePlayer =[[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:url]];
//    
//    _moviePlayer.view.frame = CGRectMake(20, 80, 280, 260);
//    [self.view addSubview:_moviePlayer.view];
//    [_moviePlayer play];
    
}

- (IBAction)video_viditured:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"video_done" forKey:@"video"];
}
@end
