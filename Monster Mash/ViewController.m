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
@property int damageUserDoesToOpp;
@property int damageOppDoesToUser;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *retaliateButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UILabel *oppElement;
@property (weak, nonatomic) IBOutlet UILabel *userElement;
@property int cash;
@property NSUserDefaults* defaults;
@property (weak, nonatomic) IBOutlet UIButton *replaceMonsterButton;
@property (weak, nonatomic) IBOutlet UIButton *cashButton;
@property (weak, nonatomic) IBOutlet UIButton *storeItem1;
@property (weak, nonatomic) IBOutlet UILabel *storeItem1Label;

@property (weak, nonatomic) IBOutlet UIButton *storeItem2;
@property (weak, nonatomic) IBOutlet UILabel *storeItem2Label;

@property (weak, nonatomic) IBOutlet UIButton *storeItem3;
@property (weak, nonatomic) IBOutlet UILabel *storeItem3Label;

@property (weak, nonatomic) IBOutlet UIButton *storeItem4;
@property (weak, nonatomic) IBOutlet UILabel *storeItem4Label;

@property (weak, nonatomic) IBOutlet UIButton *storeItem5;
@property (weak, nonatomic) IBOutlet UILabel *storeItem5Label;

@property (weak, nonatomic) IBOutlet UILabel *availableCashLabel;

@property int healthPacks;
@property NSString* healthPacksTitle;
@property (weak, nonatomic) IBOutlet UIButton *healthPacksButton;

@property int doubleTaps;
@property NSString* doubleTapsTitle;
@property (weak, nonatomic) IBOutlet UIButton *doubleTapButton;

@property int crushAttacks;
@property NSString* crushAttacksTitle;
@property (weak, nonatomic) IBOutlet UIButton *crushButton;

@property BOOL juggernautItemIsOwned;

@property (weak, nonatomic) IBOutlet UIButton *backToFightButton;

@property (weak, nonatomic) IBOutlet UIImageView *fightBackground;

@property NSArray* TurnAroundImages;
@property NSTimer* UserTurnsAround;

@property NSArray* oppFlinchesImages;
@property NSTimer* flinchTime;
@property int currentImageCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.startButton.hidden = NO;
    self.oppPic.hidden = YES;
    self.oppName.hidden = YES;
    self.userPic.hidden = YES;
    self.userName.hidden = YES;
    self.continueButton.hidden = YES;
    self.retaliateButton.hidden = YES;
    self.restartButton.hidden = YES;
    self.oppElement.hidden = YES;
    self.userElement.hidden = YES;
    self.storeItem1.hidden = YES;
    self.storeItem2.hidden = YES;
    self.storeItem3.hidden = YES;
    self.storeItem4.hidden = YES;
    self.storeItem5.hidden = YES;
    self.storeItem1Label.hidden = YES;
    self.storeItem2Label.hidden = YES;
    self.storeItem3Label.hidden = YES;
    self.storeItem4Label.hidden = YES;
    self.storeItem5Label.hidden = YES;
    self.availableCashLabel.hidden = YES;
    self.backToFightButton.hidden = YES;
    self.fightBackground.alpha = 0.3;
    self.oppHealth.hidden = YES;
    self.userHealth.hidden = YES;
    [self hideUserButtons];
    
    [self viewCashAmount];

    [self.storeItem1 setTitle:@"+1 Health Pack" forState: UIControlStateNormal];
    [self.storeItem2 setTitle:@"+1 Double Tap" forState: UIControlStateNormal];
    [self.storeItem3 setTitle:@"+1 Health Case" forState: UIControlStateNormal];
    [self.storeItem4 setTitle:@"+1 Crush Button" forState: UIControlStateNormal];
    [self.storeItem5 setTitle:@"Juggernaut" forState: UIControlStateNormal];
 
    self.storeItem1Label.text = [NSString stringWithFormat:@"$50 - Adds 15 pts to user heatlh."];
    self.storeItem2Label.text = [NSString stringWithFormat:@"$50 - Removes 15 pts from opponents heatlh."];
    self.storeItem3Label.text = [NSString stringWithFormat:@"$125 - 3 Health Packs."];
    self.storeItem4Label.text = [NSString stringWithFormat:@"$150 - Removes 75 pts from opponents heatlh."];
    self.storeItem5Label.text = [NSString stringWithFormat:@"$500 - Adds 50 pts to health and 10 pts to each attack."];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// START BUTTON
