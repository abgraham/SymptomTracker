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
@property (nonatomic) NSInteger painLevel;
@property (nonatomic, copy) NSString *bodyPart;
- (id)initWithTime:(NSDate *)time painLevel:(NSInteger)painLevel bodyPart:(NSString *)bodyPart;

@end
