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
        self.health = 110;
        self.element = @"❄️";
        self.monsterFrontImages = [NSArray arrayWithObjects:@"0",@"0F1",@"0F2",@"0F3",@"0F4", nil];
        self.monsterBackImages = [NSArray arrayWithObjects:@"0back",@"0B1",@"0B2",@"0B3",@"0B4", nil];
       
    }else if (self.monsterInt == 1) {
        
        self.name = @"Squak";
        self.health = 100;
        self.element = @"🔥";
        self.monsterFrontImages = [NSArray arrayWithObjects: @"1",@"1F1",@"1F2",@"1F3",@"1F4", nil];
        self.monsterBackImages = [NSArray arrayWithObjects:@"1back",@"1B1",@"1B2",@"1B3",@"1B4", nil];
        
    }else if (self.monsterInt == 2) {
        
        self.name = @"Clops";
        self.health = 100;
        self.element = @"💧";
        self.monsterFrontImages = [NSArray arrayWithObjects:@"2",@"2F1",@"2F2",@"2F3",@"2F4", nil];
        self.monsterBackImages = [NSArray arrayWithObjects:@"2back",@"2B1",@"2B2",@"2B3",@"2B4", nil];
        
    }else if (self.monsterInt == 3) {
        
        self.name = @"Hypno";
        self.health = 110;
        self.element = @"❄️";
        self.monsterFrontImages = [NSArray arrayWithObjects:@"3",@"3F1",@"3F2",@"3F3",@"3F4", nil];
        self.monsterBackImages = [NSArray arrayWithObjects:@"3back",@"3B1",@"3B2",@"3B3",@"3B4", nil];
        
    }else if (self.monsterInt == 4) {
        
        self.name = @"Snap";
        self.health = 100;
        self.element = @"💧";
        self.monsterFrontImages = [NSArray arrayWithObjects:@"4",@"4F1",@"4F2",@"4F3",@"4F4", nil];
        self.monsterBackImages = [NSArray arrayWithObjects:@"4back",@"4B1",@"4B2",@"4B3",@"4B4", nil];
        
    }else if (self.monsterInt == 5) {
        
        self.name = @"Fright";
        self.health = 100;
        self.element = @"🔥";
        self.monsterFrontImages = [NSArray arrayWithObjects:@"5",@"5F1",@"5F2",@"5F3",@"5F4", nil];
        self.monsterBackImages = [NSArray arrayWithObjects:@"5back",@"5B1",@"5B2",@"5B3",@"5B4", nil];
        
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
// int damage = [self.opp adjustDamage: potential  monsterThatAttacked: self.user];
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
