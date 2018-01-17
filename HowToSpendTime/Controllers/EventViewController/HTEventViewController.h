//
//  HTEventViewController.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTEventViewController : UIViewController

@property (nonatomic) NSInteger eventId;
@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) NSString *descriptionString;

@end
