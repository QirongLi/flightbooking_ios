//
//  Ticket.h
//  flightbooking
//
//  Created by Qirong on 4/24/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Flight.h"
#import "User.h"

@interface Ticket : NSObject

@property (nonatomic) int ticketId;

@property (nonatomic,strong) Flight *flight;

@property (nonatomic,strong) User *user;

@property (nonatomic) float price;

@property (nonatomic) NSString *payment;

@end
