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

typedef enum _STEmployeeTask
{
	STEmployeeTask_None,

	STEmployeeTask_UX_Design,
	STEmployeeTask_Design,
	STEmployeeTask_Maint,
	STEmployeeTask_NewDev,
	STEmployeeTask_MarketResearch,
	STEmployeeTask_Sales,
} STEmployeeTask;

@interface STEmployee : NSObject
{
	STEmployeeType _type;	
	unsigned _level;
}

@property (assign, readonly) STEmployeeType employeeType;
@property (assign, readonly) unsigned level;
@property (retain) NSString *name;
@property (assign) STEmployeeTask task;

- (id) initWithName:(NSString*)name type:(STEmployeeType)type andLevel:(unsigned)level;
- (id) initStarterWithType:(STEmployeeType)type;

@end
