//
//  NewSymptomViewController.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/24/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "NewSymptomViewController.h"

@interface NewSymptomViewController () {
    
    __weak IBOutlet UIPickerView *severityPicker;
    UIDatePicker *datePicker;
    UITextField *locationField;
    NSArray *severityPickerData;
}
@end

@implementation NewSymptomViewController

- (void)viewDidLoad {
NSLog(@"On new symptom view");
    [self setUpSeverityPicker];
    //[self setUpDatePicker];
}

- (void)setUpSeverityPicker {
    NSLog(@"setUpSeverityPicker");
    severityPickerData = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5",
                          @"6", @"7", @"8", @"9", @"10", nil];
    severityPicker.delegate = self;
    severityPicker.dataSource = self;
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

- (IBAction)addSymptomPressed:(id)sender {
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [severityPickerData count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return severityPickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection

    NSLog(@"hi");
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;

    return sectionWidth;
}

@end
