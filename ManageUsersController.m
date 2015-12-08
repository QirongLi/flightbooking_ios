//
//  ManageUsersController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "ManageUsersController.h"
#import "AddUserController.h"
#import "UserDetailController.h"
#import "User.h"

@interface ManageUsersController ()

@end

@implementation ManageUsersController

@synthesize chosenUser,users;

- (void)viewDidLoad
{
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/allUsers"];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    //     [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
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
        NSLog(@"%@",jsonData);
        
        users=[[NSMutableArray alloc]init];
        for (int i =0; i<jsonData.count; i++) {
            User  *user = [[User alloc] init];
            user.userId = [[[jsonData objectAtIndex:i] valueForKey:@"user_id"] intValue];
            user.username = [[jsonData objectAtIndex:i] valueForKey:@"username"];
            user.firstname= [[jsonData objectAtIndex:i] valueForKey:@"firstname"];
            user.lastname = [[jsonData objectAtIndex:i] valueForKey:@"lastname"];
            user.phone = [[jsonData objectAtIndex:i] valueForKey:@"phone"];
            user.email = [[jsonData objectAtIndex:i] valueForKey:@"email"];
            user.address = [[jsonData objectAtIndex:i] valueForKey:@"address"];
            [users addObject:user];
        }
        
    }
    
    NSLog(@"count %d",users.count);
   
 
    [super viewDidLoad];
    
    self.title = @"All Users";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(onAddClicked:)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onAddClicked:(UIBarButtonItem *)sender{
    AddUserController *addView = [[AddUserController alloc]initWithNibName:@"AddUserController" bundle:nil];
    addView.userList = users;
    [self.navigationController pushViewController:addView animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [users count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    User  *user = users[indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"User ID: %d",user.userId ];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    UserDetailController *userDetail = [[UserDetailController alloc] initWithNibName:@"UserDetailController" bundle:nil];
    chosenUser = [users objectAtIndex:indexPath.row];
    userDetail.userList = users;
    userDetail.user = chosenUser;
    // Push the view controller.
    [self.navigationController pushViewController:userDetail animated:YES];}


@end
