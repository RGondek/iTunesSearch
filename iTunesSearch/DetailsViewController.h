//
//  DetailsViewController.h
//  iTunesSearch
//
//  Created by Rubens Gondek on 3/11/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblArt;
@property (weak, nonatomic) IBOutlet UIImageView *imgCapa;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@property NSUInteger iRow;
@property NSUInteger iSection;

@end
