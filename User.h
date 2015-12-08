//
//  User.h
//  flightbooking
//
//  Created by Qirong on 4/24/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) int userId;

@property (nonatomic,strong) NSString* username;

@property (nonatomic,strong) NSString* password;

@property (nonatomic,strong) NSString* firstname;

@property (nonatomic,strong) NSString* lastname;

@property (nonatomic,strong) NSString* phone;

@property (nonatomic,strong) NSString* email;

@property (nonatomic,strong) NSString* address;

@end
