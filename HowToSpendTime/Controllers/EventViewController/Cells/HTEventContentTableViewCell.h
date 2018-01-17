//
//  HTContentTableViewCell.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTEventContentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *eventBodyText;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
