//
//  TicketController.h
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"

@interface TicketController : UIViewController
{
    int ticket_id;
}

@property (nonatomic) int ticket_id;
@property (nonatomic) Ticket *ticket;
@property (weak, nonatomic) IBOutlet UILabel *ticketIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;

@end
