//
//  STTaskTableViewController.h
//  TheStartupTrail
//
//  Created by Philippe Chaintreuil on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "STViewController.h"

@class STEmployee;

@interface STTaskTableViewController : STViewController<UIAlertViewDelegate>
{
	NSMutableArray *_employees;
}

@property (retain, nonatomic, readonly) NSMutableArray* employees;

@property (retain, nonatomic) IBOutlet UILabel* employeeName1;
@property (retain, nonatomic) IBOutlet UILabel* employeeName2;
@property (retain, nonatomic) IBOutlet UILabel* employeeName3;
@property (retain, nonatomic) IBOutlet UILabel* employeeName4;
@property (retain, nonatomic) IBOutlet UIImageView* employeeClassImg1;
@property (retain, nonatomic) IBOutlet UIImageView* employeeClassImg2;
@property (retain, nonatomic) IBOutlet UIImageView* employeeClassImg3;
@property (retain, nonatomic) IBOutlet UIImageView* employeeClassImg4;
@property (retain, nonatomic) IBOutlet UIImageView* employeeTaskImg1;
@property (retain, nonatomic) IBOutlet UIImageView* employeeTaskImg2;
@property (retain, nonatomic) IBOutlet UIImageView* employeeTaskImg3;
@property (retain, nonatomic) IBOutlet UIImageView* employeeTaskImg4;

- (IBAction) assignTaskToEmployee:(id)sender;


- (void) addEmployee:(STEmployee*)emp;
- (void) updateEmployeeNameTag:(STEmployee*)emp;
- (void) doRealInit;
- (void) onStartTurn;

@end
