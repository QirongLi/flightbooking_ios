//
//  AdminPageController.m
//  flightbooking
//
//  Created by Qirong on 4/24/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "AdminPageController.h"
#import "ManageFlightsController.h"
#import "ManageTicketsController.h"
#import "ManageUsersController.h"
#import "LoginController.h"

@interface AdminPageController ()

@end

@implementation AdminPageController

@synthesize contents;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Welcome";
    
    contents = [[NSMutableArray alloc]initWithObjects:@"Manage Flights",@"Manage users",nil];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = contents[indexPath.row];
    
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
    ManageFlightsController *manageFlights = [[ManageFlightsController alloc] initWithNibName:@"ManageFlightsController" bundle:nil];
    
    ManageUsersController *manageUsers = [[ManageUsersController alloc]initWithNibName:@"ManageUsersController" bundle:nil];
    
    ManageTicketsController *manageTickets =[[ManageTicketsController alloc]initWithNibName:@"ManageTicketsController" bundle:nil];
    
    if (indexPath.row==0) {
        manageFlights.title = [contents objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:manageFlights animated:YES];
        
        
    } else if (indexPath.row ==1){
        manageUsers.title = [contents objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:manageUsers animated:YES];
        
        //  [self.navigationController pushViewController:bookView animated:YES];
    }else if (indexPath.row == 2){
        manageTickets.title = [contents objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:manageTickets animated:YES];
    }else{
        NSLog(@"Error");
    }
}

@end
