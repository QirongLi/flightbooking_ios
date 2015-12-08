//
//  ManageFlightsController.m
//  flightbooking
//
//  Created by Qirong on 4/25/14.
//  Copyright (c) 2014 LiQirong. All rights reserved.
//

#import "ManageFlightsController.h"
#import "FlightDetailController.h"
#import "AddFlightController.h"
#import "Flight.h"

@interface ManageFlightsController ()

@end

@implementation ManageFlightsController

@synthesize flights,chosenFlight;

- (void)viewDidLoad
{
            NSURL *url=[NSURL URLWithString:@"http://localhost:8080/edu/ios/allFlights"];

    
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
        
        }
  
    NSLog(@"count %d",flights.count);
    [super viewDidLoad];
    
    self.title = @"All Flights";
    
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
    AddFlightController *addView = [[AddFlightController alloc]initWithNibName:@"AddFlightController" bundle:nil];
    addView.flightList = flights;
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
    return [flights count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    Flight *flight = flights[indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"Flight ID: %d",flight.flightId ];
    
    
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
    FlightDetailController *flightDetail = [[FlightDetailController alloc] initWithNibName:@"FlightDetailController" bundle:nil];
    chosenFlight = [flights objectAtIndex:indexPath.row];
    flightDetail.flightList = flights;
    flightDetail.flight = chosenFlight;
    // Push the view controller.
    [self.navigationController pushViewController:flightDetail animated:YES];
}


@end
