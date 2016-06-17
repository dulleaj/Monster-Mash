//
//  StatsViewController.m
//  Monster Mash
//
//  Created by Andrew Dulle on 6/15/16.
//  Copyright © 2016 Andrew Dulle. All rights reserved.
//

#import "StatsViewController.h"

@interface StatsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *monsterStatsPic;
@property (weak, nonatomic) IBOutlet UILabel *monsterStatsName;
@property (weak, nonatomic) IBOutlet UILabel *monsterStatsHealth;
@property (weak, nonatomic) IBOutlet UIButton *backToRip;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString* imageString = self.monsterPicRIP;
    self.monsterStatsPic.image = [UIImage imageNamed:imageString];
    
    self.monsterStatsName.text = [NSString stringWithFormat:@"%@  %@",self.monsterIconRIP, self.monsterNameRIP];
    
    self.monsterStatsHealth.text = [NSString stringWithFormat:@"Health: %d",self.monsterHealthRIP];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToRIPWasPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"backToRIPSegue" sender:self];
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
