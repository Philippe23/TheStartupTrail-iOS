//
//  STSponsorHackViewControllerViewController.m
//  TheStartupTrail
//
//  Created by Philippe Chaintreuil on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "STSponsorHackViewControllerViewController.h"

@interface STSponsorHackViewControllerViewController ()

@end

@implementation STSponsorHackViewControllerViewController

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

- (IBAction) popOffNav:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
