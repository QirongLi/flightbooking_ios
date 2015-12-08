//
//  UserRegisterController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "UserRegisterController.h"

@interface UserRegisterController ()

@end

@implementation UserRegisterController

@synthesize flight_id,user;

@synthesize usernameText,passwordText;

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
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)fnishButtion:(id)sender {
    
    NSInteger success = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"flightID=%d&username=%@&password=%@&firstname=%@&lastname=%@&phone=%@&email=%@&address=%@",flight_id,self.usernameText.text,self.passwordText.text,user.firstname,user.lastname,user.phone,user.email,user.address];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/addUser&Ticket"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[NSString stringWithFormat:@"%d",flight_id ] forKey:@"flight_id"];
    [dict setObject:self.usernameText.text forKey:@"username"];
    [dict setObject:self.passwordText.text forKey:@"password"];
    [dict setObject:user.firstname forKey:@"firstname"];
    [dict setObject:user.lastname forKey:@"lastname"];
    [dict setObject:user.email forKey:@"email"];
    [dict setObject:user.phone forKey:@"phone"];
    [dict setObject:user.address forKey:@"address"];
    
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
        } else{
            
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
