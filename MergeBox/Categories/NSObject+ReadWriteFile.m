//
//  NSObject+ReadWriteFile.m
//  MergeBox
//
//  Created by Mayur Joshi on 18/08/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import "NSObject+ReadWriteFile.h"

#define KEY_CURRENT_FILE_NAME @"keyCurrentFileName"

@implementation NSObject (ReadWriteFile)

//get all the files from Documents Directory
-(NSArray *)fetchMergeFiles {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    return [[directoryContent reverseObjectEnumerator] allObjects]; //reversing the array just so that the latest one is always the first one on the list!
}


//get new file URL on which new merged video will be saved
- (NSURL* ) getNewMergeFilePathURL {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"merge%@.mov", [self getNewMergeFileName]]];
    
    NSURL *url = [NSURL fileURLWithPath:myPathDocs];
    
    return url;
}

- (NSURL*) getMergeFilePathURL : (NSString* ) fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSURL *url = [NSURL fileURLWithPath:myPathDocs];
    
    return url;
}

//private function to get the new file name by calculating the most recent file count
- (NSString* ) getNewMergeFileName {
    if(![USER_DEFAULTS objectForKey:KEY_CURRENT_FILE_NAME]) {
        [USER_DEFAULTS setObject:@"0000" forKey:KEY_CURRENT_FILE_NAME];
    }
    else {
        NSInteger currentFileCount = [[USER_DEFAULTS objectForKey:KEY_CURRENT_FILE_NAME] integerValue];
        currentFileCount++;
        [USER_DEFAULTS setObject:[NSString stringWithFormat:@"%04d", (int)currentFileCount] forKey:KEY_CURRENT_FILE_NAME];
    }
    [USER_DEFAULTS synchronize];
    return [NSString stringWithFormat:@"%@", [USER_DEFAULTS objectForKey:KEY_CURRENT_FILE_NAME]];
}

@end
