//
//  ViewController.m
//  Task2BS
//
//  Created by Gai Carmi on 11/20/17.
//  Copyright © 2017 Gai Carmi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *playButton;
@property (weak, nonatomic) IBOutlet UIView *videoView;

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
    
}

-(void)tapDetected{
    NSLog(@"single Tap on imageview");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
