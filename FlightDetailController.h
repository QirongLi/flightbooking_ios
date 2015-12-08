//
//  FlightDetailController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flight.h"

@interface FlightDetailController : UIViewController
{
    Flight *flight;
    NSMutableArray *flightList;
}

@property (nonatomic,strong) Flight *flight;
@property (nonatomic,strong) NSMutableArray *flightList;

@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *startCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arriveTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTicketLabel;

- (IBAction)deleteFlight:(id)sender;

@end
