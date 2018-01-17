//
//  ViewController.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 08.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTHomeViewController.h"
#import "HTEventsModelManager.h"
#import "HTImageManager.h"
#import "HTEvent.h"
#import "HTEventTableViewCell.h"
#import "HTURLConstants.h"
#import "UITextView+HowToSpendTime.h"
#import "HTEventViewController.h"
#import "CalendarCollectionViewCell.h"
#import "HTCalendar.h"
#import "HTCalendarDay.h"

const int kLoadingCellTag = 9999;

@interface HTHomeViewController () <HTEventsManagerDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) HTEventsModelManager *eventsManager;
@property (strong, nonatomic) HTImageManager *imagesManager;
@property (strong, nonatomic) NSMutableArray *eventsArray;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *calendarCollectionView;
@property (strong, nonatomic) HTCalendar *calendarObject;

@end

@implementation HTHomeViewController

- (HTEventsModelManager *)eventsManager {
    if (_eventsManager == nil) {
        return _eventsManager = [[HTEventsModelManager alloc] init];
    }
    
    return _eventsManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.eventsManager.delegate = self;
    self.imagesManager          = [[HTImageManager alloc] init];
    self.eventsArray            = [NSMutableArray array];

    self.eventsTableView.estimatedRowHeight = 360.0;
    self.eventsTableView.rowHeight          = UITableViewAutomaticDimension;
    
    self.calendarObject = [[HTCalendar alloc] initWithStartDate:@"2017-01-01" finishDate:@"2020-12-31" andDateFormat:@"yyyy-MM-dd"];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.calendarObject.currentDayIndex inSection:0];
    
    [self.calendarCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - CollectionView

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CalendarCollectionViewCell *cell = [self.calendarCollectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCell" forIndexPath:indexPath];
    
    HTCalendarDay *calendarDay = [self.calendarObject calendarDayByIndex:indexPath.row];
    
    cell.weeklyDayLabel.text  = calendarDay.shortDayOfWeekNameString;
    cell.dayOfMonthLabel.text = calendarDay.dayOfMonthString;
    
    if (calendarDay.isCurrentDate) {
        cell.dayOfMonthLabel.textColor = [UIColor redColor];
        cell.layer.borderColor         = [UIColor blueColor].CGColor;
        cell.layer.borderWidth         = 3.0f;
    } else {
        cell.dayOfMonthLabel.textColor = [UIColor blackColor];
        cell.layer.borderColor         = nil;
        cell.layer.borderWidth         = 0.0f;
    }
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.calendarCollectionView cellForItemAtIndexPath:indexPath];
    
    cell.layer.borderColor = [UIColor blueColor].CGColor;
    cell.layer.borderWidth = 3.0f;
    
    [self.eventsArray removeAllObjects];
    [self.eventsTableView reloadData];
    [self.eventsManager reloadEventsManager];
    
    [self.eventsManager loadEventLitsByDate:[self.calendarObject calendarDayByIndex:indexPath.row].currentDate];
}

- (void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.calendarCollectionView cellForItemAtIndexPath:indexPath];
    
    cell.layer.borderColor = nil;
    cell.layer.borderWidth = 0.0f;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.calendarObject countCalendarDays];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.eventsArray.count == 0 || (self.eventsArray.count % kHTEventItemsCountOnPage == 0)) {
        return self.eventsArray.count + 1;
    }
    
    return self.eventsArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if (indexPath.row < self.eventsArray.count) {
        return [self eventCellForIndexPath:indexPath];
    } else {
        return [self loadingCell];
    }
}

- (UITableViewCell *)eventCellForIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"EventCell";
    
    HTEventTableViewCell *cell = [self.eventsTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[HTEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    HTEvent *event = [self.eventsArray objectAtIndex:indexPath.row];
    
    cell.eventTitleLabel.text = [event.title capitalizedString];
    
    [cell.eventDescriptionTextView clearTextFromHTMLText:event.descriptionString];
    
    if (event.imageUrls.firstObject) {
        cell.eventImageView.image = [UIImage imageNamed:@"placeholderImage"];
        [self.imagesManager imageFromUrl:event.imageUrls.firstObject withCompletion:^(NSData *data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.eventImageView.image = [UIImage imageWithData:data];
            });
        }];
    }
    
    return cell;
}

- (UITableViewCell *)loadingCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activityIndicator.center = cell.contentView.center;
    
    [cell addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    cell.tag = kLoadingCellTag;
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (cell.tag == kLoadingCellTag) {
        [self.eventsManager loadEventLits];
    }
}

#pragma mark - Main functionality

- (void)requestToGetEventsDidCompleted:(HTEvents *)events withError:(NSError *)error {
    if (error) {
        NSLog(@"Request event list error: %@", error.localizedDescription);
        
        return;
    }
    
    [self.eventsArray addObjectsFromArray:events.events];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.eventsTableView reloadData];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.eventsTableView indexPathForSelectedRow];
    
    if (indexPath) {
        HTEvent *event = self.eventsArray[indexPath.row];
        
        HTEventViewController *eventVC = [segue destinationViewController];
        
        [eventVC setEventId:event.eventId];
        [eventVC setTitleString:event.title];
        [eventVC setDescriptionString:event.descriptionString];
    }
}

@end
