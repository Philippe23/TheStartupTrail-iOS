//
//  STGameState.m
//  TheStartupTrail
//
//  Created by Philippe Chaintreuil on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "STGameState.h"
#import "STEmployee.h"

STGameState *f_game_state = nil;

@implementation STGameState

@synthesize turnNumber;
@synthesize employees = _employees;



+ (STGameState*) sharedGameState
{
	if (!f_game_state)
	{
		f_game_state = [[STGameState alloc] init];
		assert(f_game_state);
		
		f_game_state->featuresPerDev = 1;
		f_game_state->featuresPerUserStoryPerDev = 2;
		f_game_state->maintPerDev = 10;
		
		f_game_state->customersPerBiz = 50;
		f_game_state->customersPerFeature = 50;
		f_game_state->customersPerBizPerFeature = 50;
		f_game_state->userStoriesPerBiz = 5;
		
		f_game_state->usabilityPerDesigner = 1;
		f_game_state->usabilityPerDesignStoryPerDev = 2;
		f_game_state->userStoriesPerBiz = 1;
		
		f_game_state->costPerEmployee = 8000;
		f_game_state->pricePerFeature = 5;
		f_game_state->customersLostDueToComplexity = 50;
		f_game_state->maintRate = 0.001f;
		f_game_state->customersLostDueToMaint = 50;
		
		f_game_state->_employees = [[NSMutableArray alloc] initWithCapacity:8];
		f_game_state->_numbers = malloc(sizeof(f_game_state->_numbers[0]));
		assert(f_game_state->_numbers);
		
		struct MonthlyNumbers *mn = &f_game_state->_numbers[0];
		mn->turnNum = 0;
		mn->cashInBank = 100000;
		mn->numCustomers = 0;
		mn->customersWon = 0;
		mn->customersLost = 0;
		mn->numFeatures = 0;
		mn->cashFlow = 0;
		mn->revenue = 0;
		mn->expenses = 0;
		mn->price = 0;
		mn->marketResearch = 0;
		mn->sales = 0;
		mn->features_work = 0;
		mn->maint_work = 0;
		mn->design_work = 0;
		mn->ux_research = 0;
		mn->user_stories = 0;
		mn->design_stories = 0;
		mn->design = 0;
		mn->complexity = 0;
		mn->maint = 0;
		
		[f_game_state nextTurn];
	}
	
	return f_game_state;
}

- (void) generateTeam
{
	
}

- (void) nextTurn
{
	unsigned i = self.turnNumber;
	self.turnNumber = i + 1;
	self->_numbers = realloc(
		self->_numbers, 
		sizeof(self->_numbers[0]) * (self.turnNumber+1));
	assert(self->_numbers);
	
	memcpy(
		&self->_numbers[i+1],
		&self->_numbers[i],
		sizeof(self->_numbers[0]) );
	
	self->_numbers[i+1].turnNum = self.turnNumber;
	if (self.turnNumber > 1)
		[self updateNumbers];
}

- (void) updateNumbers
{
	assert(self.turnNumber > 0);
	struct MonthlyNumbers *mn = [self getThisMonthsNumbers];
	struct MonthlyNumbers const *last_mn = (mn - 1);
		
	mn->customersWon  = last_mn->sales * self->customersPerBiz;
	mn->customersWon += last_mn->numFeatures * self->customersPerFeature;
	mn->customersWon += last_mn->sales * last_mn->numFeatures * self->customersPerBizPerFeature;
	
	mn->customersLost  = last_mn->complexity * self->customersLostDueToComplexity;
	mn->customersLost += last_mn->maint * self->customersLostDueToMaint;
	
	mn->numCustomers = last_mn->numCustomers - mn->customersLost +mn->customersWon;
	
	mn->user_stories  = last_mn->user_stories;
	mn->user_stories += last_mn->marketResearch * self->userStoriesPerBiz;
	unsigned storiesConverted = last_mn->features_work * self->featuresPerUserStoryPerDev;
	storiesConverted = MIN(storiesConverted, last_mn->user_stories);
	mn->user_stories -= storiesConverted;
	
	mn->numFeatures  = last_mn->numFeatures;
	mn->numFeatures += last_mn->features_work * self->featuresPerDev;
	mn->numFeatures += storiesConverted;

	
	mn->design_stories  = last_mn->design_stories;
	mn->design_stories += last_mn->ux_research * self->designStoriesPerDesigner;
	// :NOTE: Should remove converted tasks.
	
	mn->design  = last_mn->design;
	mn->design += last_mn->design_work * self->usabilityPerDesigner;
	unsigned t = last_mn->design_work * self->usabilityPerDesignStoryPerDev;
	// :BUG: This doesn't look right.
	mn->design += MIN(t, mn->design);
	
	if (mn->numFeatures > mn->design)
	{
		mn->complexity = mn->numFeatures - mn->design;
		mn->complexity = (unsigned)powf(mn->complexity, 1.2f);
	}
	else mn->complexity = 0;
	
	mn->maint = (unsigned)roundf(last_mn->numCustomers * self->maintRate);

/*	
	mn->marketResearch = 0;
	mn->sales = 0;
	mn->features_work = 0;
	mn->maint_work = 0;
	mn->design_work = 0;
	mn->ux_research = 0;
*/
	
	t = self.turnNumber + 1;
	if (mn->numFeatures >= t)
		mn->price = mn->numFeatures - t;
	else mn->price = 0;
	mn->price *= self->pricePerFeature;
	
	mn->expenses = self.employees.count * self->costPerEmployee;
	
	mn->revenue = mn->price * mn->numCustomers;
	
	mn->cashFlow = mn->revenue - mn->expenses;
	
	mn->cashInBank = last_mn->cashInBank + mn->cashFlow;
}

- (struct MonthlyNumbers*) getThisMonthsNumbers
{
	unsigned i = self.turnNumber;
	assert(i > 0);
	return &self->_numbers[i];
}

@end
