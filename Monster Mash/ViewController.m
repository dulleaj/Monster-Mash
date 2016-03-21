//
//  ViewController.m
//  Monster Mash
//
//  Created by Andrew Dulle on 3/16/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import "ViewController.h"
#import "Monsters.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIImageView *oppPic;
@property (weak, nonatomic) IBOutlet UILabel *oppName;
@property (weak, nonatomic) IBOutlet UILabel *oppHealth;
@property (weak, nonatomic) IBOutlet UIImageView *userPic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userHealth;
@property (weak, nonatomic) IBOutlet UIButton *attack1;
@property (weak, nonatomic) IBOutlet UIButton *attack2;
@property (weak, nonatomic) IBOutlet UIButton *attack3;
@property (weak, nonatomic) IBOutlet UIButton *attack4;
@property NSMutableArray* defeatedMonsters;
@property Monsters* opp;
@property Monsters* user;
@property int damageGiven;
@property int damageTaken;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *retaliateButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.startButton.hidden = NO;
    self.oppPic.hidden = YES;
    self.oppName.hidden = YES;
    self.oppHealth.hidden = YES;
    self.userPic.hidden = YES;
    self.userName.hidden = YES;
    self.userHealth.hidden = YES;
    self.attack1.hidden = YES;
    self.attack2.hidden = YES;
    self.attack3.hidden = YES;
    self.attack4.hidden = YES;
    self.continueButton.hidden = YES;
    self.retaliateButton.hidden = YES;
    self.restartButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startButtonWasTapped:(id)sender {
    
    self.startButton.hidden = YES;
    self.oppPic.hidden = NO;
    self.oppName.hidden = NO;
    self.oppHealth.hidden = NO;
    self.userPic.hidden = NO;
    self.userName.hidden = NO;
    self.userHealth.hidden = NO;
    self.attack1.hidden = NO;
    self.attack2.hidden = NO;
    self.attack3.hidden = NO;
    self.attack4.hidden = NO;
    self.continueButton.hidden = YES;
    self.retaliateButton.hidden = YES;
    self.restartButton.hidden = YES;

    self.defeatedMonsters = [[NSMutableArray alloc] init];
    
    [self generateOppMonster];
    
    [self generateUserMonster];
    
}

- (void) generateUserMonster {
    
    self.user = [[Monsters alloc] init];
    [self.user monsterRoster];
    self.userName.text = self.user.name;
    self.userHealth.text = [NSString stringWithFormat:@"%d",self.user.health];
    self.userPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",self.user.monsterInt]];
    
    [self.attack1 setTitle: self.user.attack1.attackName forState:UIControlStateNormal];
    [self.attack2 setTitle: self.user.attack2.attackName forState:UIControlStateNormal];
    [self.attack3 setTitle: self.user.attack3.attackName forState:UIControlStateNormal];
    [self.attack4 setTitle: self.user.attack4.attackName forState:UIControlStateNormal];
    
}


- (void) generateOppMonster {
    
    self.opp = [[Monsters alloc] init];
    [self.opp monsterRoster];
    self.oppName.text = self.opp.name;
    self.oppHealth.text = [NSString stringWithFormat:@"%d",self.opp.health];
    self.oppPic.image = [UIImage imageNamed: [NSString stringWithFormat:@"%d",self.opp.monsterInt]];
    
}

- (IBAction)attack1ButtonPressed:(id)sender {
    
    [self handleAttack:1];
    
}

- (IBAction)attack2ButtonPressed:(id)sender {
    
    [self handleAttack:2];
}

- (IBAction)attack3ButtonPressed:(id)sender {
    
    [self handleAttack:3];
}

- (IBAction)attack4ButtonPressed:(id)sender {
    
    [self handleAttack:4];
    
}


- (void) handleAttack: (int) attackNumber {
    
    self.damageTaken = [self.opp monsterWasAttacked:[self.user monsterAttack: attackNumber]];
    
    [self afterAttackButtonWasPressed];

}

