//
//  AddUserController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddUserController : UIViewController

@property (nonatomic,strong) NSMutableArray *userList;

@property (weak, nonatomic) IBOutlet UITextField *userIdText;
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *firstnameText;
@property (weak, nonatomic) IBOutlet UITextField *lastnameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;


@end
