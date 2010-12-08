//
//  giPhoneTestAppDelegate.h
//  giPhoneTest
//
//  Created by Gilad Novik on 10-12-07.
//  Copyright 2010 Summit-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class giPhoneTestViewController;

@interface giPhoneTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    giPhoneTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet giPhoneTestViewController *viewController;

@end

