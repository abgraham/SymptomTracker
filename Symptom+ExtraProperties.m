//
//  Symptom+ExtraProperties.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/28/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "Symptom+ExtraProperties.h"

@implementation Symptom (ExtraProperties)

- (NSString *)timeOfDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [calendar components:NSCalendarUnitHour
                                               fromDate:self.time];

    NSInteger hour = [components hour] - 2;

    if (hour >= 6 && hour <= 11) {
        return @"Morning";
    } else if (hour <= 13) {
        return @"Midday";
    } else if (hour <= 16) {
        return @"Afternoon";
    } else if (hour <= 22) {
        return @"Evening";
    }
    return @"Nighttime";
}

@end
