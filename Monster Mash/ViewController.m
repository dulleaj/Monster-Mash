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

@property (weak, nonatomic) IBOutlet UIButton *helpButton;

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
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property int nextButtonTally;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

@property (weak, nonatomic) IBOutlet UILabel *helpButtonLabel;


@property (weak, nonatomic) IBOutlet UIImageView *fightBackground;

@property NSTimer* userTurnsAround;

@property NSTimer* oppFlinchTime;
@property NSTimer* userFlinchTime;
@property NSTimer* userLevelsUp;
@property NSTimer* homeMovementTime;
@property int currentImageCount;

@property (weak, nonatomic) IBOutlet UILabel *yourMonsterLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelUpPic;
@property (weak, nonatomic) IBOutlet UILabel *levelUpLabel;

@property BOOL level2AnimationWasViewed;
@property BOOL level3AnimationWasViewed;

@property int winCount;
@property int lossCount;
@property int currentLevel;
@property (weak, nonatomic) IBOutlet UILabel *currentLevelLabel;

@property (weak, nonatomic) IBOutlet UIButton *homeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    self.oppHealth.hidden = YES;
    self.userHealth.hidden = YES;
    self.levelUpLabel.hidden = YES;
    self.helpButton.hidden = YES;
    self.helpButtonLabel.hidden = YES;
    self.nextButton.hidden = YES;
    self.previousButton.hidden = YES;
    [self hideUserButtons];
    
    [self setLevel];
    [self setCashAmount];
    [self viewCashAmount];
    
    NSString* userImage = [NSString stringWithFormat:@"5L%d",self.currentLevel];
    self.levelUpPic.image = [UIImage imageNamed: userImage];
    
    [self userGoesHome:YES];
    
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
    
    self.oppFlinchTime = [[NSTimer alloc] init];
    self.userFlinchTime = [[NSTimer alloc] init];
    
    self.currentLevelLabel.hidden = YES;
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
    self.levelUpPic.hidden = YES;
    self.yourMonsterLabel.hidden = YES;
    [self unhideUserButtons];
}




// GENERATING MONSTERS AND THEIR ANIMATIONS________________________________________________________________

// GENERATE USER MONSTER
- (void)generateUserMonster {
    
    self.user = [[Monsters alloc] init];
    [self.user monsterRoster:5 and:self.winCount];
    self.userName.text = self.user.name;
    
    if (self.juggernautItemIsOwned == YES) {
        self.user.health += 50;
    }
    
    self.userHealth.text = [NSString stringWithFormat:@"%d",self.user.health];
    self.userElement.text = self.user.element;
    
    self.userTurnsAround = [[NSTimer alloc] init];

    NSString* userPicString = self.user.monsterFrontImages [0];
    self.userPic.image = [UIImage imageNamed: userPicString];
    
    [self userImageDidAppear:YES];

    [self.attack1 setTitle: self.user.attack1.attackName forState:UIControlStateNormal];
    [self.attack2 setTitle: self.user.attack2.attackName forState:UIControlStateNormal];
    [self.attack3 setTitle: self.user.attack3.attackName forState:UIControlStateNormal];
    [self.attack4 setTitle: self.user.attack4.attackName forState:UIControlStateNormal];
}



// TURN AROUND TIMER IS CALLED
- (void)userImageDidAppear:(BOOL)animated{
    
    self.userTurnsAround = [NSTimer scheduledTimerWithTimeInterval:1
    target:self
    selector:@selector(changeImageForTurn)
    userInfo:nil
    repeats:NO];
}

// SELECTOR FOR TURN AROUND TIMER
- (void)changeImageForTurn {
    
    NSString* userPicString = self.user.monsterBackImages [0];
    self.userPic.image = [UIImage imageNamed: userPicString];

    [self.userTurnsAround invalidate];
    self.userTurnsAround = 0;
}

// USER IS HURT, FLINCH TIMER IS SET
- (void)userMonsterFlinches {
    
    self.userFlinchTime = [NSTimer scheduledTimerWithTimeInterval:0.07
                            target:self
                            selector:@selector(changeUserMonsterFlinchImage)
                            userInfo:nil
                            repeats:YES];
}

