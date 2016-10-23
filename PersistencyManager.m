//
//  PersistencyManager.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "PersistencyManager.h"
#import "Symptom.h"

@interface PersistencyManager () {
    NSMutableArray *symptoms;
};
@end

@implementation PersistencyManager

- (id)init {
    self = [super init];
    if (self){
        symptoms = [NSMutableArray arrayWithArray:@[[[Symptom alloc] initWithTime:[NSDate date] painLevel:2 bodyPart:@"stomach"], [[Symptom alloc] initWithTime:[NSDate date] painLevel:3 bodyPart:@"chin"]]];
    }

    return self;
}

- (NSArray *)getSymptoms {

    return symptoms;
}

@end
