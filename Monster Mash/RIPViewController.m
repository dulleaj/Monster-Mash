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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.monster = [[Monsters alloc] init];
    
    int intFromDefeatedArray = [[self.defeatedMonsterList objectAtIndex:indexPath.row] intValue];
    
    [self.monster monsterRoster:intFromDefeatedArray and:1];
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"defeatedMonster" forIndexPath:indexPath];
    
    self.cell.textLabel.text = self.monster.name;
    
    NSString* imageString = self.monster.monsterFrontImages[0];
    self.cell.imageView.image = [UIImage imageNamed:imageString];
    
    return self.cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.defeatedMonsterList.count;
    
}


@end
