//
//  ManageUsersController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ManageUsersController : UITableViewController

@property (nonatomic,strong) NSMutableArray *users;
@property (nonatomic,strong) User *chosenUser;

@end
