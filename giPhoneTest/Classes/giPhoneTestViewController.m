//
//  giPhoneTestViewController.m
//  giPhoneTest
//
//  Created by Gilad Novik on 10-12-07.
//  Copyright 2010 Summit-Tech. All rights reserved.
//

#import "giPhoneTestViewController.h"
#import "NSString+URLEncoding.h"
#import "UIDownloadImageView.h"
#import "UIImage+Mask.h"

@implementation giPhoneTestViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString* url=@"http://upload.wikimedia.org/wikipedia/commons/6/63/Wikipedia-logo.png";
	NSLog(@"Encoded: %@",[url URLEncodedString]);
	NSLog(@"Decoded: %@",[[url URLEncodedString] URLDecodedString]);
	NSAssert([url isEqualToString:[[url URLEncodedString] URLDecodedString]],@"Encode/Decode Failed");

	UIImageView* mask=[[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"image.jpg"] imageWithMask:[UIImage imageNamed:@"mask.jpg"]]] autorelease];
	mask.center=self.view.center;
	[self.view addSubview:mask];
	
	UIDownloadImageViewWithActivity* image=[[[UIDownloadImageViewWithActivity alloc] initWithFrame:CGRectMake(50, 50, 100, 100)] autorelease];
	[self.view addSubview:image];
	[image downloadWithURL:[NSURL URLWithString:url]];
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
