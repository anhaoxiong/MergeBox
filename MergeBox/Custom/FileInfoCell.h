//
//  FileInfoCell.h
//  MergeBox
//
//  Created by Mayur Joshi on 19/08/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileInfoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelFileName;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddToPhotos;
@end
