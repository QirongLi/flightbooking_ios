//
//  UserRegisterController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserRegisterController : UIViewController
{
    User *user;
    int flight_id;
}

@property (nonatomic,strong) User *user;
@property (nonatomic) int flight_id;

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

- (IBAction)fnishButtion:(id)sender;
@end
