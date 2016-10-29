//
//  NewSymptomViewController.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/24/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "NewSymptomViewController.h"
#import "SymptomAPI.h"

@interface NewSymptomViewController () {

    __weak IBOutlet UIPickerView *severityPicker;
    __weak IBOutlet UITextField *locationField;
    __weak IBOutlet UIPickerView *foodGroupPicker;

    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UITextView *foodGroupList;
    NSArray *severityPickerData;
    NSArray *foodGroupData;
}
@end

@implementation NewSymptomViewController

- (void)viewDidLoad {
NSLog(@"On new symptom view");
    [self setUpSeverityPicker];
    [self setUpFoodGroupPicker];
}

- (void)setUpSeverityPicker {
    NSLog(@"setUpSeverityPicker");
    severityPickerData = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5",
                          @"6", @"7", @"8", @"9", @"10", nil];
    severityPicker.delegate = self;
    severityPicker.dataSource = self;
}

- (void)setUpFoodGroupPicker {
    foodGroupData = [[SymptomAPI sharedInstance] getFoodGroups];
    foodGroupPicker.delegate = self;
    foodGroupPicker.dataSource = self;
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
    if (pickerView == severityPicker){
return [severityPickerData count];
    } else {
        return [foodGroupData count];
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == severityPicker){
        return severityPickerData[row];
    } else {
        return foodGroupData[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection

    NSLog(@"hi");
}

- (IBAction)addFoodGroupPressed:(id)sender {
}

@end
