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
@synthesize name;

- (id) initWithName:(NSString *)n type:(STEmployeeType)t andLevel:(unsigned)lvl
{
	self = [super init];
	if (self)
	{
		self.name = n;
		self->_type = t;
		self->_level = lvl;
	}
	
	return self;
}


@end
