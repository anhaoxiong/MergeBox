//
//  UIAlertController+Extra.m
//  TopDog
//
//  Created by Mayur Joshi on 22/07/16.
//  Copyright © 2016 Mayur. All rights reserved.
//

#import "UIAlertController+Extra.h"

@implementation UIAlertController (Extra)

+ (void) showDefaultAlertOnView: (UIViewController*) viewController withTitle:(NSString* ) titleText message:(NSString* ) messageText {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:titleText
                                                                        message:messageText
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:nil];
    [controller addAction:alertAction];
    [viewController presentViewController:controller animated:YES completion:nil];
}

+ (void) showDefaultAlertOnView: (UIViewController*) viewController withTitle:(NSString* ) titleText message:(NSString* ) messageText withDefaultAction: (void (^ __nullable)(UIAlertAction *action))handler {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:titleText
                                                                        message:messageText
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:handler];
    [controller addAction:alertAction];
    [viewController presentViewController:controller animated:YES completion:nil];
}



@end
