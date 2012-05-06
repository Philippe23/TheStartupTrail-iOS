//
//  STEmployee.m
//  TheStartupTrail
//
//  Created by Philippe Chaintreuil on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "STEmployee.h"


@implementation STEmployee

@synthesize employeeType = _type;
@synthesize level = _level;
@synthesize name, task;

- (id) initWithName:(NSString *)n type:(STEmployeeType)t andLevel:(unsigned)lvl
{
	self = [super init];
	if (self)
	{
		self.name = n;
		self->_type = t;
		self->_level = lvl;
		self.task = STEmployeeTask_None;
	}
	
	return self;
}

- (id) initStarterWithType:(STEmployeeType)t
{
	NSString *names[] = {
			@"David",
			@"Matt",
			@"Mark",
			@"Ryan",
			@"Steve",
			@"Jim",
			@"Han"
		};
	
	unsigned n = random() % (sizeof(names)/sizeof(names[0]));
	
	return [self initWithName:names[n] type:t andLevel:1];
}

@end
