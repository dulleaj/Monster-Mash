//
//  Attack.m
//  Monster Mash
//
//  Created by Andrew Dulle on 3/20/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import "Attack.h"

@implementation Attack

- (void) createAttackForMonster:(int)monster attacknumber:(int)attack {
    
    if (monster == 0) { // ICE
        
        if (attack == 1) {
            
            self.attackName = @"Bite";
            self.attackDamage = 10;
        
        } else if (attack == 2) {
            
            self.attackName = @"Fury Attack";
            self.attackDamage = 15;
            
        } else if (attack == 3) {
            
            self.attackName = @"Smash";
            self.attackDamage = 20;

        } else if (attack == 4) {
            
            self.attackName = @"Guillotine";
            self.attackDamage = 25;
        }
    }

    if (monster == 1) { // FIRE
        
        if (attack == 1) {
            
            self.attackName = @"Peck";
            self.attackDamage = 20;
            
        } else if (attack == 2) {
            
            self.attackName = @"Scratch";
            self.attackDamage = 20;
            
        } else if (attack == 3) {
            
            self.attackName = @"Aerial Attack";
            self.attackDamage = 25;
            
        } else if (attack == 4) {
            
            self.attackName = @"Vice Grip";
            self.attackDamage = 35;
        }
    }

    if (monster == 2) { // WATER
        
        if (attack == 1) {
            
            self.attackName = @"Charge";
            self.attackDamage = 15;
            
        } else if (attack == 2) {
            
            self.attackName = @"Constrict";
            self.attackDamage = 20;
            
        } else if (attack == 3) {
            
            self.attackName = @"Electrify";
            self.attackDamage = 20;
            
        } else if (attack == 4) {
            
            self.attackName = @"Hyper Beam";
            self.attackDamage = 30;
        }
    }
    
    if (monster == 3) { // ICE
        
        if (attack == 1) {
            
            self.attackName = @"Hypnotize";
            self.attackDamage = 10;
            
        } else if (attack == 2) {
            
            self.attackName = @"Confuse Ray";
            self.attackDamage = 15;
            
        } else if (attack == 3) {
            
            self.attackName = @"Amnesia";
            self.attackDamage = 20;
            
        } else if (attack == 4) {
            
            self.attackName = @"Headbutt";
            self.attackDamage = 20;
        }
    }

    if (monster == 4) { // WATER
        
        if (attack == 1) {
            
            self.attackName = @"Tail Smack";
            self.attackDamage = 15;
            
        } else if (attack == 2) {
            
            self.attackName = @"Aqua Jet";
            self.attackDamage = 20;
            
        } else if (attack == 3) {
            
            self.attackName = @"Dive Attack";
            self.attackDamage = 20;
            
        } else if (attack == 4) {
            
            self.attackName = @"Hurricane";
            self.attackDamage = 25;
        }
    }

    if (monster == 5) { // FIRE
        
        if (attack == 1) {
            
            self.attackName = @"Acid Spray";
            self.attackDamage = 20;
            
        } else if (attack == 2) {
            
            self.attackName = @"Curse";
            self.attackDamage = 25;
            
        } else if (attack == 3) {
            
            self.attackName = @"Hell Fury";
            self.attackDamage = 25;
            
        } else if (attack == 4) {
            
            self.attackName = @"Dark Pulse";
            self.attackDamage = 35;
        }
    }
}

@end