- (IBAction)startButtonWasTapped:(id)sender {
    
    self.defeatedMonsters = [[NSMutableArray alloc] init];
    
    [self viewItemsStock];
    
    [self generateOppMonster];
    
    [self generateUserMonster];
    
    self.flinchTime = [[NSTimer alloc] init]; //new
    
    self.startButton.hidden = YES;
    self.oppPic.hidden = NO;
    self.oppName.hidden = NO;
    self.userPic.hidden = NO;
    self.userName.hidden = NO;
    self.continueButton.hidden = YES;
    self.retaliateButton.hidden = YES;
    self.restartButton.hidden = YES;
    self.oppElement.hidden = NO;
    self.userElement.hidden = NO;
    self.fightBackground.alpha = 1;
    [self unhideUserButtons];

    
}

// GENERATING A MONSTER FOR THE USER
- (void)generateUserMonster {
    
    self.user = [[Monsters alloc] init];
    [self.user monsterRoster];
    self.userName.text = self.user.name;
    
    if (self.juggernautItemIsOwned == YES) {
        self.user.health += 50;
    }
    
    self.userHealth.text = [NSString stringWithFormat:@"%d",self.user.health];
    self.userElement.text = self.user.element;
    
    self.UserTurnsAround = [[NSTimer alloc] init];

    NSString* userPicString = self.user.monsterFrontImages [0];
    self.userPic.image = [UIImage imageNamed: userPicString];
    
    [self userImageDidAppear:YES];

    [self.attack1 setTitle: self.user.attack1.attackName forState:UIControlStateNormal];
    [self.attack2 setTitle: self.user.attack2.attackName forState:UIControlStateNormal];
    [self.attack3 setTitle: self.user.attack3.attackName forState:UIControlStateNormal];
    [self.attack4 setTitle: self.user.attack4.attackName forState:UIControlStateNormal];
    
    
}

// TIMER IS CALLED
- (void)userImageDidAppear:(BOOL)animated{
    
    self.UserTurnsAround = [NSTimer scheduledTimerWithTimeInterval:2
    target:self
    selector:@selector(changeImage)
    userInfo:nil
    repeats:NO];
    
}

// TIMER SELECTOR POINTS TO
- (void)changeImage {
    
    NSString* userPicString = self.user.monsterBackImages [0];
    self.userPic.image = [UIImage imageNamed: userPicString];

    [self.UserTurnsAround invalidate];

}

// GENERATING A MONSTER FOR THE COMPUTER
- (void) generateOppMonster {
    
    self.opp = [[Monsters alloc] init];
    [self.opp monsterRoster];
    self.oppName.text = self.opp.name;
    self.oppHealth.text = [NSString stringWithFormat:@"%d",self.opp.health];
    self.oppPic.image = [UIImage imageNamed: self.opp.monsterFrontImages[0]];
    self.oppElement.text = self.opp.element;
    
}

// ATTACK BUTTON 1
- (IBAction)attack1ButtonPressed:(id)sender {
    
    [self userAttack:1];
    
}

// ATTACK BUTTON 2
- (IBAction)attack2ButtonPressed:(id)sender {
    
    [self userAttack:2];
    
}

// ATTACK BUTTON 3
- (IBAction)attack3ButtonPressed:(id)sender {
    
    [self userAttack:3];

}

// ATTACK BUTTON 4
- (IBAction)attack4ButtonPressed:(id)sender {

    [self userAttack:4];
    
}

// METHOD FOR ATTACKING COMPUTER
- (void)userAttack:(int)attackNumber{
    
    int potential = [self.user monsterAttack:attackNumber];
    
    if (self.juggernautItemIsOwned == YES) {
        
        potential += 10;
        
    }
    
    int damage = [self.opp adjustDamage: potential  monsterThatAttacked: self.user];
    
    self.oppHealth.text = [NSString stringWithFormat:@"%d",self.opp.health];
    
    if (damage == 0) {
        
        [self.continueButton setTitle:[NSString stringWithFormat:@"Your attack missed %@!", self.opp.name] forState:UIControlStateNormal];
        
    }else{
        
        [self oppFlinches];
        
        [self.continueButton setTitle:[NSString stringWithFormat:@"You attacked %@, doing %d damage.", self.opp.name, damage] forState:UIControlStateNormal];
    }
    
    if (self.opp.health <= 0) {
        
        self.oppHealth.hidden = YES;
    }
    
    [self hideUserButtons];
    
    self.continueButton.hidden = NO;
    
}

