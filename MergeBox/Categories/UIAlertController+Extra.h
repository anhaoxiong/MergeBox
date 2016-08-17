//
//  UIAlertController+Extra.h
//  TopDog
//
//  Created by Mayur Joshi on 22/07/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extra)

+ (void) showDefaultAlertOnView: (nonnull UIViewController*) viewController withTitle:(nullable NSString* ) titleText message:(nullable NSString* ) messageText;

+ (void) showDefaultAlertOnView: (nonnull UIViewController*) viewController withTitle:(nullable NSString* ) titleText message:(nullable NSString* ) messageText withDefaultAction: (void (^ __nullable)(UIAlertAction* _Nullable action))handler;

@end
