//
//  RIPViewController.m
//  Monster Mash
//
//  Created by Andrew Dulle on 6/7/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import "ViewController.h"
#import "RIPViewController.h"
#import "RIPTableViewCell.h"
#import "Monsters.h"
#import "StatsViewController.h"

@interface RIPViewController ()
@property (weak, nonatomic) IBOutlet UITableView *killTableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property RIPTableViewCell* cell;
@property Monsters* monster;
@property StatsViewController* nextViewMonster;
@property int nextViewMonsterInt;

@end

@implementation RIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.killTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.monster = [[Monsters alloc] init];
    
    int monsterInt = [[self.ripDefeatedMonsterList objectAtIndex:indexPath.row] intValue];
    
    [self.monster monsterRoster:monsterInt and:self.ripUserWinCount];
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"defeatedMonster" forIndexPath:indexPath];
    
    self.cell.textLabel.text = self.monster.name;
    
    NSString* pic = self.monster.monsterFrontImages[0];
    self.cell.imageView.image = [UIImage imageNamed:pic];
    
    return self.cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.ripDefeatedMonsterList.count;
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.nextViewMonsterInt = [[self.ripDefeatedMonsterList objectAtIndex:indexPath.row] intValue];
    
    [self performSegueWithIdentifier:@"fromRIPToStats" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"fromRIPToStats"]){
        
        StatsViewController* transition = segue.destinationViewController;
        
        transition.statsMonsterInt = self.nextViewMonsterInt;
        
        transition.statsUserWinCount = self.ripUserWinCount;
        
        transition.statsDefeatedMonsterList = self.ripDefeatedMonsterList;
        
    }else if ([segue.identifier isEqualToString:@"fromRIPtoHome"]) {
        
        ViewController* transition = segue.destinationViewController;
        
        transition.homeDefeatedMonsterList = self.ripDefeatedMonsterList;
    }
}


@end
