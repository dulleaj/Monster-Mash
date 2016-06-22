//
//  StatsViewController.m
//  Monster Mash
//
//  Created by Andrew Dulle on 6/15/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import "StatsViewController.h"
#import "RIPViewController.h"
#import "Monsters.h"

@interface StatsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *monsterStatsPic;
@property (weak, nonatomic) IBOutlet UILabel *monsterStatsName;
@property (weak, nonatomic) IBOutlet UILabel *monsterStatsHealth;
@property Monsters* monster;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.monster = [[Monsters alloc] init];

    [self.monster monsterRoster:self.statsMonsterInt and:self.statsUserWinCount];
    
    self.monsterStatsName.text = self.monster.name;
    self.monsterStatsHealth.text = [NSString stringWithFormat:@"Health: %d", self.monster.health];
    
    NSString* pic = self.monster.monsterFrontImages[0];
    self.monsterStatsPic.image = [UIImage imageNamed:pic];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    RIPViewController* transition = segue.destinationViewController;
    
    transition.ripDefeatedMonsterList = self.statsDefeatedMonsterList;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
