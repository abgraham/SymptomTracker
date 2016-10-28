//
//  NewSymptomViewController.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/24/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "NewSymptomViewController.h"

@interface NewSymptomViewController () {
    UIPickerView *severityPicker;
    UIDatePicker *datePicker;
    UITextField *locationField;
}
@end

@implementation NewSymptomViewController

- (void)viewDidLoad {
NSLog(@"On new symptom view");
    //[self setUpSeverityPicker];
    //[self setUpDatePicker];
}

- (void)setUpSeverityPicker {
    NSLog(@"setUpSeverityPicker");
}

- (void)setUpDatePicker {
    //datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    datePicker = [UIDatePicker new];
    //[datePicker addTarget:self action:@selector(pickerChanged:)];
    [self.view addSubview:datePicker];
}

- (void)pickerChanged:(id)sender {
    NSLog(@"picker changed");
}

@end
