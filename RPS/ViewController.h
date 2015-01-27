//
//  ViewController.h
//  RPS
//
//  Created by Sean Mullan on 1/19/15.
//  Copyright (c) 2015 SilentLupin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rpsBrain.h"

@interface ViewController : UIViewController{
    NSArray *choices;
    NSArray *results;
    UILabel *resultLabel;
    UILabel *computerChoice;
    UIButton *rockButton;
    UIButton *paperButton;
    UIButton *scissorsButton;
    rpsBrain *motherBrain;
    
    CGRect screenSize;
    
}
-(int)winner:(int)computer :(int)player;

@end

