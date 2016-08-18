//
//  NSObject+Transform.h
//  MergeBox
//
//  Created by Mayur Joshi on 18/08/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Transform)

- (BOOL) checkForPortrait:(CGAffineTransform) transform;

@end