//http://stackoverflow.com/questions/15806492/change-array-of-images-with-nstimer
- (void)oppFlinches {
    
    self.oppFlinchesImages = @[[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.opp.monsterInt]],[UIImage imageNamed:[NSString stringWithFormat:@"%dF1",self.opp.monsterInt]],[UIImage imageNamed:[NSString stringWithFormat:@"%dF2",self.opp.monsterInt]],[UIImage imageNamed:[NSString stringWithFormat:@"%dF3",self.opp.monsterInt]],[UIImage imageNamed:[NSString stringWithFormat:@"%dF4",self.opp.monsterInt]]];

    
    self.flinchTime = [NSTimer scheduledTimerWithTimeInterval:.05
                            target:self
                            selector:@selector(changeOppFlinchImage)
                            userInfo:nil
                            repeats:YES];
    
}

//http://stackoverflow.com/questions/15806492/change-array-of-images-with-nstimer
- (void)changeOppFlinchImage {
    
    self.currentImageCount += 1;
        
    NSInteger currentIndex = [self.oppFlinchesImages indexOfObject:self.oppPic.image];
    NSInteger nextIndex    = (currentIndex + 1) % self.oppFlinchesImages.count;

    self.oppPic.image = self.oppFlinchesImages[nextIndex];
    
    if (self.currentImageCount >= 4){
     
        [self invalidateOppFlinch];
         
    }
}

- (void)invalidateOppFlinch {
        
    [self.flinchTime invalidate];
    self.currentImageCount = 0;
    self.flinchTime = nil;
    self.oppPic.image = self.oppFlinchesImages[0];
    
}

// AFTER HITTING CONTINUE, THE COMPUTER ATTACKS
- (IBAction)afterContinueButtonWasPressed:(id)sender {
    
    self.continueButton.hidden = YES;
    [self.continueButton setTitle:nil forState: UIControlStateNormal];
    
    if (self.opp.health > 0) {
        
        [self computerAttacks];
        
    } else if (self.opp.health <= 0){
        
        [self oppLoses];
        
    }
    
}

// METHOD FOR THE COMPUTER ATTACKING
- (void)computerAttacks{
    
    int randomAttackInt = arc4random_uniform(4)+1;
    
    int potentialDamage = [self.opp monsterAttack:randomAttackInt];
    
    int damage = [self.user adjustDamage: potentialDamage monsterThatAttacked: self.opp];
    
    self.userHealth.text = [NSString stringWithFormat:@"%d", self.user.health];
    
    if (damage == 0) {
        
        [self.retaliateButton setTitle:[NSString stringWithFormat:@"%@'s attack missed you!", self.opp.name] forState:UIControlStateNormal];
        
    }else{
        
        [self.retaliateButton setTitle:[NSString stringWithFormat:@"%@ attacked you, doing %d damage.", self.opp.name, damage] forState:UIControlStateNormal];
        
    }
    
    if (self.user.health <= 0) {
        
        self.userHealth.hidden = YES;
        
    }
    
    self.retaliateButton.hidden = NO;
    
}

// SETS UP YOUR TURN IF YOU'RE STILL ALIVE
- (IBAction)afterRetaliateButtonWasPressed:(id)sender {
    
    self.retaliateButton.hidden = YES;
    [self.retaliateButton setTitle: nil forState: UIControlStateNormal];
    
    if (self.user.health > 0) {
        
        [self unhideUserButtons];
        
    } else if (self.user.health <= 0) {
        
        [self hideUserButtons];
        self.oppHealth.hidden = YES;
        self.userHealth.hidden = YES;
        
        self.view.backgroundColor = [UIColor redColor];
        
        [self.restartButton setTitle:[NSString stringWithFormat:@"You have been defeated by %@!", self.opp.name] forState:UIControlStateNormal];
        
        self.restartButton.hidden = NO;
        
    }
    
}

