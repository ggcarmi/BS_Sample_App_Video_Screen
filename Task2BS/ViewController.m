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
@property (weak, nonatomic) IBOutlet UIView *userDetailContainerView;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic)UIFloatLabelTextField *nameTextField;
@property (strong, nonatomic)UIFloatLabelTextField *cityTextField;

- (IBAction)retakeVideo:(id)sender;
-(void)createTextField;
- (IBAction)uploadButtonClicked:(id)sender;



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
    
    // need to take this out to utils function
    if( !_name.length || !_city.length ){
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"error"
                                     message:@"name and city can not be empty!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        UIAlertAction* oKButton = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        
        //Add your buttons to alert controller
        [alert addAction:oKButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        // print name and city
        NSLog(@"The name is: %@ and the city is: %@", _name, _city);
    }

//    self.playButton.hidden = YES;
//    [self.videoPlayer play];
}

// for text fields
#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _name = _nameTextField.text;
    _city = _cityTextField.text;

    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
}

- (IBAction)retakeVideo:(id)sender {
    NSLog(@"retake video button was clicked");

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
    
    _nameTextField = [UIFloatLabelTextField new];
//    [firstNameTextField setFont:[UIFont fontWithName:@"Helvetica" size:20]];

    
    [_nameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
//    firstNameTextField.floatLabelActiveColor = [UIColor orangeColor]; // the placeholder color after
    _nameTextField.placeholder = @"First Name"; // placeholder text
    _nameTextField.text = @""; // default text
    _nameTextField.delegate = self;
//    firstNameTextField.dismissKeyboardWhenClearingTextField = @YES;
//    firstNameTextField.clearButtonMode = UITextFieldViewModeNever;
    
    [self.userDetailContainerView addSubview:_nameTextField];
    
    _cityTextField = [UIFloatLabelTextField new];
//    [cityTextField setFont:[UIFont fontWithName:@"Helvetica" size:20]];

    [_cityTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
//    cityTextField.floatLabelActiveColor = [UIColor orangeColor]; // enter your color
    _cityTextField.placeholder = @"City"; // placeholder text
    _cityTextField.text = @""; // default text
    _cityTextField.delegate = self;
    [self.userDetailContainerView addSubview:_cityTextField];
    
    // Horizontal
    [self.userDetailContainerView addConstraints:[NSLayoutConstraint
          constraintsWithVisualFormat:@"H:|-10-[_nameTextField]-10-|"
          options:NSLayoutFormatAlignAllBaseline metrics:nil
          views:NSDictionaryOfVariableBindings(_nameTextField)]];

    [self.userDetailContainerView addConstraints:[NSLayoutConstraint
          constraintsWithVisualFormat:@"H:|-10-[_cityTextField]-10-|"
          options:NSLayoutFormatAlignAllBaseline metrics:nil
          views:NSDictionaryOfVariableBindings(_cityTextField)]];

    
    
    // Vertical
    [self.userDetailContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_nameTextField(44)]-80-[_cityTextField(44)]"
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:NSDictionaryOfVariableBindings(_nameTextField, _cityTextField)]];
}

@end
