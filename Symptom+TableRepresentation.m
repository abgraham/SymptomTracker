//
//  Symptom+TableRepresentation.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "Symptom+TableRepresentation.h"

@implementation Symptom (TableRepresentation)

- (NSDictionary *)tr_tableRepresentation{
    return @{@"titles":@[@"Time of symptom", @"Pain on 1-10 scale", @"Location of pain"], @"values":@[[self str_time], [self str_severity], self.bodyPart]};
}


@end
