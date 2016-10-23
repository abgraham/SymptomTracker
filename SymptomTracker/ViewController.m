//
//  ViewController.m
//  SymptomTracker
//
//  Created by Annie Graham on 10/23/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "ViewController.h"
#import "Symptom+TableRepresentation.h"
#import "SymptomAPI.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {

    UITableView *symptomTable;
    NSMutableArray *symptoms;
    NSDictionary *currentSymptomData;
    NSArray *allSymptoms;
    NSInteger currentSymptomIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.76f green:0.81f blue:0.87f alpha:1];
    currentSymptomIndex = 0;
    allSymptoms = [[SymptomAPI sharedInstance] getSymptoms];
    [self showDataForSymptomAtIndex:currentSymptomIndex];
    [self setUpSymptomTable];
}

- (void)setUpSymptomTable {
    symptomTable = [[UITableView alloc] initWithFrame:CGRectMake(self.view.center.x-150, self.view.center.y-200, 300, 400) style:UITableViewStyleGrouped];
    symptomTable.delegate = self;
    symptomTable.dataSource = self;
    [self.view addSubview:symptomTable];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"symptomCell"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"symptomCell"];
    }
    cell.textLabel.text = currentSymptomData[@"titles"][indexPath.row];
    cell.detailTextLabel.text = currentSymptomData[@"values"][indexPath.row];
    //cell.detailTextLabel.text = @"value";

    return cell;
}

- (void)showDataForSymptomAtIndex:(NSInteger)symptomIndex {
    if (symptomIndex < [allSymptoms count]){
        Symptom *symptom = [allSymptoms objectAtIndex:symptomIndex];
        currentSymptomData = [symptom tr_tableRepresentation];
    } else {
        currentSymptomData = nil;
    }
    [symptomTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [currentSymptomData[@"titles"] count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
