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

//get all the files at the given path
-(NSArray *)listFileAtPath:(NSString *)path
{
    //-----> LIST ALL FILES <-----//
    NSLog(@"LISTING ALL FILES FOUND");
    
    int count;
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
    }
    return directoryContent;
}


//get new file URL on which new merged video will be saved
- (NSURL* ) getNewMergeFilePathURL {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"merge%@.mov", [self getNewMergeFileName]]];
    
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
