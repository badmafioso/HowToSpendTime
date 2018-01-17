//
//  CalendarCollectionViewCell.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 16.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *weeklyDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfMonthLabel;

@end
