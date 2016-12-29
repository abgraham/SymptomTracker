//
//  Symptom+StringRepresentation.h
//  SymptomTracker
//
//  Created by Annie Graham on 10/25/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "Symptom.h"

@interface Symptom (StringRepresentation)

- (NSString *)str_time;
- (NSString *)str_time_date;
- (NSString *)str_severity;
- (NSString *)str_bodyPart;
- (NSString *)stringOfKey:(NSString *)key;

@end