// SELECTOR FOR FLINCH TIMER
- (void)changeUserMonsterFlinchImage {
    
    self.currentImageCount += 1;
    
    NSString* userPicString = self.user.monsterBackImages[self.currentImageCount];
    self.userPic.image = [UIImage imageNamed: userPicString];
    
    if (self.currentImageCount >= 4){
        
        [self invalidateTimer:self.userFlinchTime];
        userPicString = self.user.monsterBackImages[0];
        self.userPic.image = [UIImage imageNamed: userPicString];
    }
}



// GENERATE OPP MONSTER
- (void) generateOppMonster {
    
    self.opp = [[Monsters alloc] init];
    [self.opp monsterRoster: arc4random_uniform(5) and:self.winCount];
    self.oppName.text = self.opp.name;
    self.oppHealth.text = [NSString stringWithFormat:@"%d",self.opp.health];
    self.oppPic.image = [UIImage imageNamed: self.opp.monsterFrontImages[0]];
    self.oppElement.text = self.opp.element;
}

// OPP IS HURT, TIMER IS SET FOR FLINCHING
- (void)oppMonsterFlinches {
    
    self.oppFlinchTime = [NSTimer scheduledTimerWithTimeInterval: 0.07
                                                          target:self
                                                        selector:@selector(changeOppMonsterFlinchImage)
                                                        userInfo:nil
                                                         repeats:YES];
}

// SELECTOR FOR OPP FLINCH TIMER
- (void)changeOppMonsterFlinchImage {
    
    self.currentImageCount += 1;
    
    NSString* oppPicString = self.opp.monsterFrontImages[self.currentImageCount];
    self.oppPic.image = [UIImage imageNamed: oppPicString];
    
    if (self.currentImageCount >= 4){
        
        [self invalidateTimer:self.oppFlinchTime];
        oppPicString = self.opp.monsterFrontImages[0];
        self.oppPic.image = [UIImage imageNamed:oppPicString];
        
    }
}


// LEVEL CHANGE: DETERMINING LEVEL UP STAGE AND STARTING LEVEL UP ANIMATION
- (void)levelUpAnimation {
    
    [self hideEverythingOnFightScreen];
    [self hideUserButtons];
    self.userLevelsUp = [NSTimer scheduledTimerWithTimeInterval: 0.5
                                                         target:self
                                                       selector:@selector(changeLevelUpImage)
                                                       userInfo:nil
                                                        repeats:YES];
}

// SELECTOR FOR LEVEL UP TIMER
- (void)changeLevelUpImage {
    
    self.currentImageCount += 1;
    
    if ((self.currentImageCount == 2) || (self.currentImageCount == 4) || (self.currentImageCount == 6)){
        
        self.fightBackground.image = [UIImage imageNamed:@"LevelUp1"];
        
        int oldLevel = self.currentLevel - 1;
        NSString* oldLevelImage = [NSString stringWithFormat:@"5L%d",oldLevel];
        self.levelUpPic.image = [UIImage imageNamed: oldLevelImage];
        self.levelUpLabel.hidden = YES;
        
    }else{
        
        self.fightBackground.image = [UIImage imageNamed:@"LevelUp2"];
        
        NSString* newLevelImage = [NSString stringWithFormat:@"5L%d",self.currentLevel];
        self.levelUpPic.image = [UIImage imageNamed: newLevelImage];
        self.levelUpLabel.text = [NSString stringWithFormat:@"MONSTER LEVEL %d",self.currentLevel];
        self.levelUpLabel.hidden = NO;
    }
    
    self.levelUpPic.hidden = NO;
    
    if (self.currentImageCount >= 12){
        
        [self invalidateTimer:self.userLevelsUp];
        self.levelUpPic.hidden = YES;
        self.levelUpLabel.hidden = YES;
        self.fightBackground.image = [UIImage imageNamed:@"monstersBackground"];
        
        [self viewItemsStock];
        [self generateUserMonster];
        [self generateOppMonster];
        [self unhideEverythingOnFightScreen];
        
    }
}


// HOME TIMER IS CALLED
- (void)userGoesHome:(BOOL)animated{
    
    [self setLevel];
    self.startButton.hidden = NO;
    self.levelUpPic.hidden = NO;
    self.yourMonsterLabel.hidden = NO;
    self.currentLevelLabel.hidden = NO;
    
    self.homeMovementTime = [NSTimer scheduledTimerWithTimeInterval:0.25
                                                            target:self
                                                          selector:@selector(changeImageForHome)
                                                          userInfo:nil
                                                           repeats:YES];
}

