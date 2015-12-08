//
//  OneWayTripController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneWayTripController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *startCityText;
@property (weak, nonatomic) IBOutlet UITextField *destinationText;

@property (nonatomic,strong) NSMutableArray* flights;

- (IBAction)searchFlights:(id)sender;

@end