// AFTER YOU HIT THE RESTART BUTTON
- (IBAction)afterRestartButtonWasPressed:(id)sender {
    
    [self viewItemsStock];
    
    self.restartButton.hidden = YES;
    [self.restartButton setTitle: nil forState: UIControlStateNormal];
    
    self.oppHealth.hidden = NO;
    
    if (self.view.backgroundColor == [UIColor greenColor]) {
        
        self.user.health = 100;
        
        self.userHealth.text = [NSString stringWithFormat:@"%d",self.user.health];
        
        [self generateOppMonster];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self unhideUserButtons];
        
    } else if (self.view.backgroundColor == [UIColor redColor]) {
        
        [self generateOppMonster];
        
        [self generateUserMonster];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self unhideUserButtons];
        
    }
    
}

// USER REPLACES MONSTER
- (IBAction)replacementButtonWasPressed:(id)sender {
        
    int previousDamage = [self.user replacementMonsterHealthAdjustment: self.user.health originalMonsterHealth:self.user];
       
    [self generateUserMonster];
    
    self.user.health -= previousDamage;
    
    self.userHealth.text = [NSString stringWithFormat:@"%d", self.user.health];
        
    if (self.user.health <= 0) {
        
        [self hideUserButtons];
        
        self.view.backgroundColor = [UIColor redColor];
        
        self.restartButton.hidden = NO;
        
        [self.restartButton setTitle:[NSString stringWithFormat:@"You have been defeated by %@!", self.opp.name] forState:UIControlStateNormal];
        
    }
    
}

// USER CHECKS ON CASH LEVEL
- (IBAction)cashButtonWasPressed:(id)sender {
    
    self.startButton.hidden = YES;
    self.oppPic.hidden = YES;
    self.oppName.hidden = YES;
    self.userPic.hidden = YES;
    self.userName.hidden = YES;
    self.continueButton.hidden = YES;
    self.retaliateButton.hidden = YES;
    self.restartButton.hidden = YES;
    self.oppElement.hidden = YES;
    self.userElement.hidden = YES;
    self.storeItem1.hidden = NO;
    self.storeItem2.hidden = NO;
    self.storeItem3.hidden = NO;
    self.storeItem4.hidden = NO;
    self.storeItem5.hidden = NO;
    self.storeItem1Label.hidden = NO;
    self.storeItem2Label.hidden = NO;
    self.storeItem3Label.hidden = NO;
    self.storeItem4Label.hidden = NO;
    self.storeItem5Label.hidden = NO;
    self.backToFightButton.hidden = NO;
    self.fightBackground.alpha = 0.3;
    self.oppHealth.hidden = YES;
    self.userHealth.hidden = YES;
    [self hideUserButtons];
    
    [self viewCashAmount];
    self.availableCashLabel.hidden = NO;
    
}

// USER RETURNS BACK TO FIGHT
- (IBAction)backToFightButtonWasPressed:(id)sender {
    
    self.startButton.hidden = YES;
    self.oppPic.hidden = NO;
    self.oppName.hidden = NO;
    self.userPic.hidden = NO;
    self.userName.hidden = NO;
    self.continueButton.hidden = YES;
    self.retaliateButton.hidden = YES;
    self.restartButton.hidden = YES;
    self.oppElement.hidden = NO;
    self.userElement.hidden = NO;
    self.storeItem1.hidden = YES;
    self.storeItem2.hidden = YES;
    self.storeItem3.hidden = YES;
    self.storeItem4.hidden = YES;
    self.storeItem5.hidden = YES;
    self.storeItem1Label.hidden = YES;
    self.storeItem2Label.hidden = YES;
    self.storeItem3Label.hidden = YES;
    self.storeItem4Label.hidden = YES;
    self.storeItem5Label.hidden = YES;
    self.backToFightButton.hidden = YES;
    self.availableCashLabel.hidden = YES;
    self.fightBackground.alpha = 1;
    [self unhideUserButtons];
    

}



// BUTTON 1 - HEALTH PACK WAS ADDED
- (IBAction)storeItem1WasPressed:(id)sender {
    
    if (self.cash >= 50) {
    
        self.healthPacks += 1;
        
        self.cash -= 50;
    
        [self setCashAmount];
        
        [self viewCashAmount];
        
        self.healthPacksTitle = [NSString stringWithFormat:@"✚: %d",self.healthPacks];
        
        [self.healthPacksButton setTitle: self.healthPacksTitle forState: UIControlStateNormal];
    
        [self updateItemsStock];
        
    }

}

