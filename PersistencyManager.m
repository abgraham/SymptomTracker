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
        NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/symptoms.bin"]];
        symptoms = [[NSKeyedUnarchiver unarchiveObjectWithData:data] mutableCopy];

        if (symptoms == nil) {

            NSDateComponents* tomorrowComponents = [NSDateComponents new];
            tomorrowComponents.hour = -12;
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDate *now = [NSDate date];
            NSDate* tomorrow = [calendar dateByAddingComponents:tomorrowComponents toDate:now options:0] ;
            NSDateComponents* yesterdayComponents = [NSDateComponents new] ;
            yesterdayComponents.hour = -6;
            NSDate* yesterday = [calendar dateByAddingComponents:yesterdayComponents toDate:now options:0] ;

            Symptom *symptom1 = [[Symptom alloc] initWithTime:yesterday severity:2 bodyPart:@"stomach" foodGroups:[NSArray arrayWithObjects:@"dairy", @"gluten", @"fiber", nil]];
            Symptom *symptom2 = [[Symptom alloc] initWithTime:tomorrow severity:3 bodyPart:@"chin" foodGroups:[NSArray arrayWithObjects: @"dairy", @"gluten", nil]];
            Symptom *symptom3 = [[Symptom alloc] initWithTime:[NSDate date] severity:4 bodyPart:@"chin" foodGroups:[NSArray arrayWithObjects: @"dairy", @"gluten", @"eggs", nil]];
            Symptom *symptom4 = [[Symptom alloc] initWithTime:[NSDate date] severity:5 bodyPart:@"chin" foodGroups:[NSArray arrayWithObjects: @"dairy", @"gluten", @"eggs", nil]];

            symptoms = [NSMutableArray arrayWithObjects:symptom1, symptom2, symptom3, symptom4, nil];

        }
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

    return filteredArray;
}

- (NSArray *)symptomsWithBodyPart:(NSString *)bodyPart{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.bodyPart == %@", bodyPart];
    NSArray *filteredArray = [symptoms filteredArrayUsingPredicate:predicate];

    return filteredArray;
}

- (NSArray *)symptomsWithSeverity:(NSString *)severity{
    NSArray *filteredArray = [symptoms filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
        if ([[(Symptom *)object str_severity] isEqual:severity]){

            return YES;
        } return NO;
    }]];

    return filteredArray;
}

- (void)addSymptomWithSeverity:(NSInteger)severity location:(NSString *)location foodGroups:(NSArray *)symptomFoodGroups date:(NSDate *)date{
    [symptoms addObject:[[Symptom alloc] initWithTime:date severity:severity bodyPart:location foodGroups:symptomFoodGroups]];
}

- (void)saveSymptoms {
    NSString *fileName = [NSHomeDirectory() stringByAppendingString:@"/Documents/symptoms.bin"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:symptoms];
    [data writeToFile:fileName atomically:YES];
}

@end
