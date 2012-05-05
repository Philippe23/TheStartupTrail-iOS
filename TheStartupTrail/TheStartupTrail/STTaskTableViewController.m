//
//  STTaskTableViewController.m
//  TheStartupTrail
//
//  Created by Philippe Chaintreuil on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "STTaskTableViewController.h"
#import "STEmployee.h"

@interface STTaskTableViewController ()

@end

@implementation STTaskTableViewController

@synthesize employees = _employees;
@synthesize employeeName1, employeeName2, employeeName3, employeeName4;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self->_employees = [[NSMutableArray alloc] initWithCapacity:8];
		
		// Generate Employees.
		STEmployee *emp = [[STEmployee alloc] initStarterWithType:STEmployeeType_Business];
		[self addEmployee:emp];
		[emp release];
		emp = [[STEmployee alloc] initStarterWithType:STEmployeeType_Designer];
		[self addEmployee:emp];
		[emp release];
		emp = [[STEmployee alloc] initStarterWithType:STEmployeeType_Developer];
		[self addEmployee:emp];
		[emp release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	for (STEmployee *e in self.employees)
		[self updateEmployeeNameTag:e];
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


#pragma mark - Employeemanagement

- (void) addEmployee:(STEmployee *)emp
{
	assert(emp);
	[self.employees addObject:emp];
	[self updateEmployeeNameTag:emp];
}

- (void) updateEmployeeNameTag:(STEmployee*)emp
{	
	int idx = [self.employees indexOfObject:emp];
	assert(idx >= 0);
	
	if (idx == 0)
		self.employeeName1.text = emp.name;
	else if (idx == 1)
		self.employeeName2.text = emp.name;
	else if (idx == 2)
		self.employeeName3.text = emp.name;
	else if (idx == 3)
		self.employeeName4.text = emp.name;
	else assert(0);
}

@end