// SELECTOR FOR HOME TIMER
- (void)changeImageForHome {
 
    self.currentImageCount += 1;
    
    NSString* userPicString = [NSString stringWithFormat:@"5L%d_H%d",self.currentLevel,self.currentImageCount];
    self.levelUpPic.image = [UIImage imageNamed: userPicString];
    
    if (self.currentImageCount >= 2){
        
        [self invalidateTimer:self.homeMovementTime];
    }
}


// ANY TIMER CAN BE INVALIDATED
- (void)invalidateTimer: (NSTimer*)whichTimer {
    
    [whichTimer invalidate];
    self.currentImageCount = 0;
    whichTimer = nil;
}



// ATTACKS_________________________________________________________________________________________________

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



// USER ATTACKS OPP
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
        
        [self oppMonsterFlinches];
        
        [self.continueButton setTitle:[NSString stringWithFormat:@"You attacked %@, doing %d damage.", self.opp.name, damage] forState:UIControlStateNormal];
    }
    
    if (self.opp.health <= 0) {
        
        self.oppHealth.hidden = YES;
    
    }
    
    [self hideUserButtons];
    
    self.continueButton.hidden = NO;
}



// IF OPP IS STILL ALIVE, IT ATTACKS WHEN THIS IS PRESSED
- (IBAction)afterContinueButtonWasPressed:(id)sender {
    
    self.continueButton.hidden = YES;
    [self.continueButton setTitle:nil forState: UIControlStateNormal];
    
    if (self.opp.health > 0) {
        
        [self computerAttacks];
        
    } else if (self.opp.health <= 0){
        
        [self oppLoses];
        
    }
    
}

// OPP ATTACKS USER
- (void)computerAttacks{
    
    int randomAttackInt = arc4random_uniform(4)+1;
    
    int potentialDamage = [self.opp monsterAttack:randomAttackInt];
    
    int damage = [self.user adjustDamage: potentialDamage monsterThatAttacked: self.opp];
    
    self.userHealth.text = [NSString stringWithFormat:@"%d", self.user.health];
    
    if (damage == 0) {
        
        [self.retaliateButton setTitle:[NSString stringWithFormat:@"%@'s attack missed you!", self.opp.name] forState:UIControlStateNormal];
        
    }else{
        
        [self userMonsterFlinches];
        
        [self.retaliateButton setTitle:[NSString stringWithFormat:@"%@ attacked you, doing %d damage.", self.opp.name, damage] forState:UIControlStateNormal];
    }
    
    if (self.user.health <= 0) {
        
        self.userHealth.hidden = YES;
    }
    
    self.retaliateButton.hidden = NO;
}

// IF YOU'RE STILL ALIVE, THIS SETS UP YOUR TURN
- (IBAction)afterRetaliateButtonWasPressed:(id)sender {
    
    self.retaliateButton.hidden = YES;
    [self.retaliateButton setTitle: nil forState: UIControlStateNormal];
    
    if (self.user.health > 0) {
        
        [self unhideUserButtons];
        
    } else if (self.user.health <= 0) {
        
        [self userLoses];
    }
}

// AFTER YOU HIT THE RESTART BUTTON
- (IBAction)afterRestartButtonWasPressed:(id)sender {
    
    [self.restartButton setTitle: nil forState: UIControlStateNormal];
    self.restartButton.hidden = YES;
    
    self.fightBackground.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ((self.winCount == 20) && (self.level2AnimationWasViewed == NO)){
        
        [self levelUpAnimation];
        self.level2AnimationWasViewed = YES;
        self.defaults = [NSUserDefaults standardUserDefaults];
        [self.defaults setBool:YES forKey:@"Animation 2 Viewed"];
        [self.defaults synchronize];
        
    } else if ((self.winCount == 50) && (self.level3AnimationWasViewed == NO)){
        
        [self levelUpAnimation];
        self.level3AnimationWasViewed = YES;
        self.defaults = [NSUserDefaults standardUserDefaults];
        [self.defaults setBool:YES forKey:@"Animation 3 Viewed"];
        [self.defaults synchronize];
        
    } else {
    
        [self viewItemsStock];
        [self generateUserMonster];
        [self generateOppMonster];
        [self unhideEverythingOnFightScreen];
    }
}




