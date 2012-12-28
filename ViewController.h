//
//  ViewController.h
//  Temperatures
//
//  Created by SCOTT ASHMORE on 07/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToChange.h"
typedef enum conversionType
{
    typeTemperature = 1,
    typeMiles,
    typeLength,    
} ConversionType;

@interface ViewController : PullRefreshTableViewController  <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *myCent;
@property (strong, nonatomic) NSArray *myMiles;
@property (strong, nonatomic) NSArray *myInches;

@property (nonatomic) ConversionType currentType;

-(float)convertCtoF:(float)centValue;
-(float)convertMtoK:(float)mileValue;
-(float)convertItoC:(float)inchesValue;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPathTemperature:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPathDistance:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPathLength:(NSIndexPath *)indexPath;


@end
