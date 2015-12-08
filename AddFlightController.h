//
//  AddFlightController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFlightController : UIViewController
{
    NSMutableArray *flightList;
}

@property (strong,nonatomic) NSMutableArray *flightList;

@property (weak, nonatomic) IBOutlet UITextField *startCityText;
@property (weak, nonatomic) IBOutlet UITextField *destinationText;
@property (weak, nonatomic) IBOutlet UITextField *startTimeText;
@property (weak, nonatomic) IBOutlet UITextField *arriveTimeText;
@property (weak, nonatomic) IBOutlet UITextField *priceText;
@property (weak, nonatomic) IBOutlet UITextField *capacityText;


@end
