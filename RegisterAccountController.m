//
//  RegisterAccountController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "RegisterAccountController.h"
#import "LoginController.h"

@interface RegisterAccountController ()

@end

@implementation RegisterAccountController

@synthesize user;

@synthesize usernameTxt,passwordText,firstnameText,lastnameText,emailText,phoneText,addressText;

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

- (IBAction)register:(id)sender {
    
    NSInteger success = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@&firstname=%@&lastname=%@&phone=%@&email=%@&address=%@",usernameTxt.text,passwordText.text,firstnameText.text,lastnameText.text,phoneText.text,emailText.text,addressText.text];
    
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/addUser"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.usernameTxt.text forKey:@"username"];
    [dict setObject:self.passwordText.text forKey:@"password"];
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
            NSString *error_msg = @"You have successfully registered!";
            [self alertStatus:error_msg :@"Register Successfully!" :0];
            
            LoginController *loginView = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
            UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:loginView];
            [nvc.view setBackgroundColor: [UIColor blackColor]];
            [self presentViewController:nvc animated:YES completion:nil];

            
            
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
