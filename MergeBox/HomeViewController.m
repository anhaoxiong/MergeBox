//
//  HomeViewController.m
//  MergeBox
//
//  Created by Mayur Joshi on 17/08/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

#pragma mark - General Actions
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actionsheet Actions
- (void) showSelectVideoActionSheet {
    UIAlertController* actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //add take photo button
    UIAlertAction* takePhoto = [UIAlertAction actionWithTitle:@"Take a new video" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //open up camera with video options
        
    }];
    [actionSheet addAction:takePhoto];
    
    //add choose photo button
    UIAlertAction* choosePhoto = [UIAlertAction actionWithTitle:@"Choose an existing video" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //open up library with only Videos
        
    }];
    [actionSheet addAction:choosePhoto];
    
    //add cancel button
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }];
    [actionSheet addAction:cancel];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - Button Actions
- (IBAction)selectFirstVideoClicked:(id)sender {
    [self showSelectVideoActionSheet];
    
    
}

- (IBAction)selectSecondVideoClicked:(id)sender {
    [self showSelectVideoActionSheet];
    
}

- (IBAction)createMergeClicked:(id)sender {
    
}

- (IBAction)viewMergesClicked:(id)sender {
    
}

@end