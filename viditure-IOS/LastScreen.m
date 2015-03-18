//
//  LastScreen.m
//  viditure-IOS
//
//  Created by Avialdo on 23/09/2014.
//  Copyright (c) 2014 Zohair Hemani. All rights reserved.
//

#import "LastScreen.h"
#import <MediaPlayer/MediaPlayer.h>
@interface LastScreen ()
{
    MPMoviePlayerController *_moviePlayer;
}

@end

@implementation LastScreen

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
    
    
//    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:@"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"]];
//    player.view.frame = CGRectMake(20, 20, 280, 300);
//    [self.view addSubview:player.view];
//    [player play];
    
    
}

-(void)playMovie:(id)sender
{
    NSString *url = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"mp4"];
    
    _moviePlayer =[[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:url]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    _moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:YES];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)play:(id)sender {
    [self playMovie:self];
}
@end
