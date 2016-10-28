//
//  PersistencyManager.h
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistencyManager : NSObject

- (NSArray *)getSymptoms;
- (NSArray *)getFoodGroups;
- (NSOrderedSet *)traitStringsSortedBy:(NSString *)key;
- (NSArray *)symptomsWithDate:(NSString *)date;
- (NSArray *)symptomsWithSeverity:(NSString *)severity;
- (NSArray *)symptomsWithBodyPart:(NSString *)bodyPart;

@end
