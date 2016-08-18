//
//  NSObject+ReadWriteFile.h
//  MergeBox
//
//  Created by Mayur Joshi on 18/08/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ReadWriteFile)

-(NSArray *)listFileAtPath:(NSString *)path;
- (NSURL* ) getNewMergeFilePathURL;
@end
