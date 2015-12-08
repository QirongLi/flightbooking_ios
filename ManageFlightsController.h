//
//  ManageFlightsController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flight.h"

@interface ManageFlightsController : UITableViewController

@property (nonatomic,strong) NSMutableArray *flights;
@property (nonatomic,strong) Flight *chosenFlight;
@end
