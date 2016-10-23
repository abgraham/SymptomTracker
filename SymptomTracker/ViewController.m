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
    UIButton *forwardButton;
    UIButton *backButton;
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
    [self setUpButtons];
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

- (void)forwardButtonPressed:(id)sender {
    NSLog(@"pressed forward");
    if (currentSymptomIndex < [allSymptoms count]){
        currentSymptomIndex += 1;
        [self showDataForSymptomAtIndex:currentSymptomIndex];
    }
}

- (void)backButtonPressed:(id)sender {
    NSLog(@"pressed back");
    if (currentSymptomIndex > 0){
        currentSymptomIndex -= 1;
        [self showDataForSymptomAtIndex:currentSymptomIndex];
    }
}

- (void)setUpButtons {
    forwardButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    forwardButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [forwardButton setTitle:@"Forward" forState:UIControlStateNormal];
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(240.0, 210.0, 160.0, 40.0);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(forwardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    [forwardButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:forwardButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:backButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-forwardButton.frame.size.width/2]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:forwardButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:0.80 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:backButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:0.80 constant:0.0]];

    [self.view addSubview:forwardButton];
    [self.view addSubview:backButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
