//
//  HTEventViewController.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTEventViewController.h"
#import "HTHeaderEventTableViewCell.h"
#import "HTEventContentTableViewCell.h"
#import "HTEventImagesTableViewCell.h"
#import "UITextView+HowToSpendTime.h"
#import "HTEventsModelManager.h"
#import "HTImageManager.h"
#import "UITextView+HowToSpendTime.h"

NS_ENUM(NSInteger, HTEventCellType) {
    HTEventCellTypeHeader,
    HTEventCellTypeContent,
    HTEventCellTypeImages
};

NSString * const kHTEventHeaderCellIdentifier  = @"HeaderEventCell";
NSString * const kHTEventContentCellIdentifier = @"EventContentCell";
NSString * const kHTEventImagesCellIdentifier  = @"EventImagesCell";

@interface HTEventViewController () <UITableViewDelegate, UITableViewDataSource, HTEventsManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *eventTableView;
@property (strong, nonatomic) HTEventsModelManager *eventManager;
@property (strong, nonatomic) HTImageManager *imagesManager;
@property (strong, nonatomic) HTEvent *event;
@property (strong, nonatomic) NSArray<UIImage *> *eventIamges;

@end

@implementation HTEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eventManager = [[HTEventsModelManager alloc] init];
    self.eventManager.delegate = self;
    self.eventTableView.estimatedRowHeight = 157.0;
    self.eventTableView.rowHeight = UITableViewAutomaticDimension;
    
    if (self.eventId > 0) {
        [self.eventManager loadEvent:self.eventId];
        
        self.imagesManager = [[HTImageManager alloc] init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    switch (indexPath.row) {
        case HTEventCellTypeHeader:
            return [self setupHeaderCell];
            
            break;
            
        case HTEventCellTypeContent:
            return [self setupContentCell];
            
            break;
        case HTEventCellTypeImages:
            return [self setupImagesCell];
            
            break;
            
        default:
            return [self setupHeaderCell];
            
            break;
    }
}

- (UITableViewCell *)setupHeaderCell {
    HTHeaderEventTableViewCell *cell = [self.eventTableView dequeueReusableCellWithIdentifier:kHTEventHeaderCellIdentifier];
    
    if (!cell) {
        cell = [[HTHeaderEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHTEventHeaderCellIdentifier];
    }
    
    cell.eventTitleLabel.text = [self.titleString capitalizedString];
    
    [cell.eventDescriptionTextView htmlText:self.descriptionString];
    
    return cell;
}

- (UITableViewCell *)setupContentCell {
    HTEventContentTableViewCell *cell = [self.eventTableView dequeueReusableCellWithIdentifier:kHTEventContentCellIdentifier];
    
    if (!cell) {
        cell = [[HTEventContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHTEventContentCellIdentifier];
    }
    
    if (self.event) {
        [cell.eventBodyText htmlText:self.event.bodyText];
        
        if (self.event.place != nil) {
            cell.placeLabel.text = [NSString stringWithFormat:@"Место проведения: %@", self.event.place];
        }
        
        cell.priceLabel.text = [NSString stringWithFormat:@"Цена: %@", self.event.price];
    }
    
    return cell;
}

- (UITableViewCell *)setupImagesCell {
    HTEventImagesTableViewCell *cell = [self.eventTableView dequeueReusableCellWithIdentifier:kHTEventImagesCellIdentifier];
    
    if (!cell) {
        cell = [[HTEventImagesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHTEventImagesCellIdentifier];
    }
    
    if (self.event && self.event.imageUrls.count > 0) {
        [self.imagesManager imagesFromArray:self.event.imageUrls withCompletion:^(NSArray <NSData *>* arrayData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell setupScrollViewWithImages:arrayData];
            });
        }];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case HTEventCellTypeHeader:
            return UITableViewAutomaticDimension;

            break;
        case HTEventCellTypeContent:
            return UITableViewAutomaticDimension;

            break;
        case HTEventCellTypeImages:
            return 280.0;

            break;
    }

    return UITableViewAutomaticDimension;
}

- (void)requestToGetEventDidCompleted:(HTEvent *)event withError:(NSError *)error {
    if (event) {
        self.event = event;
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self) strongSelf = weakSelf;
            
            [strongSelf.eventTableView reloadData];
        });
    }
}

@end


