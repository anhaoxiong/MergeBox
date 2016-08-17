//
//  HomeViewController.m
//  MergeBox
//
//  Created by Mayur Joshi on 17/08/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import "HomeViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, readwrite) BOOL selectingFirstVideo;

@property(nonatomic, strong) AVAsset* assetFirstVideo;
@property(nonatomic, strong) AVAsset* assetSecondVideo;

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

#pragma mark - Merge Functions
- (void) mergeTrackIntoComposition:(AVMutableComposition* ) composition isFirstTrack:(BOOL) isFirstTrack {
    AVAsset* assetCurrentTrack = self.assetFirstVideo;
    CMTime atTime = kCMTimeZero;
    if(!isFirstTrack) {
        assetCurrentTrack = self.assetSecondVideo;
        atTime = self.assetFirstVideo.duration;
    }
    
    //get the current track and add its range accordingly
    AVMutableCompositionTrack *currentTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    [currentTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, assetCurrentTrack.duration) ofTrack:[[assetCurrentTrack tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:atTime error:nil];
    
    //check if video has sound, if yes.. mix it into composition as well
    if ([[assetCurrentTrack tracksWithMediaType:AVMediaTypeAudio] count] > 0)
    {
        AVMutableCompositionTrack *currentTrackAudio = [composition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                              preferredTrackID:kCMPersistentTrackID_Invalid];
        
        AVAssetTrack *clipAudioTrack = [[assetCurrentTrack tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
        [currentTrackAudio insertTimeRange:CMTimeRangeMake(kCMTimeZero, assetCurrentTrack.duration) ofTrack:clipAudioTrack atTime:atTime error:nil];
    }
}

#pragma mark - Show/Hide Actions
- (void) showSelectVideoActionSheet {
    UIAlertController* actionSheet = [UIAlertController alertControllerWithTitle:@"Select a Video" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //add take photo button
    UIAlertAction* takePhoto = [UIAlertAction actionWithTitle:@"Take a new video" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showCamera];
    }];
    [actionSheet addAction:takePhoto];
    
    //add choose photo button
    UIAlertAction* choosePhoto = [UIAlertAction actionWithTitle:@"Choose an existing video" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseVideoFromLibrary];
    }];
    [actionSheet addAction:choosePhoto];
    
    //add cancel button
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }];
    [actionSheet addAction:cancel];

    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void) showCamera {
    //open up camera with video options
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.allowsEditing = NO;
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
    imagePickerController.delegate = self;
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void) chooseVideoFromLibrary {
    //open up library with only Videos
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = NO;
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
    imagePickerController.delegate = self;
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate actions
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSString *currentMediaType = [info objectForKey: UIImagePickerControllerMediaType];
        if (CFStringCompare ((__bridge_retained CFStringRef) currentMediaType, kUTTypeMovie, 0)
            == kCFCompareEqualTo) {
            if(self.selectingFirstVideo) {
                self.assetFirstVideo = [AVAsset assetWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
            }
            else {
                self.assetSecondVideo = [AVAsset assetWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
            }
        }
    }];
}

#pragma mark - Button Actions
- (IBAction)selectFirstVideoClicked:(id)sender {
    self.selectingFirstVideo = YES;
    [self showSelectVideoActionSheet];
}

- (IBAction)selectSecondVideoClicked:(id)sender {
    self.selectingFirstVideo = NO;
    [self showSelectVideoActionSheet];
}

- (IBAction)createMergeClicked:(id)sender {
    //check if both the videos are already selected
    if(!self.assetFirstVideo || !self.assetSecondVideo) {
        [UIAlertController showDefaultAlertOnView:self withTitle:@"Select both videos" message:@"Merge can be done only when both videos have been selected"];
    }
    
    //Create AVMutableComposition Object.This object will hold our multiple AVMutableCompositionTrack.
    AVMutableComposition* mergedComposition = [[AVMutableComposition alloc] init];
    
    //get the video tracks
    [self mergeTrackIntoComposition:mergedComposition isFirstTrack:YES];
    [self mergeTrackIntoComposition:mergedComposition isFirstTrack:NO];
    
    //check for orientation issues
    
    //set transform according to orienations
    
    //generate main composition
    
    //get file path and name
    
    //export the video to the file path
}

- (IBAction)viewMergesClicked:(id)sender {
    
}

@end