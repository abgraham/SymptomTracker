//
//  SymptomAPI.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "SymptomAPI.h"
#import "PersistencyManager.h"

@interface SymptomAPI () {
    PersistencyManager *persistencyManager;
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
    }
    return self;
}

- (NSArray *)getSymptoms {
    return [persistencyManager getSymptoms];
}

- (NSArray *)symptomsSortedBy:(NSString *)sortedBy {
    if ([sortedBy  isEqual: @"Date"]){
        return [NSArray arrayWithObjects:@"10/24/16", @"11/30/16", nil];
    } else if ([sortedBy  isEqual: @"What Hurts"]){
        return [NSArray arrayWithObjects:@"Stomach", @"Chin", nil];
    } else if ([sortedBy  isEqual: @"Severity"]){
        return [NSArray arrayWithObjects:@"4", @"8", nil];
    }
    return nil;
}

@end
