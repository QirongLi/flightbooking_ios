//
//  MyTripsController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"

@interface MyTripsController : UITableViewController
{
    int user_id;
}

@property (nonatomic) int user_id;

@property (nonatomic,strong) NSMutableArray *ticketList;

@property (nonatomic) int chosenTicket;

@end
