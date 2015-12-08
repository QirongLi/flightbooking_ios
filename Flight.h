//
//  Flight.h
//  flightbooking
//
//  Created by Qirong on 4/24/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flight : NSObject

@property (nonatomic) int flightId;

@property (nonatomic,strong) NSString *start_city;

@property (nonatomic,strong) NSString *destination;

@property (nonatomic,strong) NSString *start_time;

@property (nonatomic,strong) NSString *arrive_time;

@property (nonatomic) float price;

@property (nonatomic) int total_ticket;

@end
