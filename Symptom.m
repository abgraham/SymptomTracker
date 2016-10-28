//
//  Symptom.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "Symptom.h"

@implementation Symptom

- (id)initWithTime:(NSDate *)time severity:(NSInteger)severity bodyPart:(NSString *)bodyPart foodGroups:(NSArray *)foodGroups {
    self = [super init];
    if (self){
        self.time = time;
        self.severity = severity;
        self.bodyPart = bodyPart;
        self.foodGroups = foodGroups;
    }
    return self;
}

@end
