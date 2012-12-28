//
//  ViewController.m
//  Temperatures
//
//  Created by SCOTT ASHMORE on 07/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Gradient.h"
#import "PullToChange.h"

@implementation ViewController

@synthesize myTableView;
@synthesize myCent;
@synthesize myMiles;
@synthesize myInches;
@synthesize currentType;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    currentType = typeTemperature;
    
    NSMutableArray *centArray = [[NSMutableArray alloc] init];
    for (float f = 130; f < 255; f += 10)
    {
        [centArray addObject:[NSNumber numberWithFloat:f]];
    }
    myCent = centArray;
    
    NSMutableArray *mileArray = [[NSMutableArray alloc] init];
    for (float f = 1; f < 50; f ++)
    {
        [mileArray addObject:[NSNumber numberWithFloat:f]];
    }
    myMiles = mileArray;
    
    NSMutableArray *inchesArray = [[NSMutableArray alloc] init];
    for (float f = 1; f < 100; f += 2)
    {
        [inchesArray addObject:[NSNumber numberWithFloat:f]];
    }
    myInches = inchesArray;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{    
    UIGradientTableHeaderView *headerView = [[UIGradientTableHeaderView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,35)];
    
    [headerView setGradientStart:[UIColor colorWithRed:109.0f/255.0f green:176.0f/255.0f blue:247.0f/255.0f alpha:1.0f] 
                          andEnd:[UIColor colorWithRed:9.0f/255.0f green:80.0f/255.0f blue:156.0f/255.0f alpha:1.0f]];
    
    headerView.alpha = .8;
    
    UILabel *headerLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, (tableView.frame.size.width /2) -1, 25)];
    headerLabel1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    headerLabel1.textAlignment = UITextAlignmentCenter;
    headerLabel1.font = [UIFont boldSystemFontOfSize:20];
    headerLabel1.text = @"Celsius";
    headerLabel1.backgroundColor = [UIColor clearColor];  
    [headerView addSubview:headerLabel1];
    
    UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:CGRectMake((tableView.frame.size.width /2) +1, 12, (tableView.frame.size.width /2) -1, 25)];
    headerLabel2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    headerLabel2.textAlignment = UITextAlignmentCenter;
    headerLabel2.font = [UIFont boldSystemFontOfSize:20];
    headerLabel2.text = @"Fahrenheit";
    headerLabel2.backgroundColor = [UIColor clearColor]; 
    [headerView addSubview:headerLabel2];
    
    switch (currentType) 
    {
        case typeTemperature:
            headerLabel1.text = @"Celsius";
            headerLabel2.text = @"Fahrenheit";
            break;
            
        case typeMiles:
            headerLabel1.text = @"Miles";
            headerLabel2.text = @"Kilometers";        
            break;
            
        case typeLength:
            headerLabel1.text = @"Inches";
            headerLabel2.text = @"Centimeters";        
            break;
            
        default:
            break;
    }
    return headerView;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myCent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    switch (currentType) 
    {
        case typeTemperature:
            return [self tableView:tableView cellForRowAtIndexPathTemperature:indexPath];
            
        case typeMiles:
            return [self tableView:tableView cellForRowAtIndexPathDistance:indexPath];
            
        case typeLength:
            return [self tableView:tableView cellForRowAtIndexPathLength:indexPath];
 
        default:
            break;
    }
    return [self tableView:tableView cellForRowAtIndexPathTemperature:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPathTemperature:(NSIndexPath *)indexPath 
{
    static NSString *SimpleTableIdentifier = @"TempTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
        cell.contentView.autoresizesSubviews = YES;
        
        UILabel *centLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (cell.contentView.frame.size.width /2) -1, 25)];
        centLabel.tag = 1088;
        centLabel.textAlignment = UITextAlignmentCenter;
        centLabel.backgroundColor = [UIColor clearColor];
        centLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [cell.contentView addSubview:centLabel];
        
        UILabel *farLabel = [[UILabel alloc] initWithFrame:CGRectMake((cell.contentView.frame.size.width /2) +1, 10, (cell.contentView.frame.size.width /2) -1, 25)];
        farLabel.tag = 1089;
        farLabel.textAlignment = UITextAlignmentCenter;
        farLabel.backgroundColor = [UIColor clearColor];
        farLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
        
        
        [cell.contentView addSubview:farLabel];
    } 
    NSUInteger row = [indexPath row];
    float centValue = [[myCent objectAtIndex:row] floatValue];
    float farValue = [self convertCtoF:centValue];
    for (UIView *subView in cell.contentView.subviews)
    {
        if ([subView isMemberOfClass:[UILabel class]])
        {        
            UILabel *myLabel = (UILabel *) subView;
            if (myLabel.tag == 1088)
            {
                myLabel.text = [NSString stringWithFormat:@"%4.0f", centValue];
            }
            else if (myLabel.tag == 1089)
            {
                myLabel.text = [NSString stringWithFormat:@"%4.0f", farValue];
            }
        }
    }
    if ([indexPath row] %2)
        cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.05];
    else
        cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPathDistance:(NSIndexPath *)indexPath 
{
    static NSString *SimpleTableIdentifier = @"DistanceTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
        cell.contentView.autoresizesSubviews = YES;
        
        UILabel *centLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (cell.contentView.frame.size.width /2) -1, 25)];
        centLabel.tag = 1088;
        centLabel.textAlignment = UITextAlignmentCenter;
        centLabel.backgroundColor = [UIColor clearColor];
        centLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [cell.contentView addSubview:centLabel];
        
        UILabel *farLabel = [[UILabel alloc] initWithFrame:CGRectMake((cell.contentView.frame.size.width /2) +1, 10, (cell.contentView.frame.size.width /2) -1, 25)];
        farLabel.tag = 1089;
        farLabel.textAlignment = UITextAlignmentCenter;
        farLabel.backgroundColor = [UIColor clearColor];
        farLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
        
        
        [cell.contentView addSubview:farLabel];
    } 
    NSUInteger row = [indexPath row];
    float mileValue = [[myMiles objectAtIndex:row] floatValue];
    float kilValue = [self convertMtoK:mileValue];
    for (UIView *subView in cell.contentView.subviews)
    {
        if ([subView isMemberOfClass:[UILabel class]])
        {        
            UILabel *myLabel = (UILabel *) subView;
            if (myLabel.tag == 1088)
            {
                myLabel.text = [NSString stringWithFormat:@"%4.0f", mileValue];
            }
            else if (myLabel.tag == 1089)
            {
                myLabel.text = [NSString stringWithFormat:@"%4.2f", kilValue];
            }
        }
    }
    if ([indexPath row] %2)
        cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.05];
    else
        cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPathLength:(NSIndexPath *)indexPath 
{
    static NSString *SimpleTableIdentifier = @"LengthTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
        cell.contentView.autoresizesSubviews = YES;
        
        UILabel *centLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (cell.contentView.frame.size.width /2) -1, 25)];
        centLabel.tag = 1088;
        centLabel.textAlignment = UITextAlignmentCenter;
        centLabel.backgroundColor = [UIColor clearColor];
        centLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [cell.contentView addSubview:centLabel];
        
        UILabel *farLabel = [[UILabel alloc] initWithFrame:CGRectMake((cell.contentView.frame.size.width /2) +1, 10, (cell.contentView.frame.size.width /2) -1, 25)];
        farLabel.tag = 1089;
        farLabel.textAlignment = UITextAlignmentCenter;
        farLabel.backgroundColor = [UIColor clearColor];
        farLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
        
        
        [cell.contentView addSubview:farLabel];
    } 
    NSUInteger row = [indexPath row];
    float inValue = [[myInches objectAtIndex:row] floatValue];
    float cmValue = [self convertItoC:inValue];
    for (UIView *subView in cell.contentView.subviews)
    {
        if ([subView isMemberOfClass:[UILabel class]])
        {        
            UILabel *myLabel = (UILabel *) subView;
            if (myLabel.tag == 1088)
            {
                myLabel.text = [NSString stringWithFormat:@"%3.0f", inValue];
            }
            else if (myLabel.tag == 1089)
            {
                myLabel.text = [NSString stringWithFormat:@"%3.2f", cmValue];
            }
        }
    }
    if ([indexPath row] %2)
        cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.05];
    else
        cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(float)convertCtoF:(float)centValue
{
    return (centValue*1.8)+32;
}

-(float)convertMtoK:(float)mileValue
{
    return (mileValue*1.609);
}

-(float)convertItoC:(float)inchesValue
{
    return (inchesValue*2.54);
}

- (void)refresh 
{
    [self performSelector:@selector(addItem) withObject:nil afterDelay:1.0];
}

- (void)addItem 
{
    switch (currentType) 
    {
        case typeTemperature:
            currentType = typeMiles;
            break;
            
        case typeMiles:
            currentType = typeLength;
            break;
            
        case typeLength:
            currentType = typeTemperature;
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];    
    [self stopLoading];
}


@end

