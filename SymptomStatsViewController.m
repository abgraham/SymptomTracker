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

    NSDictionary *foodGroupDict = [[SymptomAPI sharedInstance] foodGroupCountFromSeverity:fromSeverityValue toSeverity:toSeverityValue fromDate:fromDate toDate:toDate];
    [self showFoodGroupCount:foodGroupDict];
    NSDictionary *timeOfDayDict = [[SymptomAPI sharedInstance] timeOfDayCountFromSeverity:fromSeverityValue toSeverity:toSeverityValue fromDate:fromDate toDate:toDate];
    [self showTimeOfDayCount:timeOfDayDict];
}

- (void)showFoodGroupCount:(NSDictionary *)foodGroupDict {
    [foodGroupCount setText:[self formatStatsDictionary:foodGroupDict]];
}

- (void)showTimeOfDayCount:(NSDictionary *)timeOfDayDict {
    [timeOfDayCount setText:[self formatStatsDictionary:timeOfDayDict]];
}

- (NSString *)formatStatsDictionary:(NSDictionary *)statsDictionary {
    NSString *dictionaryString = [NSString stringWithFormat:@"%@", statsDictionary];
    return [dictionaryString substringWithRange:NSMakeRange(1, dictionaryString.length-2)];
}

@end
