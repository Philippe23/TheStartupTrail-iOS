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
	unsigned _activeEmployee;
}

@property (retain, nonatomic, readonly) NSMutableArray* employees;

@property (retain, nonatomic) IBOutlet UILabel* employeeName1;
@property (retain, nonatomic) IBOutlet UILabel* employeeName2;
@property (retain, nonatomic) IBOutlet UILabel* employeeName3;
@property (retain, nonatomic) IBOutlet UILabel* employeeName4;
@property (retain, nonatomic) IBOutlet UIView* employeeNameplate1;
@property (retain, nonatomic) IBOutlet UIView* employeeNameplate2;
@property (retain, nonatomic) IBOutlet UIView* employeeNameplate3;
@property (retain, nonatomic) IBOutlet UIView* employeeNameplate4;
@property (retain, nonatomic) IBOutlet UIImageView* employeeTaskImg1;
@property (retain, nonatomic) IBOutlet UIImageView* employeeTaskImg2;
@property (retain, nonatomic) IBOutlet UIImageView* employeeTaskImg3;
@property (retain, nonatomic) IBOutlet UIImageView* employeeTaskImg4;
@property (retain, nonatomic) IBOutlet UIButton* employee1;
@property (retain, nonatomic) IBOutlet UIButton* employee2;
@property (retain, nonatomic) IBOutlet UIButton* employee3;
@property (retain, nonatomic) IBOutlet UIButton* employee4;

@property (retain, nonatomic) IBOutlet UIView *custCountOuter;
@property (retain, nonatomic) IBOutlet UIView *custCountInner;
@property (retain, nonatomic) IBOutlet UIImageView *custCountIcon;
@property (retain, nonatomic) IBOutlet UILabel *custCountLabel;
@property (retain, nonatomic) IBOutlet UIView *productCountOutter;
@property (retain, nonatomic) IBOutlet UIView *productCountInner;
@property (retain, nonatomic) IBOutlet UIImageView *productCountIcon;
@property (retain, nonatomic) IBOutlet UILabel *productCountLabel;
@property (retain, nonatomic) IBOutlet UILabel *moneyInBankLabel;
@property (retain, nonatomic) IBOutlet UILabel *cashFlowLabel;

- (IBAction) assignTaskToEmployee:(id)sender;
- (IBAction) endTurn:(id)sender;


- (void) addEmployee:(STEmployee*)emp;
- (void) updateEmployeeNameTag:(STEmployee*)emp;
- (void) doRealInit;
- (void) onStartTurn;

- (unsigned) getEmployeeNumFromButton:(UIButton*)button;

- (void) setCustomerCount:(unsigned)customerCount;
- (void) setProductCount:(unsigned)productCount;
- (void) setMoneyInBank:(int64_t)money;
- (void) setCashFlow:(int64_t)cash;

- (void) updateStatusBarData;

- (void) updateStatusBarLayout;
- (void) sizeBox:(UIView*)outerBox innerBox:(UIView*)innerbox icon:(UIImageView*)icon toFitLabel:(UILabel*)label;

@end
