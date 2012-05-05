//
//  STEmployee.h
//  TheStartupTrail
//
//  Created by Philippe Chaintreuil on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _STEmployeeType
{
	STEmployeeType_Designer,
	STEmployeeType_Developer,
	STEmployeeType_Business,	
} STEmployeeType;

@interface STEmployee : NSObject
{
	STEmployeeType _type;	
	unsigned _level;
}

@property (assign, readonly) STEmployeeType employeeType;
@property (assign, readonly) unsigned level;
@property (retain) NSString *name;

- (id) initWithName:(NSString*)name type:(STEmployeeType)type andLevel:(unsigned)level;
- (id) initStarterWithType:(STEmployeeType)type;

@end
