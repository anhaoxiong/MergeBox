//
//  AllMergesViewController.m
//  MergeBox
//
//  Created by Mayur Joshi on 18/08/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import "AllMergesViewController.h"
#import "FileInfoCell.h"
#import <Photos/Photos.h>
#import <AVKit/AVKit.h>

@interface AllMergesViewController() <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray* arrayAllFiles;
@property (strong, nonatomic) IBOutlet UITableView *tableViewVideoFiles;

@end

@implementation AllMergesViewController

#pragma mark - General Actions
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayAllFiles = [NSMutableArray arrayWithArray:[self fetchMergeFiles]];
    [self.tableViewVideoFiles reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Actions
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayAllFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FileInfoCell* fileCell = (FileInfoCell* ) [tableView dequeueReusableCellWithIdentifier:@"fileCell"];
    fileCell.labelFileName.text = [NSString stringWithFormat:@"%@", self.arrayAllFiles[indexPath.row]];
    fileCell.buttonAddToPhotos.tag = indexPath.row;
    [fileCell.buttonAddToPhotos removeTarget:self action:@selector(buttonAddToPhotosClicked:) forControlEvents:UIControlEventTouchUpInside];
    [fileCell.buttonAddToPhotos addTarget:self action:@selector(buttonAddToPhotosClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return fileCell;
}

#pragma mark - UITableViewDelegate Actions
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSURL *url = [self getMergeFilePathURL:self.arrayAllFiles[indexPath.row]];
    AVPlayer* moviePlayer = [AVPlayer playerWithURL:url];
    
    AVPlayerViewController* playerViewController = [[AVPlayerViewController alloc] init];
    playerViewController.player = moviePlayer;
    [self presentViewController:playerViewController animated:YES completion:nil];    
}

#pragma mark - Button Actions
- (void) buttonAddToPhotosClicked :(id) sender {
    NSInteger currentVideo = [sender tag];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSURL *outputURL = [self getMergeFilePathURL:self.arrayAllFiles[currentVideo]];
    __block PHObjectPlaceholder *placeholder;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest* createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:outputURL];
        placeholder = [createAssetRequest placeholderForCreatedAsset];
    } completionHandler:^(BOOL success, NSError *error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [UIAlertController showDefaultAlertOnView:self withTitle:@"Added to Camera Roll" message:@"Your video is added to Camera Roll. Open up Photos to view and share the video!"];
            });
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

@end
