//
//  SymptomLogViewController.m
//  SymptomTracker
//
//  Created by Annie Graham on 12/29/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "SymptomLogViewController.h"
#import "SymptomAPI.h"
#import "Symptom+StringRepresentation.h"

@interface SymptomLogViewController () {

    NSArray *allSymptoms;
    __weak IBOutlet UITableView *symptomTable;
}

@end

@implementation SymptomLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    allSymptoms = [[SymptomAPI sharedInstance] getSymptoms];
    [self setUpSymptomTable];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSymptomTable {
    symptomTable.delegate = self;
    symptomTable.dataSource = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {

    UITableViewCell *symptomCell = [tableView dequeueReusableCellWithIdentifier:@"allSymptom"];
    if (!symptomCell){
        symptomCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"symptomCell"];
    }
    Symptom *symptom = allSymptoms[indexPath.row];
    symptomCell.textLabel.text = [symptom str_time_date];
    symptomCell.detailTextLabel.text = [symptom str_bodyPart];

    return symptomCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return allSymptoms.count;
}


@end
