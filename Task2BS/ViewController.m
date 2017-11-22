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

#import "UIFloatLabelTextField.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *playButton;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (nonatomic, strong) AVPlayer *videoPlayer;
- (IBAction)uploadButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *customTextFieldViewHolder;

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
    //create url
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
    
    // setup text fields
//    UIFloatLabelTextField *firstNameTextField = [UIFloatLabelTextField new];
//    [firstNameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
//    firstNameTextField.floatLabelActiveColor = [UIColor orangeColor]; // enter your color
//    firstNameTextField.placeholder = @"First Name"; // placeholder text
//    firstNameTextField.text = @"Gai"; // d text
//    firstNameTextField.delegate = self;
//    [self.view addSubview:firstNameTextField];
    
    UIFloatLabelTextField *firstNameTextField = [UIFloatLabelTextField new];
    [firstNameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    firstNameTextField.floatLabelActiveColor = [UIColor orangeColor]; // enter your color
    firstNameTextField.placeholder = @"First Name"; // placeholder text
    firstNameTextField.text = @"Gai"; // default text
    firstNameTextField.delegate = self;
    [self.customTextFieldViewHolder addSubview:firstNameTextField];
    
    // Horizontal
    [self.customTextFieldViewHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[firstNameTextField]-10-|"
                                                                      options:NSLayoutFormatAlignAllBaseline
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(firstNameTextField)]];



    // Vertical
    [self.customTextFieldViewHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[firstNameTextField(44)]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(firstNameTextField)]];
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


-(void)playerDidFinishPlaying:(NSNotification *)notification {
    NSLog(@"playerDidFinishPlaying");
    self.playButton.hidden = NO;

    //AVPlayerItemDidPlayToEndTimeNotification

}


- (IBAction)uploadButtonClicked:(id)sender {
    NSLog(@"Upload button was clicked");
    self.playButton.hidden = YES;
    [self.videoPlayer play];
}

// for text fields
#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
}

@end
