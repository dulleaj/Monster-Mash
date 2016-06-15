//
//  RIPTableViewCell.m
//  Monster Mash
//
//  Created by Andrew Dulle on 6/8/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import "RIPTableViewCell.h"


@implementation RIPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[UIColor lightGrayColor]];
    [self setSelectedBackgroundView:selectedBackgroundView];
    
    UIView * backgroundView = [[UIView alloc] init];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self setBackgroundView:backgroundView];
    
}

@end
