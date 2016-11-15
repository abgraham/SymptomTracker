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
    NSMutableArray *symptomFoodGroups;
    NSArray *severityPickerData;
    NSArray *foodGroupData;
}
@end

@implementation NewSymptomViewController

- (void)viewDidLoad {

    [self setUpSeverityPicker];
    [self setUpFoodGroupPicker];
    symptomFoodGroups = [NSMutableArray new];
}

- (void)setUpSeverityPicker {

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
    NSString *location = locationField.text;
    if (![location isEqualToString:@""]){
        NSInteger severityPickerIndex = [severityPicker selectedRowInComponent:0];
        NSInteger severity = [severityPickerData[severityPickerIndex] integerValue];
        NSDate *date = datePicker.date;
        [[SymptomAPI sharedInstance] addSymptomWithSeverity:severity location:location foodGroups:symptomFoodGroups date:date];
    }
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

- (IBAction)addFoodGroupPressed:(id)sender {
    NSInteger foodGroupPickerIndex = [foodGroupPicker selectedRowInComponent:0];
    [symptomFoodGroups addObject:foodGroupData[foodGroupPickerIndex]];
    foodGroupList.text = [symptomFoodGroups componentsJoinedByString:@" "];
}

@end
