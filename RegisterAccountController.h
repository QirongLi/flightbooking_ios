//
//  RegisterAccountController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface RegisterAccountController : UIViewController

@property (nonatomic,strong) User *user;

@property (weak, nonatomic) IBOutlet UITextField *usernameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *firstnameText;
@property (weak, nonatomic) IBOutlet UITextField *lastnameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;

- (IBAction)register:(id)sender;

@end
