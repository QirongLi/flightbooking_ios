//
//  PaymentController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "PaymentController.h"
#import "UserRegisterController.h"
#import "Ticket.h"

@interface PaymentController ()

@end

@implementation PaymentController

@synthesize flight;
@synthesize flightIDLabel,flightLocationLabel,flightTimeLabel;
@synthesize firstnameText,lastnameText,phoneText,emailText,addressText;

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
    flightIDLabel.text = [NSString stringWithFormat:@"%d",flight.flightId];
    flightLocationLabel.text = [NSString stringWithFormat:@"Form %@ To %@",flight.start_city,flight.destination];
    flightTimeLabel.text = [NSString stringWithFormat:@"Price: %.2f",flight.price];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)bookFlight:(id)sender {
    
    NSInteger success = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"flightID=%d&firstname=%@&lastname=%@&phone=%@&email=%@&address=%@",[self.flightIDLabel.text intValue],self.firstnameText.text,self.lastnameText.text,self.phoneText.text,self.emailText.text,self.addressText.text];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/addTicket"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.flightIDLabel.text forKey:@"flight_id"];
    [dict setObject:self.firstnameText.text forKey:@"firstname"];
    [dict setObject:self.lastnameText.text forKey:@"lastname"];
    [dict setObject:self.emailText.text forKey:@"email"];
    [dict setObject:self.phoneText.text forKey:@"phone"];
    [dict setObject:self.addressText.text forKey:@"address"];
    
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
            NSString *error_msg = @"You have successfully bought the ticket!";
            [self alertStatus:error_msg :@"Purchase Successfully!" :0];
        } else if(success == 2){
            User *user = [[User alloc]init];
            user.firstname = firstnameText.text;
            user.lastname = lastnameText.text;
            user.email = emailText.text;
            user.phone = phoneText.text;
            user.address =addressText.text;
            
            UserRegisterController *userRegister = [[UserRegisterController alloc]initWithNibName:@"UserRegisterController" bundle:nil];
            userRegister.user = user;
            userRegister.flight_id = [flightIDLabel.text intValue];
            [self.navigationController pushViewController:userRegister animated:YES];
        }else{
            
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
@end
