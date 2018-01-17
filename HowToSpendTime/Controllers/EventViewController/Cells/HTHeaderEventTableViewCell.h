//
//  HTHeaderEventTableViewCell.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTHeaderEventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextView;

@end
