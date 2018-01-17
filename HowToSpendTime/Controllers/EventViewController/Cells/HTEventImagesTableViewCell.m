//
//  HTEventImagesTableViewCell.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTEventImagesTableViewCell.h"

@interface HTEventImagesTableViewCell() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *imagesPageControl;
@property (nonatomic) CGFloat originalScrollViewWidth;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation HTEventImagesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.eventImagesScrollView.delegate = self;
    
    self.indicatorView                  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.center           = self.contentView.center;
    self.indicatorView.hidesWhenStopped = YES;
    
    [self.indicatorView startAnimating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupScrollViewWithImages:(NSArray <NSData *>*)eventImages {
    self.originalScrollViewWidth = self.eventImagesScrollView.frame.size.width;
    
    self.eventImagesScrollView.contentSize = CGSizeMake(self.originalScrollViewWidth * eventImages.count,
                                                        self.eventImagesScrollView.frame.size.height);
    
    [self setupImagesPageControlWithPageCount:eventImages.count];
    [self.indicatorView stopAnimating];
    
    NSInteger imageIndex = 0;
    for (NSData *imageData in eventImages) {
        CGRect imageFrame      = CGRectMake(self.originalScrollViewWidth * imageIndex, 0, self.eventImagesScrollView.frame.size.width, self.eventImagesScrollView.frame.size.height);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
        imageView.image        = [UIImage imageWithData:imageData];
        
        [self.eventImagesScrollView addSubview:imageView];
        
        imageIndex++;
    }
}

- (void)setupImagesPageControlWithPageCount:(NSInteger)pagesCount {
    self.imagesPageControl.numberOfPages = pagesCount;
    self.imagesPageControl.currentPage   = 0;
}
- (IBAction)imagesPageControlChanged:(UIPageControl *)sender {
    CGFloat nextPageCoordinateX = self.originalScrollViewWidth * sender.currentPage;
    
    [self.eventImagesScrollView setContentOffset:CGPointMake(nextPageCoordinateX, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageNumber = round(self.eventImagesScrollView.contentOffset.x / self.eventImagesScrollView.frame.size.width);
    
    self.imagesPageControl.currentPage = (int)pageNumber;
}

@end
