//
//  FlightDetailController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "FlightDetailController.h"
#import "LoginController.h"

@interface FlightDetailController ()

@end

@implementation FlightDetailController

@synthesize flight,flightList;
@synthesize idLabel,startCityLabel,destinationLabel,startTimeLabel,arriveTimeLabel,priceLabel,totalTicketLabel;

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
    idLabel.text = [NSString stringWithFormat:@"%d",flight.flightId];
    
    startCityLabel.text = flight.start_city;
    destinationLabel.text = flight.destination;
    startTimeLabel.text = flight.start_time;
    arriveTimeLabel.text = flight.arrive_time;
    priceLabel.text = [NSString stringWithFormat:@"%.2f",flight.price];
    totalTicketLabel.text = [NSString stringWithFormat:@"%d",flight.total_ticket];
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

- (IBAction)deleteFlight:(id)sender {
    NSInteger success = 0;
            NSString *post =[[NSString alloc] initWithFormat:@"%d",flight.flightId];
            
            NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/deleteFlight"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:post forKey:@"flight_id"];
            
            NSData *json = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:json];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                success = [responseData intValue];
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 1)
                {
                    NSString *error_msg = @"You have successfully delete the recourd in database.";
                    [self alertStatus:error_msg :@"Successfull Deletion!" :0];
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Deletion Failed!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
            }
    

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
