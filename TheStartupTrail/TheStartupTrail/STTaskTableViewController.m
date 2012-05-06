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
@synthesize employeeNameplate1, employeeNameplate2, employeeNameplate3, employeeNameplate4;
@synthesize employeeTaskImg1, employeeTaskImg2, employeeTaskImg3, employeeTaskImg4;
@synthesize employee1, employee2, employee3, employee4;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		[self doRealInit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	[self doRealInit];
	
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
	UIImageView *img = nil;
	
	if (self->_activeEmployee == 0)
		img = self.employeeTaskImg1;
	else if (self->_activeEmployee == 1)
		img = self.employeeTaskImg2;
	else if (self->_activeEmployee == 2)
		img = self.employeeTaskImg3;
	else if (self->_activeEmployee == 4)
		img = self.employeeTaskImg4;
	else assert(0);
	
	STEmployee *emp = [self.employees objectAtIndex:self->_activeEmployee];

	if (alertView.cancelButtonIndex == buttonIndex)
	{
		img.hidden = YES;
		return;
	}
	
	NSString *imgName = nil;
	switch (emp.employeeType)
	{
		case STEmployeeType_Business:
			if (buttonIndex == alertView.firstOtherButtonIndex)
				imgName = @"MarkRes";
			else imgName = @"salesMark";
			break;
		
		case STEmployeeType_Designer:
			if (buttonIndex == alertView.firstOtherButtonIndex)
				imgName = @"uxresearch";
			else imgName = @"design";
			break;
		
		case STEmployeeType_Developer:
			if (buttonIndex == alertView.firstOtherButtonIndex)
				imgName = @"maint";
			else imgName = @"devel";
			break;
	}
	assert(imgName);
	
	img.image = [UIImage imageNamed:imgName];
	img.hidden = NO;
}

#pragma mark - actions

- (IBAction) assignTaskToEmployee:(id)sender
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Assign task" delegate:self cancelButtonTitle:@"None" otherButtonTitles:nil];
	
	unsigned empNo = [self getEmployeeNumFromButton:sender];
	STEmployee *emp = [self.employees objectAtIndex:empNo];
	assert(emp);
	
	switch (emp.employeeType) 
	{
		case STEmployeeType_Business:
			[alert addButtonWithTitle:@"Market Research"];
			[alert addButtonWithTitle:@"Sales & Marketing"];
			break;
		
		case STEmployeeType_Designer:
			[alert addButtonWithTitle:@"UX Research"];
			[alert addButtonWithTitle:@"Design"];
			break;
		
		case STEmployeeType_Developer:
			[alert addButtonWithTitle:@"Maintenance"];
			[alert addButtonWithTitle:@"New Features"];
			break;
	}
	
	self->_activeEmployee = empNo;
	
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
	{
		self.employeeName1.text = emp.name;
		self.employeeNameplate1.hidden = NO;
	}
	else if (idx == 1)
	{
		self.employeeName2.text = emp.name;
		self.employeeNameplate2.hidden = NO;
	}
	else if (idx == 2)
	{
		self.employeeName3.text = emp.name;
		self.employeeNameplate3.hidden = NO;
	}
	else if (idx == 3)
	{
		self.employeeName4.text = emp.name;
		self.employeeNameplate4.hidden = NO;
	}
	else assert(0);
}

- (void) doRealInit
{
	if (self->_employees)
		return;
	
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

- (void) onStartTurn
{
	self.employeeTaskImg1.hidden = YES;
	self.employeeTaskImg2.hidden = YES;
	self.employeeTaskImg3.hidden = YES;
	self.employeeTaskImg4.hidden = YES;
}

- (unsigned) getEmployeeNumFromButton:(UIButton*)button
{
	if (button == self.employee1)
		return 0;
	else if (button == self.employee2)
		return 1;
	else if (button == self.employee3)
		return 2;
	else if (button == self.employee4)
		return 3;
	
	assert(0);
	return 999;
}

@end
