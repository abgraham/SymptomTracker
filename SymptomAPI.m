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

- (NSOrderedSet *)traitStringsSortedBy:(NSString *)sortedBy {
    return [persistencyManager traitStringsSortedBy:sortedBy];
}

@end
