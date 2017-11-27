//
//  ExperimentViewController.m
//  Task2BS
//
//  Created by oded regev on 11/25/17.
//  Copyright © 2017 Gai Carmi. All rights reserved.
//

#import "ExperimentViewController.h"
#import "UIFloatLabelTextField.h"

@interface ExperimentViewController ()

@property (weak, nonatomic) IBOutlet UIView *customTextFieldViewHolder;

@end

@implementation ExperimentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
