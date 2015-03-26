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

    NSURL *video = [self grabFileURL:@"movie.mov"];
    NSLog(@"out condition");
    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:video];
    _moviePlayer.view.frame = CGRectMake(0, 125, 320, 245);
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer play];
 
}

- (NSURL*)grabFileURL:(NSString *)fileName {
    
    NSString *DestPath;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    DestPath = [paths objectAtIndex:0];
    DestPath = [DestPath stringByAppendingPathComponent:fileName];
    
    NSURL* saveLocationURL = [[NSURL alloc] initFileURLWithPath:DestPath];
    
    return saveLocationURL;
}

- (IBAction)video_viditured:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"video_done" forKey:@"video"];
}
@end
