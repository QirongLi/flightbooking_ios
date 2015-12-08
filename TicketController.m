//
//  TicketController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "TicketController.h"
#import "LoginController.h"
#import "Ticket.h"

@interface TicketController ()

@end

@implementation TicketController

@synthesize ticket_id,ticket;

@synthesize ticketIdLabel,flightIdLabel,locationLabel,timeLabel,priceLabel,paymentLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *post =[[NSString alloc] initWithFormat:@"ticket_id=%d",self.ticket_id];
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/findTicket"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[NSString stringWithFormat:@"%d",self.ticket_id] forKey:@"ticket_id"];
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:json];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %ld", (long)[response statusCode]);
    NSLog(@"%d", ticket_id);
    
    if ([response statusCode] >= 200 && [response statusCode] < 300)
    {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        NSError *error = nil;
        NSArray *jsonData = [NSJSONSerialization
                             JSONObjectWithData:urlData
                             options:NSJSONReadingMutableContainers
                             error:&error];
        NSLog(@"%@",jsonData);
        
        self.ticket.payment =[jsonData valueForKey:@"payment"];
        self.ticket.price = [[jsonData valueForKey:@"price"] floatValue];
        self.ticket.flight.flightId =[[jsonData valueForKey:@"flight_id"] intValue];
        self.ticket.flight.start_city = [jsonData valueForKey:@"start_city"];
        self.ticket.flight.start_time = [jsonData valueForKey:@"start_time"];
        self.ticket.flight.destination = [jsonData valueForKey:@"destination"];
        self.ticket.flight.arrive_time = [jsonData valueForKey:@"arrive_time"];
        
    }


    ticketIdLabel.text = [NSString stringWithFormat:@"%d",self.ticket_id];
    flightIdLabel.text = [NSString stringWithFormat:@"%d",self.ticket.flight.flightId];
    locationLabel.text = [NSString stringWithFormat:@"Travel from %@ to %@",self.ticket.flight.start_city,ticket.flight.destination];
    timeLabel.text = [NSString stringWithFormat:@"Time: %@ - %@",self.ticket.flight.start_time,ticket.flight.arrive_time];
    priceLabel.text = [NSString stringWithFormat:@"%.2f",self.ticket.price ];
    paymentLabel.text = self.ticket.payment;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)logout:(UIBarButtonItem *)sender{
    LoginController *loginView = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:loginView];
    [nvc.view setBackgroundColor: [UIColor blackColor]];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

@end
