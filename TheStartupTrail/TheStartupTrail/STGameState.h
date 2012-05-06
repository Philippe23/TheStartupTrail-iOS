//
//  STGameState.h
//  TheStartupTrail
//
//  Created by Philippe Chaintreuil on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STEmployee;

struct MonthlyNumbers
{
	unsigned turnNum;
	
	int64_t cashInBank;
	unsigned numCustomers;
	unsigned customersWon;
	unsigned customersLost;
	unsigned numFeatures;
	
	int64_t cashFlow;
	int64_t revenue;
	int64_t expenses;
	int64_t price;
	
	unsigned marketResearch;
	unsigned sales;
	unsigned features_work;
	unsigned maint_work;
	unsigned design_work;
	unsigned ux_research;
	
	unsigned user_stories;
	unsigned design_stories;
	unsigned design;
	unsigned complexity;
	unsigned maint;
};


@interface STGameState : NSObject
{
	NSMutableArray *_employees;
	struct MonthlyNumbers *_numbers;
	
	unsigned featuresPerDev;
	unsigned featuresPerUserStoryPerDev;
	unsigned maintPerDev;
	
	unsigned customersPerBiz;
	unsigned customersPerFeature;
	unsigned customersPerBizPerFeature;
	unsigned userStoriesPerBiz;
	
	unsigned usabilityPerDesigner;
	unsigned usabilityPerDesignStoryPerDev;
	unsigned designStoriesPerDesigner;
	
	unsigned costPerEmployee;
	unsigned pricePerFeature;
	
	unsigned customersLostDueToComplexity;
	float maintRate;
	unsigned customersLostDueToMaint;
}

@property (nonatomic, retain, readonly) NSMutableArray *employees;
@property (nonatomic, assign) unsigned turnNumber;

+ (STGameState*) sharedGameState;

- (void) generateTeam;

- (void) nextTurn;

- (void) updateNumbers;

- (struct MonthlyNumbers*) getThisMonthsNumbers;

@end
