//
//  AddFlightController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "AddFlightController.h"
#import "Flight.h"

@interface AddFlightController ()

@end

@implementation AddFlightController

@synthesize flightList;

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
    self.title = @"New Flight";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(onAddButton:)];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction) textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

-(void)onAddButton:(UIBarButtonItem *)sender{
    
    NSInteger success = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"startcity=%@&destination=%@&starttime=%@&arrivetime=%@&price=%@&capacity=%@",self.startCityText.text,self.destinationText.text,self.startTimeText.text,self.arriveTimeText.text,self.priceText.text,self.capacityText.text];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/addFlight"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.startCityText.text forKey:@"start_city"];
    [dict setObject:self.destinationText.text forKey:@"destination"];
    [dict setObject:self.startTimeText.text forKey:@"start_time"];
    [dict setObject:self.arriveTimeText.text forKey:@"arrive_time"];
    [dict setObject:self.priceText.text forKey:@"price"];
    [dict setObject:self.capacityText.text forKey:@"total_ticket"];
    
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
            NSString *error_msg = @"You have successfully add the flight in database.";
            [self alertStatus:error_msg :@"Add Successfully!" :0];
        } else {
            
            NSString *error_msg = (NSString *) jsonData[@"error_message"];
            [self alertStatus:error_msg :@"Action Failed!" :0];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}



@end
