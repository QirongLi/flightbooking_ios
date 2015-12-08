//
//  PaymentController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flight.h"
#import "User.h"

@interface PaymentController : UIViewController
{
    Flight *flight;
}

@property (nonatomic,strong) Flight *flight;

@property (weak, nonatomic) IBOutlet UILabel *flightIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightTimeLabel;
@property (weak, nonatomic) IBOutlet UITextField *firstnameText;
@property (weak, nonatomic) IBOutlet UITextField *lastnameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;

- (IBAction)bookFlight:(id)sender;


@end
