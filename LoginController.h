//
//  LoginController.h
//  flightbooking
//
//  Created by Qirong on 4/24/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)login:(id)sender;
- (IBAction)signUp:(id)sender;

@end
