//
//  SymptomAPI.h
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SymptomAPI : NSObject

+ (SymptomAPI *)sharedInstance;
- (NSArray *)getSymptoms;
- (NSOrderedSet *)traitStringsSortedBy:(NSString *)sortedBy;
- (NSArray *)symptomsWithDate:(NSString *)date;
- (NSArray *)symptomsWithSeverity:(NSString *)severity;
- (NSArray *)symptomsWithBodyPart:(NSString *)bodyPart;
- (NSDictionary *)foodGroupCountFromSeverity:(NSInteger)lowerSeverity toSeverity:(NSInteger)higherSeverity fromDate:(NSDate *)lowerDate toDate:(NSDate *)higherDate;
- (NSArray *)getFoodGroups;


@end
