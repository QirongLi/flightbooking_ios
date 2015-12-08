//
//  OneWayTripController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "OneWayTripController.h"
#import "SearchResultController.h"
#import "LoginController.h"
#import "Flight.h"

@interface OneWayTripController ()

@end

@implementation OneWayTripController

@synthesize flights;

@synthesize startCityText,destinationText;

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


- (IBAction) textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}


- (IBAction)searchFlights:(id)sender {
    NSInteger success = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"startcity=%@&destination=%@",self.startCityText.text,self.destinationText.text];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/oneWayFlight"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.startCityText.text forKey:@"start_city"];
    [dict setObject:self.destinationText.text forKey:@"destination"];
    
    
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
        NSArray *jsonData = [NSJSONSerialization
                             JSONObjectWithData:urlData
                             options:NSJSONReadingMutableContainers
                             error:&error];
        
        success = [responseData intValue];
        NSLog(@"Success: %ld",(long)success);
        
        NSLog(@"%@",jsonData);
        
        flights=[[NSMutableArray alloc]init];
        for (int i =0; i<jsonData.count; i++) {
            Flight *flight = [[Flight alloc] init];
            flight.flightId = [[[jsonData objectAtIndex:i] valueForKey:@"flight_id"] intValue];
            flight.arrive_time = [[jsonData objectAtIndex:i] valueForKey:@"arrive_time"];
            flight.destination = [[jsonData objectAtIndex:i] valueForKey:@"destination"];
            flight.price = [[[jsonData objectAtIndex:i] valueForKey:@"price"] floatValue];
            flight.start_city = [[jsonData objectAtIndex:i] valueForKey:@"start_city"];
            flight.start_time = [[jsonData objectAtIndex:i] valueForKey:@"start_time"];
            flight.total_ticket = [[[jsonData objectAtIndex:i] valueForKey:@"total_ticket"] intValue];
            [flights addObject:flight];
        }
        
        SearchResultController *searchResult = [[SearchResultController alloc]initWithNibName:@"SearchResultController" bundle:nil];
        searchResult.title = @"Flights Available";
        searchResult.flightList = flights;
        [self.navigationController pushViewController:searchResult animated:YES];
        
        NSLog(@"count %d",flights.count);
        
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

@end
