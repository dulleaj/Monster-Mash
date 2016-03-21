//
//  Attack.h
//  Monster Mash
//
//  Created by Andrew Dulle on 3/20/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attack : NSObject

@property int attackDamage;

@property NSString* attackName;

- (void) createAttackForMonster: (int) monster attacknumber: (int) attack;

@end
