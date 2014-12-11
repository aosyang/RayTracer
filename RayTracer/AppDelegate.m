//
//  AppDelegate.m
//  RayTracer
//
//  Created by Ao Shiyang on 12/10/14.
//  Copyright (c) 2014 Family. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate()
@property (nonatomic,strong) IBOutlet MainViewController* mainViewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    // 1. Create main view controller
    self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    // 2. Add the view controller to the window's content view
    [self.window.contentView addSubview:self.mainViewController.view];
    self.mainViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

@end
