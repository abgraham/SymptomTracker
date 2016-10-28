//
//  Symptom.h
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Symptom : NSObject

@property (nonatomic, copy) NSDate *time;
@property (nonatomic) NSInteger severity;
@property (nonatomic, copy) NSString *bodyPart;
@property (nonatomic) NSArray *foodGroups;
- (id)initWithTime:(NSDate *)time severity:(NSInteger)severity bodyPart:(NSString *)bodyPart foodGroups:(NSArray *)foodGroups;

@end
