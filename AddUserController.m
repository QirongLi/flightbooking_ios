//
//  AddUserController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "AddUserController.h"

@interface AddUserController ()

@end

@implementation AddUserController

@synthesize userList;

@synthesize userIdText,usernameText,firstnameText,lastnameText,phoneText,emailText,addressText;

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
    self.title = @"New User";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(onAddButton:)];
}

- (IBAction) textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

-(void)onAddButton:(UIBarButtonItem *)sender{
    
    NSInteger success = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@&firstname=%@&lastname=%@&phone=%@&email=%@&address=%@",self.usernameText.text,self.userIdText.text,self.firstnameText.text,self.lastnameText.text,self.phoneText.text,self.emailText.text,self.addressText.text];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/addUser"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.usernameText.text forKey:@"username"];
    [dict setObject:self.userIdText.text forKey:@"password"];
    [dict setObject:self.firstnameText.text forKey:@"firstname"];
    [dict setObject:self.lastnameText.text forKey:@"lastname"];
    [dict setObject:self.phoneText.text forKey:@"phone"];
    [dict setObject:self.emailText.text forKey:@"email"];
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
            NSString *error_msg = @"You have successfully add the user in database.";
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
