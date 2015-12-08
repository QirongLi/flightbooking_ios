//
//  LoginController.m
//  flightbooking
//
//  Created by Qirong on 4/24/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "LoginController.h"
#import "User.h"
#import "AdminPageController.h"
#import "UserPageController.h"
#import "RegisterAccountController.h"


@interface LoginController ()

@end

@implementation LoginController

@synthesize username,password;

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

- (IBAction) textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    NSInteger success = 0;
    @try {
        
        if([[self.username text] isEqualToString:@""] || [[self.password text] isEqualToString:@""] ) {
            
            [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
            
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@",[self.username text],[self.password text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/login"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:[self.username text] forKey:@"username"];
            [dict setObject:[self.password text] forKey:@"password"];
  
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

                NSDictionary *roleDict = [jsonData valueForKey:@"role"];
                success = [[roleDict valueForKey:@"id"] intValue];
                NSLog(@"%@",jsonData);
                
                if(success == 1)
                {
                   AdminPageController *adminWorkArea = [[AdminPageController alloc]initWithNibName:@"AdminPageController" bundle:nil];
                    UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:adminWorkArea];
                    [nvc.view setBackgroundColor: [UIColor blackColor]];
                    [self presentViewController:nvc animated:YES completion:nil];
                } else if(success == 2){
                    UserPageController *userWorkArea = [[UserPageController alloc]initWithNibName:@"UserPageController" bundle:nil];
                    userWorkArea.user_id = [[jsonData valueForKeyPath:@"user_id"] intValue];

                    UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:userWorkArea];
                    [nvc.view setBackgroundColor: [UIColor blackColor]];
                    [self presentViewController:nvc animated:YES completion:nil];
                }else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Sign in Failed!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
}

- (IBAction)signUp:(id)sender {
    
    RegisterAccountController *registerView = [[RegisterAccountController alloc]initWithNibName:@"RegisterAccountController" bundle:nil];
    
    UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:registerView];
    [nvc.view setBackgroundColor: [UIColor blackColor]];
    [self presentViewController:nvc animated:YES completion:nil];
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

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}
@end
