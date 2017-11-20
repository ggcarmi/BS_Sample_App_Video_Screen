//
//  ViewController.m
//  Task2BS
//
//  Created by Gai Carmi on 11/20/17.
//  Copyright © 2017 Gai Carmi. All rights reserved.
//

#import "ViewController.h"
#import "BRVideoPreviewVC.h"
#import <AVKit/AVKit.h>
#import <CoreMedia/CoreMedia.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *playButton;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (nonatomic, strong) AVPlayer *videoPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // make the image (play button) clickable
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [_playButton setUserInteractionEnabled:YES];
    [_playButton addGestureRecognizer:singleTap];
    
    // handle video
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sampleVideo" ofType:@"mp4"]];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:videoURL];
    self.videoPlayer = [AVPlayer playerWithPlayerItem:item];
    
    CALayer *superlayer = self.playerView.layer;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.videoPlayer];
    [playerLayer setFrame:self.playerView.bounds];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [superlayer addSublayer:playerLayer];
    
    [self.playerView bringSubviewToFront:self.playButton];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    
//    // end - handle video
    
}

-(void)tapDetected{
    NSLog(@"play button was clicked");
    self.playButton.hidden = YES;
    [self.videoPlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//// for video
-(UIView *) createHeaderView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:60]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    return contentView;
}

-(void)playerDidFinishPlaying:(NSNotification *)notification {
    NSLog(@"playerDidFinishPlaying");
}

//- (IBAction)playVideoButtonPressed:(id)sender {
//    self.playButton.hidden = YES;
//    [self.videoPlayer play];
//}


@end
