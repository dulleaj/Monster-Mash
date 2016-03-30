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
        
        // Fire beats ice, loses to water. Let's add 5 to fire attack.
        // Ice beats water, loses to fire. Let's add 10 to defense, take 5 off each attack.
        // Water beats fire, loses to ice. With probability, lets give water better odds for landing.
        
        self.name = @"Chomp";
        self.health = 110;
        self.element = @"❄️";
       
    }else if (self.monsterInt == 1) {
        
        self.name = @"Squak";
        self.health = 100;
        self.element = @"🔥";
        
    }else if (self.monsterInt == 2) {
        
        self.name = @"Clops";
        self.health = 100;
        self.element = @"💧";
        
    }else if (self.monsterInt == 3) {
        
        self.name = @"Hypno";
        self.health = 110;
        self.element = @"❄️";
        
    }else if (self.monsterInt == 4) {
        
        self.name = @"Snap";
        self.health = 100;
        self.element = @"💧";
        
    }else if (self.monsterInt == 5) {
        
        self.name = @"Fright";
        self.health = 100;
        self.element = @"🔥";
        
    }
    
}

- (int)monsterAttack:(int)attackNumber{ // attackNumber = which attack user selected
    
    int probability = arc4random_uniform(4)+1;
    
    if (attackNumber == 1) {
        
        return self.attack1.attackDamage;
        
    }else if ((attackNumber == 2) && (probability != 1)) {
        
        return self.attack2.attackDamage;
        
    }else if ((attackNumber == 3) && (probability != 1)) {
        
        return self.attack3.attackDamage;
        
    }else if ((attackNumber == 4) && ((probability ==3) || (probability == 4))) {
        
        return self.attack4.attackDamage;
        
    }else{
        
        return 0;
        
    }
    
}

- (int)adjustDamage:(int)damageAmount monsterThatAttacked:(Monsters *)monster {
    
    int actualDamageReceived = damageAmount;
    
    if (damageAmount != 0){
        
        if (monster.monsterInt == self.monsterInt) {
            
            actualDamageReceived = actualDamageReceived/2;
            
        }else if ([monster.element  isEqual: @"🔥"] && [self.element  isEqual: @"❄️"]) {
            
            actualDamageReceived = (5 + actualDamageReceived);
            
        }else if ([monster.element  isEqual: @"❄️"] && [self.element  isEqual: @"💧"]){
            actualDamageReceived = (5 + actualDamageReceived);
            
        }else if ([monster.element  isEqual: @"💧"] && [self.element  isEqual: @"🔥"]){
            actualDamageReceived = (5 + actualDamageReceived);
            
        }
        
    }
    
    [self removeDamageFromHealth: actualDamageReceived];
    
    return actualDamageReceived;
    
}

- (void) removeDamageFromHealth: (int) damage {
    
    self.health -= damage;
    
}

- (int)replacementMonsterHealthAdjustment:(int)currentHealth originalMonsterHealth:(Monsters *)monster {
    
    int damageTakenSoFar = 0;
    
    if ([self.element isEqual: @"❄️"]) {
        
        damageTakenSoFar = 110 - currentHealth;
        
    } else {
        
        damageTakenSoFar = 100 - currentHealth;
    }
    
    return damageTakenSoFar + 10;
}

//returns need to end in else, so it's always guaranteed to return something

//self is actual object that called this method. left side of equation. In the view controller, self.user calls "adjust damage". The view controller passes in self.opp as the monster requirement for adjust damage. whatever object calls the method inside of its class, is called "Self". The opponent is attacked in the view controller by the user. The view controller has to use one of its monsters to call adjust damage.

@end
