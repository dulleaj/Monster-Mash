//
//  Monsters.h
//  Monster Mash
//
//  Created by Andrew Dulle on 3/16/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attack.h"

@interface Monsters : NSObject

@property int monsterInt;

@property NSString* name;

@property int health;

@property id monsterImage;

@property Attack* attack1;
@property Attack* attack2;
@property Attack* attack3;
@property Attack* attack4;

- (void) monsterRoster; //This is how the monster is randomly selected

- (int) monsterAttack: (int) attackNumber; //This monster attacks another monster

- (int) monsterWasAttacked: (int) damageTaken; //This monster was attacked by another monster

@end