// HEALTH PACK WAS USED
- (IBAction)healthPacksButtonWasPressed:(id)sender {
    
    self.healthPacks -= 1;
    
    self.user.health += 15;
    
    self.healthPacksTitle = [NSString stringWithFormat:@"✚: %d",self.healthPacks];
    
    [self shouldHealthPacksBeVisible];
    
    self.userHealth.text = [NSString stringWithFormat:@"%d", self.user.health];
    
    [self updateItemsStock];
    
}

// SHOULD HEALTH BUTTON BE VISIBLE
- (void)shouldHealthPacksBeVisible {
    
    if (self.healthPacks == 0) {
        
        self.healthPacksButton.hidden = YES;
        
    } else if (self.healthPacks > 0) {
        
        self.healthPacksButton.hidden = NO;
        
        [self.healthPacksButton setTitle: self.healthPacksTitle forState: UIControlStateNormal];
        
    }
    
}




// BUTTON 2 - DOUBLE TAP WAS ADDED
- (IBAction)storeItem2WasPressed:(id)sender {
    
    if (self.cash >= 50) {
        
        self.doubleTaps += 1;
        
        self.cash -= 50;
        
        [self setCashAmount];
        
        [self viewCashAmount];
        
        self.doubleTapsTitle = [NSString stringWithFormat:@"2Taps: %d",self.doubleTaps];
        
        [self.doubleTapButton setTitle: self.doubleTapsTitle forState: UIControlStateNormal];
        
        [self updateItemsStock];
        
    }

}

// DOUBLE TAP WAS USED
- (IBAction)doubleTapButtonWasPressed:(id)sender {

    self.doubleTaps -= 1;
    
    self.opp.health -= 15;
    
    self.doubleTapsTitle = [NSString stringWithFormat:@"2Taps: %d",self.doubleTaps];
    
    [self shouldDoubleTapButtonBeVisible];
    
    self.oppHealth.text = [NSString stringWithFormat:@"%d", self.opp.health];

    [self updateItemsStock];
    
    if (self.opp.health <= 0){
        
        [self oppLoses];
        
    }
    
}

// SHOULD THE DOUBLE TAP BUTTON BE VISIBLE
- (void)shouldDoubleTapButtonBeVisible {
    
    if (self.doubleTaps == 0) {
        
        self.doubleTapButton.hidden = YES;
        
    } else if (self.doubleTaps > 0) {
        
        self.doubleTapButton.hidden = NO;
        
        [self.doubleTapButton setTitle: self.doubleTapsTitle forState: UIControlStateNormal];
        
    }
    
}



// BUTTON 3 - HEALTH CASE WAS ADDED
- (IBAction)storeItem3WasPressed:(id)sender {
    
    if (self.cash >= 125) {
        
        self.healthPacks += 3;
        
        self.cash -= 125;
        
        [self setCashAmount];
        
        [self viewCashAmount];
        
        self.healthPacksTitle = [NSString stringWithFormat:@"✚: %d",self.healthPacks];
        
        [self.healthPacksButton setTitle: self.healthPacksTitle forState: UIControlStateNormal];
        
        [self updateItemsStock];
        
    }
    
}



// BUTTON 4 - CRUSH BUTTON WAS ADDED
- (IBAction)storeItem4WasPressed:(id)sender {
    
    if (self.cash >= 150) {
        
        self.crushAttacks += 1;
        
        self.cash -= 150;
        
        [self setCashAmount];
        
        [self viewCashAmount];
        
        self.crushAttacksTitle = [NSString stringWithFormat:@"Crush: %d",self.crushAttacks];
        
        [self.crushButton setTitle: self.crushAttacksTitle forState: UIControlStateNormal];
        
        [self updateItemsStock];
        
    }
    
}

// CRUSH BUTTON WAS USED
- (IBAction)crushButtonWasTapped:(id)sender {

    self.crushAttacks -= 1;
    
    self.opp.health -= 75;
    
    self.crushAttacksTitle = [NSString stringWithFormat:@"Crush: %d",self.crushAttacks];
    
    [self shouldCrushButtonBeVisible];
    
    self.oppHealth.text = [NSString stringWithFormat:@"%d", self.opp.health];
    
    [self updateItemsStock];
    
    if (self.opp.health <= 0){
        
        [self oppLoses];
        
    }
    
}

