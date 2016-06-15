//
//  RIPTableViewCell.h
//  Monster Mash
//
//  Created by Andrew Dulle on 6/8/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Monsters.h"

@interface RIPTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellMonsterImage;
@property Monsters* monster;

@end
