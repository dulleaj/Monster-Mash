//
//  Monsters.m
//  Monster Mash
//
//  Created by Andrew Dulle on 3/16/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import "Monsters.h"

@implementation Monsters

- (void) monsterRoster {
    
    self.monsterInt = arc4random_uniform(6);
    
    self.attack1 = [[Attack alloc] init];
    self.attack2 = [[Attack alloc] init];
    self.attack3 = [[Attack alloc] init];
    self.attack4 = [[Attack alloc] init];
    
    [self.attack1 createAttackForMonster: self.monsterInt attacknumber: 1];
    [self.attack2 createAttackForMonster: self.monsterInt attacknumber: 2];
    [self.attack3 createAttackForMonster: self.monsterInt attacknumber: 3];
    [self.attack4 createAttackForMonster: self.monsterInt attacknumber: 4];
    
    if (self.monsterInt == 0) {
        
        self.name = @"Chomp";
        self.health = 100;
       
    }else if (self.monsterInt == 1) {
        
        self.name = @"Squak";
        self.health = 100;
        
    }else if (self.monsterInt == 2) {
        
        self.name = @"Clops";
        self.health = 100;
        
    }else if (self.monsterInt == 3) {
        
        self.name = @"Hypno";
        self.health = 100;

    }else if (self.monsterInt == 4) {
        
        self.name = @"Snap";
        self.health = 100;
        
    }else if (self.monsterInt == 5) {
        
        self.name = @"Fright";
        self.health = 100;
        
    }
    
}

- (int) monsterAttack: (int) attackNumber { // attackNumber = which attack user selected
    
    if (attackNumber == 1) { // based on attack selected, we return this amount of damage
        
        return self.attack1.attackDamage;
        
    }else if (attackNumber == 2) {
        
        if (self.monsterInt == 3) {
        
            return self.attack2.attackDamage*2; // Hypno does twice as much damage
            
        }else{
        
        return self.attack2.attackDamage;
        
        }
        
    }else if (attackNumber == 3) {
        
        return self.attack3.attackDamage;
        
    }else{
        
        return self.attack4.attackDamage;
        
    }
    
}

- (int) monsterWasAttacked:(int)damageTaken {
    
    if (self.monsterInt == 2) { //Clops takes 50% less damage
        
        damageTaken *= 0.5;
        
    }else if (self.monsterInt == 3) { //Hpyno takes 50% more damage
        
        damageTaken *= 1.5;
        
    }
    
    self.health -= damageTaken;
    
    return damageTaken;
    
}
//returns need to end in else, so it's always guaranteed to return something
@end
