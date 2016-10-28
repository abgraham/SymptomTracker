//
//  SymptomStatsViewController.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/28/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "SymptomStatsViewController.h"
#import "SymptomAPI.h"

@interface SymptomStatsViewController () {

    __weak IBOutlet UIDatePicker *toDatePicker;
    __weak IBOutlet UIDatePicker *fromDatePicker;
    __weak IBOutlet UITextField *fromSeverity;
    __weak IBOutlet UITextField *toSeverity;
    __weak IBOutlet UITextView *foodGroupCount;
    __weak IBOutlet UITextView *timeOfDayCount;
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

    NSDictionary *foodGroupCount = [[SymptomAPI sharedInstance] foodGroupCountFromSeverity:fromSeverityValue toSeverity:toSeverityValue fromDate:fromDate toDate:toDate];
    [self showFoodGroupCount:foodGroupCount];
    NSDictionary *timeOfDayCount = [[SymptomAPI sharedInstance] timeOfDayCountFromSeverity:fromSeverityValue toSeverity:toSeverityValue fromDate:fromDate toDate:toDate];
    [self showTimeOfDayCount:timeOfDayCount];
}

- (void)showFoodGroupCount:(NSDictionary *)foodGroupDict {
    [foodGroupCount setText:[NSString stringWithFormat:@"%@", foodGroupDict]];
}

- (void)showTimeOfDayCount:(NSDictionary *)timeOfDayDict {
    [timeOfDayCount setText:[NSString stringWithFormat:@"%@", timeOfDayDict]];
}

@end
