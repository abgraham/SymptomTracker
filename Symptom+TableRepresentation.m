//
//  Symptom+TableRepresentation.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "Symptom+TableRepresentation.h"

@implementation Symptom (TableRepresentation)

- (NSDictionary *)tr_tableRepresentation{
    return @{@"titles":@[@"Time of symptom", @"Pain on 1-10 scale", @"Location of pain"], @"values":@[[self getDateString:self.time], [NSString stringWithFormat: @"%ld",self.severity], self.bodyPart]};
}

- (NSString *)getDateString:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    return [formatter stringFromDate:date];
}

@end
