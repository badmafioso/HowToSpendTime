//
//  HTEventImagesTableViewCell.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTEventImagesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *eventImagesScrollView;

- (void)setupScrollViewWithImages:(NSArray <NSData *>*)eventImages;

@end