// SHOULD CRUSH BUTTON BE VISIBLE
- (void)shouldCrushButtonBeVisible {
    
    if (self.crushAttacks == 0) {
        
        self.crushButton.hidden = YES;
        
    } else if (self.crushAttacks > 0) {
        
        self.crushButton.hidden = NO;
        
        [self.crushButton setTitle: self.crushAttacksTitle forState: UIControlStateNormal];
        
    }

}




- (IBAction)storeItem5WasPressed:(id)sender {
    
    if ((self.juggernautItemIsOwned == NO) && (self.cash >= 500)) {
        
        self.juggernautItemIsOwned = YES;
        
        self.cash -= 500;
        
        [self setCashAmount];
        
        [self viewCashAmount];
        
        self.defaults = [NSUserDefaults standardUserDefaults];
        [self.defaults setBool:YES forKey:@"Juggernaut"];
        [self.defaults synchronize];

        self.storeItem5.backgroundColor = [UIColor grayColor];
        
        // FIND WAY TO SHOW ITEM IS OWNED
    }
    
}



// SET CASH
- (void)setCashAmount {
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.defaults setInteger:self.cash forKey:@"HighScore"];
    [self.defaults synchronize];
    
}

// LOAD CASH
- (void)viewCashAmount {
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.cash = (int)[self.defaults integerForKey:@"HighScore"];
    self.availableCashLabel.text = [NSString stringWithFormat:@"Total Cash: $%d",self.cash];
    
}

// UPDATE ITEM QUANTITIES
- (void)updateItemsStock {
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.defaults setInteger:self.healthPacks forKey:@"Health Packs"];
    [self.defaults synchronize];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.defaults setInteger:self.doubleTaps forKey:@"Double Taps"];
    [self.defaults synchronize];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.defaults setInteger:self.crushAttacks forKey:@"Crush Attacks"];
    [self.defaults synchronize];
    
}

// LOAD ITEM QUANTITIES
- (void)viewItemsStock {
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.healthPacks = (int)[self.defaults integerForKey:@"Health Packs"];
    self.healthPacksTitle = [NSString stringWithFormat:@"✚ : %d",self.healthPacks];
    
    self.doubleTaps = (int)[self.defaults integerForKey:@"Double Taps"];
    self.doubleTapsTitle = [NSString stringWithFormat:@"2Taps: %d",self.doubleTaps];
    
    self.crushAttacks = (int)[self.defaults integerForKey:@"Crush Attacks"];
    self.crushAttacksTitle = [NSString stringWithFormat:@"Crush: %d",self.crushAttacks];
    
    [self.defaults boolForKey:@"Juggernaut"];
    
    [self shouldHealthPacksBeVisible];
    [self shouldDoubleTapButtonBeVisible];
    [self shouldCrushButtonBeVisible];
    
}

// Opp Loses
- (void)oppLoses {
        
        self.cash += 10;
        
        [self setCashAmount];
        
        self.oppHealth.hidden = YES;
    
        [self hideUserButtons];
        
        self.view.backgroundColor = [UIColor greenColor];
        
        self.restartButton.hidden = NO;
        
        [self.restartButton setTitle:[NSString stringWithFormat:@"You defeated %@!", self.opp.name] forState:UIControlStateNormal];
    
}

- (void)hideUserButtons {
    
    self.crushButton.hidden = YES;
    self.doubleTapButton.hidden = YES;
    self.cashButton.hidden = YES;
    self.healthPacksButton.hidden = YES;
    self.attack1.hidden = YES;
    self.attack2.hidden = YES;
    self.attack3.hidden = YES;
    self.attack4.hidden = YES;
    self.replaceMonsterButton.hidden = YES;
    
}

- (void)unhideUserButtons {
    
    self.oppHealth.hidden = NO;
    self.userHealth.hidden = NO;
    self.cashButton.hidden = NO;
    self.attack1.hidden = NO;
    self.attack2.hidden = NO;
    self.attack3.hidden = NO;
    self.attack4.hidden = NO;
    self.replaceMonsterButton.hidden = NO;
    [self shouldCrushButtonBeVisible];
    [self shouldHealthPacksBeVisible];
    [self shouldDoubleTapButtonBeVisible];
    
}



// need to fix snaps teeth

// needs a streak button. If streak gets higher than 10, add 50 to opponents health. If it gets higher to 20, add 100 to opponents health.

// add screen that allows user to pick their character.

// need a page that explans everything

// make a hide screen method
@end
