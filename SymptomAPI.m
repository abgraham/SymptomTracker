//
//  SymptomAPI.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "SymptomAPI.h"
#import "PersistencyManager.h"
#import "DataAnalyser.h"

@interface SymptomAPI () {
    PersistencyManager *persistencyManager;
    DataAnalyser *dataAnalyser;
}

@end

@implementation SymptomAPI

+ (SymptomAPI *)sharedInstance {
    static SymptomAPI *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [SymptomAPI new];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        persistencyManager = [PersistencyManager new];
        dataAnalyser = [DataAnalyser new];
    }
    return self;
}

- (NSArray *)getSymptoms {
    return [persistencyManager getSymptoms];
}

- (NSOrderedSet *)traitStringsSortedBy:(NSString *)sortedBy {
    return [persistencyManager traitStringsSortedBy:sortedBy];
}

- (NSArray *)symptomsWithDate:(NSString *)date{
    return [persistencyManager symptomsWithDate:date];
}

- (NSArray *)symptomsWithSeverity:(NSString *)severity{
    return [persistencyManager symptomsWithSeverity:severity];
}
- (NSArray *)symptomsWithBodyPart:(NSString *)bodyPart{
    return [persistencyManager symptomsWithBodyPart:bodyPart];
}

- (NSDictionary *)foodGroupCountFromSeverity:(NSInteger)lowerSeverity toSeverity:(NSInteger)higherSeverity fromDate:(NSDate *)lowerDate toDate:(NSDate *)higherDate {
    return [dataAnalyser foodGroupCountFromSeverity:lowerSeverity toSeverity:higherSeverity fromDate:lowerDate toDate:higherDate];
}

- (NSArray *)getFoodGroups {
    return [persistencyManager getFoodGroups];
}


@end
