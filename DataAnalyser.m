
//
//  DataAnalyser.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/28/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "DataAnalyser.h"
#import "SymptomAPI.h"

@implementation DataAnalyser

- (NSDictionary *)foodGroupCountFromSeverity:(NSInteger)lowerSeverity toSeverity:(NSInteger)higherSeverity fromDate:(NSDate *)lowerDate toDate:(NSDate *)higherDate{
    NSMutableDictionary *foodGroupsCount = [NSMutableDictionary new];
    NSArray *foodGroups = [[SymptomAPI sharedInstance] getFoodGroups];
    [foodGroups enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *groupName = obj;
        foodGroupsToCount:[foodGroupsCount setValue:0 forKey:groupName];
    }];
    NSArray *relevantSymptoms = [self symptomsFromSeverity:lowerSeverity toSeverity:higherSeverity fromDate:lowerDate toDate:higherDate];
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



@end
