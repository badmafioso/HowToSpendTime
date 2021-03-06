//
//  TableViewCell.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTEventTableViewCell.h"

@implementation HTEventTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIColor *glowColor = [UIColor whiteColor];
    self.eventTitleLabel.layer.shadowColor = [glowColor CGColor];
    self.eventTitleLabel.layer.shadowRadius = 3.0f;
    self.eventTitleLabel.layer.shadowOpacity = .8;
    self.eventTitleLabel.layer.shadowOffset = CGSizeZero;
    self.eventTitleLabel.layer.masksToBounds = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
