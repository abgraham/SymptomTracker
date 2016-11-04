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
#import "NewSymptomViewController.h"

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
    [self loadPreviousState];
    [self setUpSegmentedControl];
    [self setUpSymptomSelector];
    [self getRelevantSymptoms];
    [self setUpSymptomTable];
    [self showDataForSymptomAtIndex:currentSymptomIndex];
    [self setUpButtons];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCurrentState) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)testAnalyser {

    NSDateComponents* tomorrowComponents = [NSDateComponents new] ;
    tomorrowComponents.day = 1 ;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDate* tomorrow = [calendar dateByAddingComponents:tomorrowComponents toDate:now options:0] ;
    NSDateComponents* yesterdayComponents = [NSDateComponents new] ;
    yesterdayComponents.day = -1 ;
    NSDate* yesterday = [calendar dateByAddingComponents:yesterdayComponents toDate:now options:0] ;
    [[SymptomAPI sharedInstance] foodGroupCountFromSeverity:3 toSeverity:9 fromDate:yesterday toDate:tomorrow];
    [[SymptomAPI sharedInstance] timeOfDayCountFromSeverity:0 toSeverity:9 fromDate:yesterday toDate:tomorrow];
}

- (void)getRelevantSymptoms{

    NSInteger segmentedControlIndex = segmentedControl.selectedSegmentIndex;
    UITableViewCell *selectedCell = [symptomSelector cellForRowAtIndexPath:[symptomSelector indexPathForSelectedRow]];

    switch (segmentedControlIndex){
        case 0:
            allSymptoms = [[SymptomAPI sharedInstance] symptomsWithDate:selectedCell.textLabel.text];
            break;
        case 1:
            allSymptoms = [[SymptomAPI sharedInstance] symptomsWithSeverity:selectedCell.textLabel.text];
            break;
        case 2:
            allSymptoms = [[SymptomAPI sharedInstance] symptomsWithBodyPart:selectedCell.textLabel.text];
            break;
    }
}

- (void)setUpSymptomTable {

    symptomTable = [[UITableView alloc] initWithFrame:CGRectMake(self.view.center.x-150, self.view.center.y+55, 300, 150) style:UITableViewStylePlain];
    symptomTable.delegate = self;
    symptomTable.dataSource = self;
    [self.view addSubview:symptomTable];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self getRelevantSymptoms];
    currentSymptomIndex = 0;
    [self showDataForSymptomAtIndex:currentSymptomIndex];
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
    NSOrderedSet *orderedStringsOfSelectedTrait = [[SymptomAPI sharedInstance] traitStringsSortedBy:[self keyPathForSegmentTitle]];
    symptomCell.textLabel.text = orderedStringsOfSelectedTrait[indexPath.row];
    return symptomCell;
}

- (NSString *)keyPathForSegmentTitle {

    NSInteger segmentIndex = segmentedControl.selectedSegmentIndex;
    switch (segmentIndex){
        case 0:
            return @"time";
        case 1:
            return @"severity";
        case 2:
            return @"bodyPart";
    }
    return nil;
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
    } else {
        NSOrderedSet *orderedStringsOfSelectedTrait = [[SymptomAPI sharedInstance] traitStringsSortedBy:[self keyPathForSegmentTitle]];
        return [orderedStringsOfSelectedTrait count];
    }
    return 0;
}

- (void)forwardButtonPressed:(id)sender {

    if (currentSymptomIndex < [allSymptoms count]){
        currentSymptomIndex += 1;
        [self showDataForSymptomAtIndex:currentSymptomIndex];
    }
}

- (void)backButtonPressed:(id)sender {

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

- (void)addSymptomPressed:(id)sender {

    NewSymptomViewController *newSymptomVC =[self.storyboard instantiateViewControllerWithIdentifier:@"newSymptomViewController"];
    [self.navigationController pushViewController:newSymptomVC animated:YES];
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
    [symptomSelector selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                 animated:NO
                           scrollPosition:0];
    currentSymptomIndex = 0;
    [self getRelevantSymptoms];
    [self showDataForSymptomAtIndex:currentSymptomIndex];
}

- (void)setUpSymptomSelector {

    symptomSelector = [[UITableView alloc] initWithFrame:CGRectMake(self.view.center.x-150, self.view.center.y-220, 300, 200) style:UITableViewStylePlain];
    symptomSelector.delegate = self;
    symptomSelector.dataSource = self;
    [self.view addSubview:symptomSelector];
    [symptomSelector selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                             animated:NO
                       scrollPosition:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)saveCurrentState {
    [[NSUserDefaults standardUserDefaults] setInteger:currentSymptomIndex forKey:@"currentSymptomIndex"];
}

- (void)loadPreviousState {

    currentSymptomIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentSymptomIndex"];
    [self showDataForSymptomAtIndex:currentSymptomIndex];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
