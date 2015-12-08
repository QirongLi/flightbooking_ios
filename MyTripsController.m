//
//  MyTripsController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "MyTripsController.h"
#import "Ticket.h"
#import "User.h"
#import "TicketController.h"
#import "LoginController.h"

@interface MyTripsController ()

@end

@implementation MyTripsController
@synthesize user_id,chosenTicket,ticketList;

- (void)viewDidLoad
{
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%d",self.user_id];
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/allTickets"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[NSString stringWithFormat:@"%d",self.user_id] forKey:@"user_id"];
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:json];
    
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
        
        ticketList=[[NSMutableArray alloc]init];

        
        for (int i =0; i<jsonData.count; i++) {
            chosenTicket = [jsonData[i] intValue];
//            Ticket *ticket = [[Ticket alloc]init];
//            ticket.ticketId = [[[jsonData objectAtIndex:i] valueForKey:@"ticket_id" ] intValue];
//            ticket.payment =[[jsonData objectAtIndex:i]valueForKey:@"payment"];
//            ticket.price = [[[jsonData objectAtIndex:i] valueForKey:@"price"] floatValue];
//            User *user = [[jsonData objectAtIndex:i] valueForKey:@"user"];
//            user.userId = [[[jsonData objectAtIndex:i] valueForKey:@"user_id"] intValue];
//            user.username = [[jsonData objectAtIndex:i] valueForKey:@"username"];
//            user.firstname= [[jsonData objectAtIndex:i] valueForKey:@"firstname"];
//            user.lastname = [[jsonData objectAtIndex:i] valueForKey:@"lastname"];
//            user.phone = [[jsonData objectAtIndex:i] valueForKey:@"phone"];
//            user.email = [[jsonData objectAtIndex:i] valueForKey:@"email"];
//            user.address = [[jsonData objectAtIndex:i] valueForKey:@"address"];
            
//            ticket.user = user;
//
//            Flight *flight = [[jsonData objectAtIndex:i] valueForKey:@"flight"];

//            flight.flightId = [[[jsonData objectAtIndex:i] valueForKey:@"flight_id"] intValue];
//            flight.arrive_time = [[jsonData objectAtIndex:i] valueForKey:@"arrive_time"];
//            flight.destination = [[jsonData objectAtIndex:i] valueForKey:@"destination"];
//            flight.price = [[[jsonData objectAtIndex:i] valueForKey:@"price"] floatValue];
//            flight.start_city = [[jsonData objectAtIndex:i] valueForKey:@"start_city"];
//            flight.start_time = [[jsonData objectAtIndex:i] valueForKey:@"start_time"];
//            flight.total_ticket = [[[jsonData objectAtIndex:i] valueForKey:@"total_ticket"] intValue];
//     
//            ticket.flight =flight;
//          
            [ticketList addObject:[NSNumber numberWithInt:chosenTicket]];
        }
        
    }
    
    NSLog(@"count %d",ticketList.count);
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
    return [ticketList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    

    NSNumber *ticket_id = ticketList[indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"Ticket ID: %@",ticket_id];
    
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
    TicketController *ticketView = [[TicketController alloc] initWithNibName:@"TicketController" bundle:nil];
    // Pass the selected object to the new view controller.
    // Push the view controller.

    ticketView.ticket_id = [[ticketList objectAtIndex:indexPath.row] intValue];
    [self.navigationController pushViewController:ticketView animated:YES];
}


@end
