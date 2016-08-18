//
//  NSObject+Transform.m
//  MergeBox
//
//  Created by Mayur Joshi on 18/08/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import "NSObject+Transform.h"

@implementation NSObject (Transform)

- (BOOL) checkForPortrait:(CGAffineTransform) transform {
    BOOL assetPortrait  = NO;
    if(transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0) {
        //is portrait
        assetPortrait = YES;
    }
    else if(transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0) {
        //is portrait
        assetPortrait = YES;
    }
    else if(transform.a == 1.0 && transform.b == 0 && transform.c == 0 && transform.d == 1.0) {
        //is landscape
    }
    else if(transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0) {
        //is landscape
    }
    
    return assetPortrait;
}
@end
