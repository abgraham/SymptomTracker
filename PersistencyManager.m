//
//  PersistencyManager.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "PersistencyManager.h"
#import "Symptom+StringRepresentation.h"

@interface PersistencyManager () {
    NSMutableArray *symptoms;
    NSArray *foodGroups;
};

- (NSArray *)sortWithKey:(NSString *)key;

@end


@implementation PersistencyManager

- (id)init {
    self = [super init];
    if (self){
        Symptom *symptom1 = [[Symptom alloc] initWithTime:[NSDate date] severity:2 bodyPart:@"stomach" foodGroups:[NSArray arrayWithObjects:@"dairy", @"gluten", @"fiber", nil]];
        Symptom *symptom2 = [[Symptom alloc] initWithTime:[NSDate date] severity:3 bodyPart:@"chin" foodGroups:[NSArray arrayWithObjects: @"dairy", @"gluten", nil]];
        Symptom *symptom3 = [[Symptom alloc] initWithTime:[NSDate date] severity:4 bodyPart:@"chin" foodGroups:[NSArray arrayWithObjects: @"dairy", @"gluten", @"eggs", nil]];
        Symptom *symptom4 = [[Symptom alloc] initWithTime:[NSDate date] severity:5 bodyPart:@"chin" foodGroups:[NSArray arrayWithObjects: @"dairy", @"gluten", @"eggs", nil]];

        symptoms = [NSMutableArray arrayWithObjects:symptom1, symptom2, symptom3, symptom4, nil];

        foodGroups = [NSArray arrayWithObjects:@"gluten", @"dairy", @"eggs", @"high-fiber", @"meat", @"high-fat", nil];
    }

    return self;
}

- (NSArray *)getSymptoms {

    return symptoms;
}

- (NSArray *)getFoodGroups {

    return foodGroups;
}

- (NSArray *)sortWithKey:(NSString *)key {

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [symptoms sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
}

- (NSOrderedSet *)traitStringsSortedBy:(NSString *)key{
    NSArray *symptomsSortedByTrait = [self sortWithKey:key];
    NSMutableOrderedSet *stringRepresentations = [NSMutableOrderedSet new];
    for (int i=0; i<[symptomsSortedByTrait count]; i++){
        Symptom *symptom = symptomsSortedByTrait[i];
        [stringRepresentations addObject:[symptom stringOfKey:key]];
    }
    return stringRepresentations;
}

- (NSArray *)symptomsWithDate:(NSString *)date{
    NSArray *filteredArray = [symptoms filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
        if ([[(Symptom *)object str_time] isEqual:date]){
            return YES;
        } return NO;
    }]];
    //symptoms = [filteredArray mutableCopy];
    return filteredArray;
}

- (NSArray *)symptomsWithBodyPart:(NSString *)bodyPart{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.bodyPart == %@", bodyPart];
    NSArray *filteredArray = [symptoms filteredArrayUsingPredicate:predicate];
    //symptoms = [filteredArray mutableCopy];
    return filteredArray;
}

- (NSArray *)symptomsWithSeverity:(NSString *)severity{
    NSArray *filteredArray = [symptoms filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
        if ([[(Symptom *)object str_severity] isEqual:severity]){
            return YES;
        } return NO;
    }]];
    //symptoms = [filteredArray mutableCopy];
    return filteredArray;
}

@end