// HELP WITH THE GAME______________________________________________________________________________________

// USER PRESSES HELP BUTTON
- (IBAction)helpButtonWasPressed:(id)sender {
    
    [self hideEverythingOnFightScreen];
    [self disableUserButtons];
    self.nextButton.hidden = NO;
    self.previousButton.hidden = NO;
    self.backToFightButton.hidden = NO;
    self.fightBackground.alpha = 0.3;
    self.helpButtonLabel.text = @"Welcome to MONSTER MASH! You and the computer attack each other in turns, until one Monster's health is depleted.";
    self.helpButtonLabel.hidden = NO;
}

// WHEN YOU NEED TO GO BACK A PAGE IN THE HELP SECTIONS
- (IBAction)previousButtonWasPressed:(id)sender {
    
    if (self.nextButtonTally > 0){
        self.nextButtonTally -= 1;
        [self helpButtonStages];
    }
}


// NEXT BUTTON WAS PRESSED FOR MORE INSTRUCTIONS
- (IBAction)nextButtonWasPressed:(id)sender {
    
    self.nextButtonTally += 1;
    [self helpButtonStages];
}


- (void)helpButtonStages {
    
    if (self.nextButtonTally == 0){
        
        [self hideEverythingOnFightScreen];

        self.helpButtonLabel.text = @"Welcome to MONSTER MASH! You and the computer attack each other in turns, until one Monster's health is depleted.";
        
    }else if (self.nextButtonTally == 1) {
        
        [self hideEverythingOnFightScreen];
        self.attack1.hidden = NO;
        self.attack2.hidden = NO;
        self.attack3.hidden = NO;
        self.attack4.hidden = NO;
        
        self.helpButtonLabel.text = @"Use your attack buttons to damage your opponent. The first/top attack is your Monster's weakest attack, but will always land.";
    
    }else if (self.nextButtonTally == 2) {
        
        [self hideEverythingOnFightScreen];
        self.attack1.hidden = NO;
        self.attack2.hidden = NO;
        self.attack3.hidden = NO;
        self.attack4.hidden = NO;
        
        self.helpButtonLabel.text = @"Attack strength increases as you go down the list, but the probability of landing the attack varies inversely.";
        
        
    }else if (self.nextButtonTally == 3) {
        
        [self hideEverythingOnFightScreen];

        self.cashButton.hidden = NO;
        
        self.doubleTapsTitle = @"⚡︎";
        self.doubleTapButton.hidden = NO;
       
        self.healthPacksTitle = @"✚";
        self.healthPacksButton.hidden = NO;

        self.crushAttacksTitle = @"☠";
        self.crushButton.hidden = NO;
        
        self.helpButtonLabel.text = @"As you win fights, you'll earn cash - which can be redeemed for perks/items to help you fight your opponents. Click on the green cash button to view the";

    }else if (self.nextButtonTally == 4) {
        
        [self hideEverythingOnFightScreen];
        
        self.cashButton.hidden = NO;
        
        self.doubleTapsTitle = @"⚡︎";
        self.doubleTapButton.hidden = NO;
        
        self.healthPacksTitle = @"✚";
        self.healthPacksButton.hidden = NO;
        
        self.crushAttacksTitle = @"☠";
        self.crushButton.hidden = NO;
        
        self.helpButtonLabel.text = @"store and your current cash levels.Once you have items in stock, they will show up as small buttons above your attack buttons.";
    
    }else if (self.nextButtonTally == 5) {
        
        [self hideEverythingOnFightScreen];
        
        self.oppPic.hidden = NO;
        self.oppHealth.hidden = NO;
        self.oppElement.hidden = NO;
        self.oppName.hidden = NO;
        
        self.helpButtonLabel.text = @"Underneath your opponent, you'll notice an element symbol, a number representing the Monster's health, and the Monster's name.";
    
    }else if (self.nextButtonTally == 6) {
        
        [self hideEverythingOnFightScreen];
        
        self.oppPic.hidden = NO;
        self.oppHealth.hidden = NO;
        self.oppElement.hidden = NO;
        self.oppName.hidden = NO;
        
        self.helpButtonLabel.text = @"The element symbol represents what type of Monster you're fighting, which affects how your attacks and defense will perform.";
        
    }else if (self.nextButtonTally == 7) {
        
        [self hideEverythingOnFightScreen];
        
        self.oppPic.hidden = NO;
        self.oppHealth.hidden = NO;
        self.oppElement.hidden = NO;
        self.oppName.hidden = NO;
        
        self.helpButtonLabel.text = @"Fire Monsters are strong against Ice Monsters, but weak against Water Monsters. Ice monsters are strong against Water Monsters, but";
    
    }else if (self.nextButtonTally == 8) {
        
        [self hideEverythingOnFightScreen];
        
        self.oppPic.hidden = NO;
        self.oppHealth.hidden = NO;
        self.oppElement.hidden = NO;
        self.oppName.hidden = NO;
        
        self.helpButtonLabel.text = @"weak against Fire Monsters, and Water Monsters are strong against Fire Monsters, but weak against Ice Monsters.";
    
    }else if (self.nextButtonTally == 9) {
        
        [self hideEverythingOnFightScreen];
        
        self.helpButtonLabel.text = @"As you win fights, your opponents become stronger, but your monster will level up. Level 2 is reached at 20 wins, and level 3 is reached at 50 wins.";

    }else if (self.nextButtonTally == 10) {
        
        self.helpButtonLabel.text = @"Icons made by Freepik from www.flaticon.com. Now, get back to the FIGHT!";
        self.nextButton.hidden = YES;
        self.previousButton.hidden = YES;
        
    }else{
        
        [self hideEverythingOnFightScreen];
        self.backToFightButton.hidden = NO;
    }
}

