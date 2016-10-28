//
//  DataAnalyser.h
//  SymptomTracker
//
//  Created by Annie Graham on 10/28/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataAnalyser : NSObject

- (NSDictionary *)foodGroupCountFromSeverity:(NSInteger)lowerSeverity toSeverity:(NSInteger)higherSeverity fromDate:(NSDate *)lowerDate toDate:(NSDate *)higherDate;

@end
