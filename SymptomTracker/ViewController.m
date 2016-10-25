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
    UIBarButtonItem *addSymptom;
    UISegmentedControl *segmentedControl;
    UITableView *symptomSelector;
}

- (void)setUpBarButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    currentSymptomIndex = 0;
    allSymptoms = [[SymptomAPI sharedInstance] getSymptoms];
    [self showDataForSymptomAtIndex:currentSymptomIndex];
    [self setUpSymptomTable];
    [self setUpBarButton];
    [self setUpButtons];
    [self setUpSegmentedControl];
    [self setUpSymptomSelector];
}

- (void)setUpSymptomTable {
    symptomTable = [[UITableView alloc] initWithFrame:CGRectMake(self.view.center.x-150, self.view.center.y+55, 300, 150) style:UITableViewStylePlain];
    symptomTable.delegate = self;
    symptomTable.dataSource = self;
    [self.view addSubview:symptomTable];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == symptomTable){
        UITableViewCell *traitCell = [tableView dequeueReusableCellWithIdentifier:@"traitCell"];
        if (!traitCell){
            traitCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"traitCell"];
        }
        traitCell.textLabel.text = currentSymptomData[@"titles"][indexPath.row];
        traitCell.detailTextLabel.text = currentSymptomData[@"values"][indexPath.row];
        
        return traitCell;
    }
    // tableView is symptomSelector
    UITableViewCell *symptomCell = [tableView dequeueReusableCellWithIdentifier:@"symptomCell"];
    if (!symptomCell){
        symptomCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"symptomCell"];
    }
    NSString *sortedBy = [segmentedControl titleForSegmentAtIndex:segmentedControl.selectedSegmentIndex];
    NSArray *symptomsSortedBySelectedTrait = [[SymptomAPI sharedInstance] symptomsSortedBy:sortedBy];
    symptomCell.textLabel.text = symptomsSortedBySelectedTrait[indexPath.row];
    return symptomCell;
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
    if (tableView == symptomTable){
        return [currentSymptomData[@"titles"] count];
    }
    // tableView is the symptomSelector
    return [allSymptoms count];
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
forwardButton.frame = CGRectMake(210.0, self.view.frame.size.height-100, 100.0, 40.0);
    [forwardButton setTitle:@"Forward" forState:UIControlStateNormal];
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
backButton.frame = CGRectMake(100.0, self.view.frame.size.height-100, 100.0, 40.0);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(forwardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    forwardButton.backgroundColor = [UIColor lightGrayColor];
    backButton.backgroundColor = [UIColor lightGrayColor];

    [self.view addSubview:forwardButton];
    [self.view addSubview:backButton];
}

- (void)setUpBarButton {
    addSymptom = [UIBarButtonItem new];
    addSymptom.title = @"Add symptom";
    self.navigationController.navigationBar.topItem.rightBarButtonItem = addSymptom;
}

- (void)setUpSegmentedControl {
     NSArray *titleArray = [NSArray arrayWithObjects: @"Date", @"Severity", @"What Hurts", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:titleArray];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.frame = CGRectMake(self.view.center.x-125, self.view.center.y, 250, 45);
    [segmentedControl addObserver:self forKeyPath:@"selectedSegmentIndex" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:segmentedControl];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [symptomSelector reloadData];
}

- (void)setUpSymptomSelector {
    symptomSelector = [[UITableView alloc] initWithFrame:CGRectMake(self.view.center.x-150, self.view.center.y-220, 300, 200) style:UITableViewStylePlain];
    symptomSelector.delegate = self;
    symptomSelector.dataSource = self;
    [self.view addSubview:symptomSelector];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
