
//
//  DataAnalyser.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/28/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "DataAnalyser.h"
#import "SymptomAPI.h"
#import "Symptom+ExtraProperties.h"

@implementation DataAnalyser

- (NSDictionary *)foodGroupCountFromSeverity:(NSInteger)lowerSeverity toSeverity:(NSInteger)higherSeverity fromDate:(NSDate *)lowerDate toDate:(NSDate *)higherDate{
    NSMutableDictionary *foodGroupsCount = [NSMutableDictionary new];
    NSArray *foodGroups = [[SymptomAPI sharedInstance] getFoodGroups];
    [foodGroups enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *groupName = obj;
        foodGroupsCount[groupName] = [NSNumber numberWithInteger:0];
    }];
    NSArray *relevantSymptoms = [self symptomsFromSeverity:lowerSeverity toSeverity:higherSeverity fromDate:lowerDate toDate:higherDate];

    [relevantSymptoms enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Symptom *symptom = obj;
        NSArray *symptomFoodGroups = symptom.foodGroups;
        [symptomFoodGroups enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *foodGroup = obj;
            foodGroupsCount[foodGroup] = [NSNumber numberWithInteger:([foodGroupsCount[foodGroup] intValue] + 1)];
        }];
    }];
    return foodGroupsCount;
}

- (NSArray *)symptomsFromSeverity:(NSInteger)lowerSeverity toSeverity:(NSInteger)
    higherSeverity fromDate:(NSDate *)lowerDate toDate:(NSDate *)higherDate {
    NSArray *allSymptoms = [[SymptomAPI sharedInstance] getSymptoms];
    NSPredicate *severityPredicate = [NSPredicate predicateWithFormat:@"severity >= %ld AND severity <= %ld", lowerSeverity, higherSeverity];
    NSArray *relevantSymptoms = [[allSymptoms filteredArrayUsingPredicate:severityPredicate] mutableCopy];
    NSPredicate *timePredicate = [NSPredicate predicateWithFormat:@"(time >= %@) AND (time <= %@)", lowerDate, higherDate];
    relevantSymptoms = [relevantSymptoms filteredArrayUsingPredicate:timePredicate];

    return relevantSymptoms;
}

- (NSDictionary *)timeOfDayCountFromSeverity:(NSInteger)lowerSeverity toSeverity:(NSInteger)higherSeverity fromDate:(NSDate *)lowerDate toDate:(NSDate *)higherDate{
    NSArray *relevantSymptoms = [self symptomsFromSeverity:lowerSeverity toSeverity:higherSeverity fromDate:lowerDate toDate:higherDate];
    NSMutableDictionary *timeOfDayCount = [NSMutableDictionary new];
    [timeOfDayCount addEntriesFromDictionary: @{@"Morning":[NSNumber numberWithInteger:0], @"Midday":[NSNumber numberWithInteger:0], @"Afternoon":[NSNumber numberWithInteger:0], @"Evening": [NSNumber numberWithInteger:0], @"Nighttime": [NSNumber numberWithInteger:0]}];

    [relevantSymptoms enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Symptom *symptom = obj;
        NSString *timeOfDay = [symptom timeOfDay];
        timeOfDayCount[timeOfDay] = [NSNumber numberWithInt:([timeOfDayCount[timeOfDay] intValue] + 1)];
    }];

    return timeOfDayCount;
}


@end
