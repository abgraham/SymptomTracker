//
//  Symptom+StringRepresentation.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/25/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "Symptom+StringRepresentation.h"

@implementation Symptom (StringRepresentation)

- (NSString *)str_time {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    return [formatter stringFromDate:self.time];
}

- (NSString *)str_severity{
    return [NSString stringWithFormat: @"%ld",self.severity];
}

- (NSString *)str_bodyPart{
    return self.bodyPart;
}

- (NSString *)stringOfKey:(NSString *)key{
    if ([key isEqual:@"time"]){
        return [self str_time];
    } else if ([key isEqual:@"severity"]){
        return [self str_severity];
    }
    return self.bodyPart;
}

@end