- (void) afterAttackButtonWasPressed {
    
    self.oppHealth.text = [NSString stringWithFormat:@"%d",self.opp.health];
    
    self.continueButton.hidden = NO;
    
    [self.continueButton setTitle:[NSString stringWithFormat:@"You attacked %@, doing %d damage.", self.opp.name, self.damageGiven] forState:UIControlStateNormal];
    
    self.attack1.hidden = YES;
    self.attack2.hidden = YES;
    self.attack3.hidden = YES;
    self.attack4.hidden = YES;
    
}

- (IBAction)afterContinueButtonWasPressed:(id)sender {
    
    self.continueButton.hidden = YES;
    
    if (self.opp.health > 0) {
        
        [self computerAttacks];
        
    } else if (self.opp.health <= 0){
        
        self.view.backgroundColor = [UIColor greenColor];
        
        self.restartButton.hidden = NO;
        
        [self.restartButton setTitle:[NSString stringWithFormat:@"You defeated %@!", self.opp.name] forState:UIControlStateNormal];
        
    }
    
}


- (void) computerAttacks {
    
    int randomAttackInt = arc4random_uniform(4)+1;
    
    self.damageTaken = [self.user monsterWasAttacked:[self.opp monsterAttack: randomAttackInt]];
    
    self.userHealth.text = [NSString stringWithFormat:@"%d", self.user.health];
    
    self.retaliateButton.hidden = NO;
    
    [self.retaliateButton setTitle:[NSString stringWithFormat:@"%@ attacked you, doing %d damage.", self.opp.name, self.damageTaken] forState:UIControlStateNormal];
    
}

- (IBAction)afterRetaliateButtonWasPressed:(id)sender {
    
    self.retaliateButton.hidden = YES;
    
    if (self.user.health > 0) {
        
        self.attack1.hidden = NO;
        self.attack2.hidden = NO;
        self.attack3.hidden = NO;
        self.attack4.hidden = NO;
        
    } else if (self.user.health <0) {
        
        self.view.backgroundColor = [UIColor redColor];
        
        self.restartButton.hidden = NO;
        
        [self.restartButton setTitle:[NSString stringWithFormat:@"You have been defeated by %@!", self.opp.name] forState:UIControlStateNormal];
                    
    }
    
}

- (IBAction)afterRestartButtonWasPressed:(id)sender {
    
    self.restartButton.hidden = YES;
    
    if (self.view.backgroundColor == [UIColor greenColor]) {
        
        self.user.health += 100;
        
        self.userHealth.text = [NSString stringWithFormat:@"%d",self.user.health];
        
        [self generateOppMonster];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.attack1.hidden = NO;
        self.attack2.hidden = NO;
        self.attack3.hidden = NO;
        self.attack4.hidden = NO;
        
    } else if (self.view.backgroundColor == [UIColor redColor]) {
        
        [self generateOppMonster];
        
        [self generateUserMonster];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.attack1.hidden = NO;
        self.attack2.hidden = NO;
        self.attack3.hidden = NO;
        self.attack4.hidden = NO;
        
    }
    
}


// Make three types of elements (water, fire, ice) - when the monster appears, create a symbol under the monster to show which element they are. Make this rock-paper-scissors style where each element has a strength/weakness vs another element.
// Make a scale for the attacks, give weakest attack the highest percent of landing, give strongest the lowest percent, etc.
// Spend time differentiating monsters, have some with stronger attacks and weaker defenses, etc.
// 5th button - it isn't an attack, it will randomly give you another monster, but keep your health -10 points. Tell user which monster it has switched. Make it randomly pick new monster, if its the same monster as before then go again. Computer can't do this.
// save all monster defeated count in NSUserDefault.
// have sixth button that, when clicked, allows you to buy 5 different items. Each has name and price in the title. You use monster defeated number as money, which can buy some of those items. Have 5 NSUserDefaults that are BOOLs - dont create a custom class.
@end
