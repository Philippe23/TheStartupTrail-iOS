//
//  STTaskTableViewController.m
//  TheStartupTrail
//
//  Created by Philippe Chaintreuil on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "STTaskTableViewController.h"

@interface STTaskTableViewController ()

@end

@implementation STTaskTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	switch (interfaceOrientation)
	{
		case UIInterfaceOrientationPortrait:
		case UIInterfaceOrientationPortraitUpsideDown:
			return NO;
		
		case UIInterfaceOrientationLandscapeLeft:
		case UIInterfaceOrientationLandscapeRight:
			return YES;
	}
}

#pragma mark - Alert View Delegate Methods

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.cancelButtonIndex == buttonIndex)
	{
	}
	else if (alertView.firstOtherButtonIndex == buttonIndex)
	{
		// Design
	}
	else if (alertView.firstOtherButtonIndex+1 == buttonIndex)
	{
		// Marketing
	}
	else if (alertView.firstOtherButtonIndex+2 == buttonIndex)
	{
		// Developer
	}
}

#pragma mark - actions

- (IBAction) assignTaskToEmployee:(id)sender
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Assign task" delegate:self cancelButtonTitle:@"None" otherButtonTitles:@"Design", @"Marketing", @"Develop", nil];
	
	[alert show];
}


@end
