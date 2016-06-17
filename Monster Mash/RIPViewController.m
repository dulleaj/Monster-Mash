//
//  RIPViewController.m
//  Monster Mash
//
//  Created by Andrew Dulle on 6/7/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import "RIPViewController.h"
#import "RIPTableViewCell.h"
#import "Monsters.h"
#import "StatsViewController.h"

@interface RIPViewController ()
@property (weak, nonatomic) IBOutlet UITableView *killTableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property RIPTableViewCell* cell;
@property Monsters* monster;


@end

@implementation RIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //[self.killTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.monster = [[Monsters alloc] init];
    
    int intFromDefeatedArray = [[self.defeatedMonsterList objectAtIndex:indexPath.row] intValue];
    
    [self.monster monsterRoster:intFromDefeatedArray and:self.userWinCount];
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"defeatedMonster" forIndexPath:indexPath];
    
    self.cell.textLabel.text = self.monster.name;
    
    NSString* imageString = self.monster.monsterFrontImages[0];
    self.cell.imageView.image = [UIImage imageNamed:imageString];
    
    return self.cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.defeatedMonsterList.count;
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self performSegueWithIdentifier:@"statsSegue" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    StatsViewController* transition = segue.destinationViewController;
    
    transition.monsterPicRIP = self.monster.monsterFrontImages[0];
    transition.monsterIconRIP = self.monster.element;
    transition.monsterNameRIP = self.monster.name;
    transition.monsterHealthRIP = self.monster.health;

}


@end
