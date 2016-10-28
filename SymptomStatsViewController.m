//
//  SymptomStatsViewController.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/28/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "SymptomStatsViewController.h"

@interface SymptomStatsViewController () {

    __weak IBOutlet UIDatePicker *toDatePicker;
    __weak IBOutlet UIDatePicker *fromDatePicker;
    __weak IBOutlet UITextField *fromSeverity;
    __weak IBOutlet UITextField *toSeverity;
}
@end

@implementation SymptomStatsViewController

- (void)viewDidLoad {

}

- (IBAction)showStatsPressed:(id)sender {
    NSDate *fromDate = fromDatePicker.date;
    NSDate *toDate = toDatePicker.date;
    NSInteger fromSeverityValue = [fromSeverity.text integerValue];
    NSInteger toSeverityValue = [toSeverity.text integerValue];
    NSLog(@"FROM AND TO: %ld %ld", fromSeverityValue, toSeverityValue);
    //[self showFoodGroupCount:foodGroupCount];
    //[self showTimeOfDayCount:timeOfDayCount];
}

- (void)showFoodGroupCount:(NSDictionary *)foodGroupCount {

}

- (void)showTimeOfDayCount:(NSDictionary *)timeOfDayCount {
    NSString *stringRepresentation;
}

@end
