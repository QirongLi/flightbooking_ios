//
//  UserPageController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserPageController : UITableViewController
{
    int user_id;
}

@property (nonatomic,strong) NSMutableArray *contents;
@property (nonatomic) int user_id;

@end