- (IBAction)homeButtonWasPressed:(id)sender {
    
    [self hideEverythingOnFightScreen];
    
    [self viewCashAmount];
    
    NSString* userImage = [NSString stringWithFormat:@"5L%d",self.currentLevel];
    self.levelUpPic.image = [UIImage imageNamed: userImage];
    [self userGoesHome:YES];
}


// CASH AND STORE__________________________________________________________________________________________

// SHOW CASH LEVEL AND STORE ITEMS
- (IBAction)cashButtonWasPressed:(id)sender {
    
    [self viewItemsStock];
    [self viewCashAmount];
    
    [self hideEverythingOnFightScreen];
    
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
    self.availableCashLabel.hidden = NO;
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

// SHOULD HEALTH PACK BE VISIBLE
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
        
        self.doubleTapsTitle = [NSString stringWithFormat:@"⚡︎: %d",self.doubleTaps];
        
        [self.doubleTapButton setTitle: self.doubleTapsTitle forState: UIControlStateNormal];
        
        [self updateItemsStock];
    }
}

// DOUBLE TAP WAS USED
- (IBAction)doubleTapButtonWasPressed:(id)sender {
    
    [self oppMonsterFlinches];

    self.doubleTaps -= 1;
    
    self.opp.health -= 15;
    
    self.doubleTapsTitle = [NSString stringWithFormat:@"⚡︎: %d",self.doubleTaps];
    
    [self shouldDoubleTapButtonBeVisible];
    
    self.oppHealth.text = [NSString stringWithFormat:@"%d", self.opp.health];

    [self updateItemsStock];
    
    if (self.opp.health <= 0){
        
        [self oppLoses];
    }
}

// SHOULD DOUBLE TAP BUTTON BE VISIBLE
- (void)shouldDoubleTapButtonBeVisible {
    
    if (self.doubleTaps == 0) {
        
        self.doubleTapButton.hidden = YES;
        
    } else if (self.doubleTaps > 0) {
        
        self.doubleTapButton.hidden = NO;
        
        [self.doubleTapButton setTitle: self.doubleTapsTitle forState: UIControlStateNormal];
    }
}



// BUTTON 3 - HEALTH CASE WAS BOUGHT
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



// BUTTON 4 - CRUSH BUTTON WAS BOUGHT
- (IBAction)storeItem4WasPressed:(id)sender {
    
    if (self.cash >= 150) {
        
        self.crushAttacks += 1;
        
        self.cash -= 150;
        
        [self setCashAmount];
        
        [self viewCashAmount];
        
        self.crushAttacksTitle = [NSString stringWithFormat:@"☠: %d",self.crushAttacks];
        
        [self.crushButton setTitle: self.crushAttacksTitle forState: UIControlStateNormal];
        
        [self updateItemsStock];
    }
}

