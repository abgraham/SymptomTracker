//
//  Symptom.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "Symptom.h"

@implementation Symptom

- (id)initWithTime:(NSDate *)time painLevel:(NSInteger)painLevel bodyPart:(NSString *)bodyPart {
    self = [super init];
    if (self){
        self.time = time;
        self.painLevel = painLevel;
        self.bodyPart = bodyPart;
    }
    return self;
}

@end
