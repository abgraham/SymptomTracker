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

- (NSArray *)sortWithKey:(NSString *)key;

@end


@implementation PersistencyManager

- (id)init {
    self = [super init];
    if (self){
        symptoms = [NSMutableArray arrayWithArray:@[[[Symptom alloc] initWithTime:[NSDate date] severity:2 bodyPart:@"stomach"], [[Symptom alloc] initWithTime:[NSDate date] severity:3 bodyPart:@"chin"]]];
    }

    return self;
}

- (NSArray *)getSymptoms {

    return symptoms;
}

- (NSArray *)symptomsSortedBy:(NSString *)sortedBy {
    if ([sortedBy  isEqual: @"Date"]){

        return [self sortWithKey:@"time"];
    } else if ([sortedBy  isEqual: @"What Hurts"]){

        return [self sortWithKey:@"bodyPart"];
    } else if ([sortedBy  isEqual: @"Severity"]){

        return [self sortWithKey:@"severity"];
    }
    return nil;
}

- (NSArray *)sortWithKey:(NSString *)key {

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];

    return [symptoms sortedArrayUsingDescriptors:sortDescriptors];
}

@end