// CRUSH BUTTON WAS USED
- (IBAction)crushButtonWasTapped:(id)sender {

    [self oppMonsterFlinches];
    
    self.crushAttacks -= 1;
    
    self.opp.health -= 75;
    
    self.crushAttacksTitle = [NSString stringWithFormat:@"☠: %d",self.crushAttacks];
    
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



// JUGGERNAUT ITEM IS BOUGHT
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
    }
}


// WINNING, LOSING, SAVING THE GAME________________________________________________________________________

// SET LEVEL
- (void)setLevel{
    
    if(self.winCount < 20){
        self.currentLevel = 1;
        
    }else if ((self.winCount >= 20) && (self.winCount < 50)){
        self.currentLevel = 2;
        
    }else if (self.winCount >= 50){
        self.currentLevel = 3;
    }
}


// USER WINS
- (void)oppLoses {
    
    self.view.backgroundColor = [UIColor greenColor];
    self.fightBackground.alpha = 0.5;
    
    self.cash += 10;
    self.winCount +=1;
    
    [self setLevel];
    [self setCashAmount];
    [self viewCashAmount];
    
    [self hideUserButtons];
    self.oppHealth.hidden = YES;
    
    [self.restartButton setTitle:[NSString stringWithFormat:@"You defeated %@!", self.opp.name] forState:UIControlStateNormal];
    self.restartButton.hidden = NO;
}

// USER LOSES
- (void)userLoses {
    
    self.view.backgroundColor = [UIColor redColor];
    self.fightBackground.alpha = 0.5;
    
    self.cash -= 10;
    self.lossCount +=1;
    [self setCashAmount];
    [self viewCashAmount];
    
    [self hideUserButtons];
    self.userHealth.hidden = YES;
    
    [self.restartButton setTitle:[NSString stringWithFormat:@"You were defeated  by %@!", self.opp.name] forState:UIControlStateNormal];
    self.restartButton.hidden = NO;
}

// SET CASH, WINS, LOSSES, LEVEL
- (void)setCashAmount {
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.defaults setInteger:self.cash forKey:@"Money"];
    [self.defaults setInteger:self.winCount forKey:@"Wins"];
    [self.defaults setInteger:self.lossCount forKey:@"Losses"];
    [self.defaults setInteger:self.currentLevel forKey:@"Level"];
    [self.defaults synchronize];
}

// LOAD CASH, WINS, LOSSES, LEVEL, LEVEL ANIMATIONS
- (void)viewCashAmount {
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.cash = (int)[self.defaults integerForKey:@"Money"];
    self.winCount = (int)[self.defaults integerForKey:@"Wins"];
    self.lossCount = (int)[self.defaults integerForKey:@"Losses"];
    self.currentLevel = (int)[self.defaults integerForKey:@"Level"];
    self.level2AnimationWasViewed = [self.defaults boolForKey:@"Animation 2 Viewed"];
    self.level3AnimationWasViewed = [self.defaults boolForKey:@"Animation 3 Viewed"];
    
    self.availableCashLabel.text = [NSString stringWithFormat:@"Total Cash: $%d",self.cash];
    self.currentLevelLabel.text = [NSString stringWithFormat:@"User Level: %d, Total Wins: %d",self.currentLevel, self.winCount];
}


// UPDATE ITEM QUANTITIES
- (void)updateItemsStock {
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.defaults setInteger:self.healthPacks forKey:@"Health Packs"];
    [self.defaults setInteger:self.doubleTaps forKey:@"Double Taps"];
    [self.defaults setInteger:self.crushAttacks forKey:@"Crush Attacks"];
    [self.defaults synchronize];
}


// LOAD ITEM QUANTITIES
- (void)viewItemsStock {
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.healthPacks = (int)[self.defaults integerForKey:@"Health Packs"];
    self.healthPacksTitle = [NSString stringWithFormat:@"✚ : %d",self.healthPacks];
    
    self.doubleTaps = (int)[self.defaults integerForKey:@"Double Taps"];
    self.doubleTapsTitle = [NSString stringWithFormat:@"⚡︎: %d",self.doubleTaps];
    
    self.crushAttacks = (int)[self.defaults integerForKey:@"Crush Attacks"];
    self.crushAttacksTitle = [NSString stringWithFormat:@"☠: %d",self.crushAttacks];
    
    self.juggernautItemIsOwned = [self.defaults boolForKey:@"Juggernaut"];
    
    if (self.juggernautItemIsOwned == YES){
        
        self.storeItem5.backgroundColor = [UIColor grayColor];
    }
    
    [self shouldHealthPacksBeVisible];
    [self shouldDoubleTapButtonBeVisible];
    [self shouldCrushButtonBeVisible];
}

