//
//  UITextView+HowToSpendTime.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (HowToSpendTime)

- (void)htmlText:(NSString *)htmlTextString;
- (void)clearTextFromHTMLText:(NSString *)htmlTextString;

@end
