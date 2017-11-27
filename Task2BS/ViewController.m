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
@property (weak, nonatomic) IBOutlet UIView *userDetailContainerView;

-(void)createTextField;


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
    
    [self createTextField];

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
    [self.videoPlayer seekToTime:kCMTimeZero];

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

-(void)createTextField {
    
    // setup text fields

    //general
//        UIColor *grayColorBS = [UIColor colorWithRed:(15) green:(20) blue:(24) alpha:(1)];
    UIColor *grayColorBS = [UIColor blueColor];

    //    self.userDetailContainerView.backgroundColor = [UIColor grayColor];
    //    self.title = @"UIFloatLabelTextField Example";
    [[UIFloatLabelTextField appearance] setBackgroundColor:[UIColor grayColor]] ;
//    [[UIFloatLabelTextField appearance] setBackgroundColor:self.userDetailContainerView.backgroundColor] ;

    
    // main text
    [[UIFloatLabelTextField appearance] setFont:[UIFont fontWithName:@"Helvetica" size:22]];
    [[UIFloatLabelTextField appearance] setTextColor:[UIColor whiteColor]]; // the text color
    
    // floating text
    [[UIFloatLabelTextField appearance] setFloatLabelFont:[UIFont fontWithName:@"Helvetica" size:16]];
    
    [[UIFloatLabelTextField appearance] setFloatLabelPassiveColor:grayColorBS];
    [[UIFloatLabelTextField appearance] setFloatLabelActiveColor:grayColorBS];
    
    UIFloatLabelTextField *firstNameTextField = [UIFloatLabelTextField new];
//    [firstNameTextField setFont:[UIFont fontWithName:@"Helvetica" size:20]];

    
    [firstNameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
//    firstNameTextField.floatLabelActiveColor = [UIColor orangeColor]; // the placeholder color after
    firstNameTextField.placeholder = @"First Name"; // placeholder text
    firstNameTextField.text = @""; // default text
    firstNameTextField.delegate = self;
//    firstNameTextField.dismissKeyboardWhenClearingTextField = @YES;
//    firstNameTextField.clearButtonMode = UITextFieldViewModeNever;
    
    [self.userDetailContainerView addSubview:firstNameTextField];
    
    UIFloatLabelTextField *cityTextField = [UIFloatLabelTextField new];
//    [cityTextField setFont:[UIFont fontWithName:@"Helvetica" size:20]];

    [cityTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
//    cityTextField.floatLabelActiveColor = [UIColor orangeColor]; // enter your color
    cityTextField.placeholder = @"City"; // placeholder text
    cityTextField.text = @""; // default text
    cityTextField.delegate = self;
    [self.userDetailContainerView addSubview:cityTextField];
    
    // Horizontal
    [self.userDetailContainerView addConstraints:[NSLayoutConstraint
          constraintsWithVisualFormat:@"H:|-10-[firstNameTextField]-10-|"
          options:NSLayoutFormatAlignAllBaseline metrics:nil
          views:NSDictionaryOfVariableBindings(firstNameTextField)]];

    [self.userDetailContainerView addConstraints:[NSLayoutConstraint
          constraintsWithVisualFormat:@"H:|-10-[cityTextField]-10-|"
          options:NSLayoutFormatAlignAllBaseline metrics:nil
          views:NSDictionaryOfVariableBindings(cityTextField)]];

    
    
    // Vertical
    [self.userDetailContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[firstNameTextField(44)]-80-[cityTextField(44)]"
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:NSDictionaryOfVariableBindings(firstNameTextField, cityTextField)]];
}

@end
