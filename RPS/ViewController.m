//
//  ViewController.m
//  RPS
//
//  Created by Sean Mullan on 1/19/15.
//  Copyright (c) 2015 SilentLupin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen]applicationFrame];
    
    choices = @[@"Rock",@"Paper",@"Scissors"];
    results = @[@"Tie",@"NPC Wins",@"You Win"];
    
    wins = 0;
    losses = 0;
    
    motherBrain = [[rpsBrain alloc]init];
    
    resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [resultLabel setText:@"Pick Your Move!"];
    [resultLabel sizeToFit];
    [resultLabel setCenter:CGPointMake(screenSize.size.width/2, screenSize.size.height/5)];
    [self.view addSubview:resultLabel];
    
    scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [scoreLabel setText:@"0 Wins      0 Losses"];
    [scoreLabel sizeToFit];
    [scoreLabel setCenter:CGPointMake(screenSize.size.width/2, screenSize.size.height/2+20)];
    [self.view addSubview:scoreLabel];
    
    computerChoice = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [computerChoice setText:@"Computer is waiting..."];
    [computerChoice sizeToFit];
    [computerChoice setCenter:CGPointMake(screenSize.size.width/2, screenSize.size.height/2)];
    [self.view addSubview:computerChoice];
    
    rockButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rockButton addTarget:self
                   action:@selector(choicePress:)
         forControlEvents:UIControlEventTouchUpInside];
    [rockButton setTitle:@"Rock" forState:UIControlStateNormal];
    rockButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [rockButton sizeToFit];
    [rockButton setCenter:CGPointMake(screenSize.size.width*.25, screenSize.size.height*0.8)];
    [self.view addSubview:rockButton];
    
    paperButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [paperButton addTarget:self
                   action:@selector(choicePress:)
         forControlEvents:UIControlEventTouchUpInside];
    [paperButton setTitle:@"Paper" forState:UIControlStateNormal];
    paperButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [paperButton sizeToFit];
    [paperButton setCenter:CGPointMake(screenSize.size.width*.5, screenSize.size.height*0.8)];
    [self.view addSubview:paperButton];
    
    scissorsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scissorsButton addTarget:self
                   action:@selector(choicePress:)
         forControlEvents:UIControlEventTouchUpInside];
    [scissorsButton setTitle:@"Scissors" forState:UIControlStateNormal];
    scissorsButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [scissorsButton sizeToFit];
    [scissorsButton setCenter:CGPointMake(screenSize.size.width*.75, screenSize.size.height*0.8)];
    [self.view addSubview:scissorsButton];
    
    UIView *right = [[UIView alloc]initWithFrame:CGRectMake(30,screenSize.size.height*0.23,150,150)];
    right.backgroundColor = [UIColor blackColor];
    [self.view addSubview:right];
    
    UIView *left = [[UIView alloc]initWithFrame:CGRectMake(screenSize.size.width-180,screenSize.size.height*0.23,150,150)];
    left.backgroundColor = [UIColor blackColor];
    [self.view addSubview:left];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)choicePress:(id)sender {
    int choice = -1;
    if (sender==rockButton){
        NSLog(@"Rock Button");
        choice = 0;
    }else if(sender==paperButton){
        NSLog(@"Paper Button");
        choice = 1;
    }else if (sender==scissorsButton){
        NSLog(@"Scissors Button");
        choice = 2;
    }
    int npcChoice = [motherBrain getChoice];//issue here
    [motherBrain addToBrain:choice];
    computerChoice.text = choices[npcChoice];
    [computerChoice sizeToFit];
    [computerChoice setCenter:CGPointMake(screenSize.size.width/2, screenSize.size.height/2)];
    
    int result = [self winner:npcChoice :choice];
    if (result==2){wins++;}
    if (result==1){losses++;}
    scoreLabel.text = [NSString stringWithFormat:@"%i Wins      %i Losses",wins,losses];
    [scoreLabel sizeToFit];
    [scoreLabel setCenter:CGPointMake(screenSize.size.width/2, screenSize.size.height/2+20)];
    
    resultLabel.text = results[result];
    [resultLabel sizeToFit];
    [resultLabel setCenter:CGPointMake(screenSize.size.width/2, screenSize.size.height/5)];
    
}

-(int)winner:(int)computer :(int)player{
    if (computer==player){
        return 0;
    }else if(computer==(player+1)%3){
        return 1;
    }else{
        return 2;
    }
}
@end
