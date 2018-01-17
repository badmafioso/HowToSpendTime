//
//  UITextView+HowToSpendTime.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "UITextView+HowToSpendTime.h"

@implementation UITextView (HowToSpendTime)

- (void)htmlText:(NSString *)htmlTextString {
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [htmlTextString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    self.attributedText = attributedString;
}

- (void)clearTextFromHTMLText:(NSString *)htmlTextString {
    self.text = [htmlTextString stringByReplacingOccurrencesOfString:@"<[^>]+>"
                                                          withString:@""
                                                             options:NSRegularExpressionSearch
                                                               range:NSMakeRange(0, [htmlTextString length])];
}

@end
