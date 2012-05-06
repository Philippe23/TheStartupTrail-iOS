//
//  STTaskTableViewController.m
//  TheStartupTrail
//
//  Created by Philippe Chaintreuil on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "STTaskTableViewController.h"
#import "STEmployee.h"
#import "STGameState.h"

@interface STTaskTableViewController ()

@end

@implementation STTaskTableViewController

@synthesize employeeName1, employeeName2, employeeName3, employeeName4;
@synthesize employeeNameplate1, employeeNameplate2, employeeNameplate3, employeeNameplate4;
@synthesize employeeTaskImg1, employeeTaskImg2, employeeTaskImg3, employeeTaskImg4;
@synthesize employee1, employee2, employee3, employee4;
@synthesize custCountIcon, custCountInner, custCountOuter, custCountLabel;
@synthesize productCountIcon, productCountInner, productCountOutter, productCountLabel;
@synthesize moneyInBankLabel, cashFlowLabel;
@synthesize turnLabel;


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
	
	[self updateStatusBarData];
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

- (IBAction) endTurn:(id)sender
{
	static unsigned x = 0;
	
	x += 23;
	
	[self setCustomerCount:x];
}


#pragma mark - Employeemanagement

- (NSMutableArray*) employees
{
	return [STGameState sharedGameState].employees;
}

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
	
	NSString *imgName = nil;
	switch (emp.employeeType)
	{
		case STEmployeeType_Business:
			imgName = @"biz_man";
			break;
		
		case STEmployeeType_Designer:
			imgName = @"designer";
			break;
		
		case STEmployeeType_Developer:
			imgName = @"developer";
			break;
	}
	assert(imgName);
	UIImage *img = [UIImage imageNamed:imgName];
	assert(img);
	
	
	if (idx == 0)
	{
		self.employeeName1.text = emp.name;
		self.employeeNameplate1.hidden = NO;
		[self.employee1 setImage:img forState:UIControlStateNormal];
	}
	else if (idx == 1)
	{
		self.employeeName2.text = emp.name;
		self.employeeNameplate2.hidden = NO;
		[self.employee2 setImage:img forState:UIControlStateNormal];
	}
	else if (idx == 2)
	{
		self.employeeName3.text = emp.name;
		self.employeeNameplate3.hidden = NO;
		[self.employee3 setImage:img forState:UIControlStateNormal];
	}
	else if (idx == 3)
	{
		self.employeeName4.text = emp.name;
		self.employeeNameplate4.hidden = NO;
		[self.employee4 setImage:img forState:UIControlStateNormal];
	}
	else assert(0);
}

- (void) doRealInit
{
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

- (void) setCustomerCount:(unsigned int)customerCount
{
	NSNumber *num = [[NSNumber alloc] initWithUnsignedInt:customerCount];
	NSString *str = [NSNumberFormatter localizedStringFromNumber:num numberStyle:NSNumberFormatterDecimalStyle];
	[num release], num = nil;
	
	self.custCountLabel.text = str;
	
	[self updateStatusBarLayout];
}

- (void) setProductCount:(unsigned int)count
{
	NSNumber *num = [[NSNumber alloc] initWithUnsignedInt:count];
	NSString *str = [NSNumberFormatter localizedStringFromNumber:num numberStyle:NSNumberFormatterDecimalStyle];
	[num release], num = nil;
	
	self.productCountLabel.text = str;
	
	[self updateStatusBarLayout];
}

- (void) setMoneyInBank:(int64_t)money
{
	NSNumber *num = [[NSNumber alloc] initWithDouble:(double)money];
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	formatter.numberStyle = NSNumberFormatterCurrencyStyle;
	formatter.maximumFractionDigits = 0;
	NSString *str = [formatter stringFromNumber:num];
	[formatter release], formatter = nil;
	[num release], num = nil;
	
	self.moneyInBankLabel.text = str;
	
	[self updateStatusBarLayout];
}

- (void) setCashFlow:(int64_t)cash
{
	NSNumber *num = [[NSNumber alloc] initWithDouble:(double)cash];
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	formatter.numberStyle = NSNumberFormatterCurrencyStyle;
	formatter.maximumFractionDigits = 0;
	NSString *str = [formatter stringFromNumber:num];
	[formatter release], formatter = nil;
	[num release], num = nil;
	
	if (cash < 0.0f)
	{
		self.cashFlowLabel.textColor = [UIColor redColor];
		str = [str stringByAppendingFormat:@"(%@)", str];
	}
	else
	{
		self.cashFlowLabel.textColor = [UIColor blackColor];
		str = [@"+" stringByAppendingString:str];
	}
	
	self.cashFlowLabel.text = str;
	
	[self updateStatusBarLayout];
}


- (void) updateStatusBarData
{
	STGameState *state = [STGameState sharedGameState];
	struct MonthlyNumbers *mn = [state getThisMonthsNumbers];
	
	self.turnLabel.text = [NSString stringWithFormat:@"%u", mn->turnNum];
	
	[self setCustomerCount:mn->numCustomers];
	[self setProductCount:mn->numFeatures];
	[self setMoneyInBank:mn->cashInBank];
	[self setCashFlow:mn->cashFlow];
}

- (void) updateStatusBarLayout
{
	[self sizeBox:self.custCountOuter
		 innerBox:self.custCountInner
			 icon:self.custCountIcon
	   toFitLabel:self.custCountLabel];

	[self sizeBox:self.productCountOutter
		 innerBox:self.productCountInner
			 icon:self.productCountIcon
	   toFitLabel:self.productCountLabel];
	   
	   

}

- (void) sizeBox:(UIView *)outerBox 
		innerBox:(UIView *)innerbox 
			icon:(UIImageView *)icon
	  toFitLabel:(UILabel *)label
{
	CGSize const labelSize = [label.text sizeWithFont:label.font];
	CGFloat width = labelSize.width;
	
	width += 2.0f * 3;
	width += icon.bounds.size.width;
	
	CGRect fr = innerbox.frame;
	fr.size.width = width;
	innerbox.frame = fr;
	
	fr = icon.frame;
	fr.origin = CGPointMake(2.0f, 2.0f);
	icon.frame = fr;
	width = fr.size.width;
	
	fr = label.frame;
	fr.origin.x  = 2.0f * 2;
	fr.origin.x += width;
	fr.origin.y  = 2.0f;
	fr.size.width = labelSize.width;
	label.frame = fr;
	
	fr = outerBox.frame;
	fr.size.width  = innerbox.bounds.size.width;
	fr.size.width += 2.0f * 2;
	outerBox.frame = fr;

	// :HACK: There's some reason I need to do this all
	//        twice every once in a while.
	static int size_hack_first = 0;
	if (size_hack_first == 0)
	{
		size_hack_first = 1;
		[self sizeBox:outerBox innerBox:innerbox icon:icon toFitLabel:label];
	}
	else size_hack_first = 0;
}

@end