// METHODS FOR HIDING/UNHIDING AND CHANGING SCREENS________________________________________________________

// ONLY HIDE USER BUTTONS
- (void)hideUserButtons {
    
    self.crushButton.hidden = YES;
    self.doubleTapButton.hidden = YES;
    self.cashButton.hidden = YES;
    self.healthPacksButton.hidden = YES;
    self.attack1.hidden = YES;
    self.attack2.hidden = YES;
    self.attack3.hidden = YES;
    self.attack4.hidden = YES;
    self.helpButton.hidden = YES;
    self.homeButton.hidden = YES;
}
// UNHIDE USER BUTTONS
- (void)unhideUserButtons {
    
    self.oppHealth.hidden = NO;
    self.userHealth.hidden = NO;
    self.cashButton.hidden = NO;
    self.attack1.hidden = NO;
    self.attack2.hidden = NO;
    self.attack3.hidden = NO;
    self.attack4.hidden = NO;
    self.helpButton.hidden = NO;
    self.homeButton.hidden = NO;
    [self shouldCrushButtonBeVisible];
    [self shouldHealthPacksBeVisible];
    [self shouldDoubleTapButtonBeVisible];
}


// WHEN YOU NEED TO HIDE EVERYTHING ON THE FIGHT SCREEN, BUTTONS ARE INCLUDED FROM SEPARATE METHOD
- (void)hideEverythingOnFightScreen {
    
    self.oppPic.hidden = YES;
    self.oppName.hidden = YES;
    self.userPic.hidden = YES;
    self.userName.hidden = YES;
    self.continueButton.hidden = YES;
    self.retaliateButton.hidden = YES;
    self.restartButton.hidden = YES;
    self.oppElement.hidden = YES;
    self.userElement.hidden = YES;
    self.oppHealth.hidden = YES;
    self.userHealth.hidden = YES;
    [self hideUserButtons];
}


// WHEN YOU NEED TO UNHIDE EVERYTHING ON THE FIGHT SCREEN, BUTTONS ARE INCLUDED FROM SEPARATE METHOD
- (void)unhideEverythingOnFightScreen {
    
    self.oppPic.hidden = NO;
    self.oppName.hidden = NO;
    self.userPic.hidden = NO;
    self.userName.hidden = NO;
    self.oppElement.hidden = NO;
    self.userElement.hidden = NO;
    self.fightBackground.image = [UIImage imageNamed:@"monstersBackground"];
    [self unhideUserButtons];
}

// USER FIGHT BUTTONS ARE ENABLED
- (void)enableUserButtons {
    
    self.attack1.enabled = YES;
    self.attack2.enabled = YES;
    self.attack3.enabled = YES;
    self.attack4.enabled = YES;
    self.cashButton.enabled = YES;
    self.doubleTapButton.enabled = YES;
    self.healthPacksButton.enabled = YES;
    self.crushButton.enabled = YES;
    self.helpButton.enabled = YES;
    self.homeButton.enabled = YES;
}

// USER FIGHT BUTTONS ARE DISABLED
- (void)disableUserButtons {
 
    self.attack1.enabled = NO;
    self.attack2.enabled = NO;
    self.attack3.enabled = NO;
    self.attack4.enabled = NO;
    self.cashButton.enabled = NO;
    self.doubleTapButton.enabled = NO;
    self.healthPacksButton.enabled = NO;
    self.crushButton.enabled = NO;
    self.helpButton.enabled = NO;
    self.homeButton.enabled = NO;
}

// RETURN TO FIGHT BUTTON WAS PRESSED FROM STORE
- (IBAction)backToFightButtonWasPressed:(id)sender {
    
    [self viewCashAmount];
    [self viewItemsStock];
    [self enableUserButtons];
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
    self.nextButton.hidden = YES;
    self.previousButton.hidden = YES;
    self.nextButtonTally = 0;
    self.helpButtonLabel.hidden = YES;
    self.fightBackground.alpha = 1;
    [self unhideEverythingOnFightScreen];
}


@end
