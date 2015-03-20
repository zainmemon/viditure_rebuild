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
    
    NSString *url = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"mp4"];
    
    _moviePlayer =[[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:url]];
    
    _moviePlayer.view.frame = CGRectMake(20, 80, 280, 260);
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer play];
    
}

- (IBAction)video_viditured:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"video_done" forKey:@"video"];
}
@end
