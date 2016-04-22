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

@property NSString* element;

@property int health;

@property id monsterImage;

@property Attack* attack1;
@property Attack* attack2;
@property Attack* attack3;
@property Attack* attack4;

@property NSArray* monsterFrontImages;
@property NSArray* monsterBackImages;

- (void) monsterRoster: (int)intForMonster and:(int)currentUserWins; //This is how the monster is randomly selected

- (void) determineMonsterHealth: (int)currentUserWinsFromRoster;

- (int) monsterAttack: (int) attackNumber; //This monster attacks another monster

- (int) adjustDamage: (int) damageAmount monsterThatAttacked: (Monsters*) monster;

- (int) replacementMonsterHealthAdjustment: (int) currentHealth originalMonsterHealth: (Monsters*) monster;

@end
