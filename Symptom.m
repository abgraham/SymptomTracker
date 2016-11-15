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

- (id)initWithCoder:(NSCoder *)decoder {

    self = [super init];
    if (self) {

        self.time = [decoder decodeObjectForKey:@"time"];
        self.severity = [decoder decodeIntegerForKey:@"severity"];
        self.bodyPart = [decoder decodeObjectForKey:@"bodyPart"];
        self.foodGroups = [decoder decodeObjectForKey:@"foodGroups"];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {

    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeInteger:self.severity forKey:@"severity"];
    [encoder encodeObject:self.bodyPart forKey:@"bodyPart"];
    [encoder encodeObject:self.foodGroups forKey:@"foodGroups"];
}

@end
