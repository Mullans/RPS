//
//  rpsBrain.m
//  RPS
//
//  Created by Sean Mullan on 1/19/15.
//  Copyright (c) 2015 SilentLupin. All rights reserved.
//

#import "rpsBrain.h"
#define THRESHOLD 5
@implementation rpsBrain

- (instancetype)init
{
    self = [super init];
    if (self) {
        history = [[NSMutableArray alloc]initWithCapacity:10];
        greyMatter = [[NSMutableDictionary alloc]initWithCapacity:10];
        total = [[NSMutableArray alloc]initWithCapacity:THRESHOLD];
        for(int i=0;i<THRESHOLD;i++){
            [total addObject:[NSNumber numberWithInt:0]];
        }
    }
    return self;
}

-(BOOL)addToBrain:(int) newData{
    NSNumber *data = [NSNumber numberWithInt:newData];
    int issueNum=0;
    [history addObject:data];
    for (int i=1;i<MIN([history count],THRESHOLD);i++){
//        NSLog(@"%i, %i, %i",[total[i]])
        total[i]=[NSNumber numberWithInteger:[total[i] integerValue]+1];//issue here probably
        NSString *keyString = [[history subarrayWithRange:NSMakeRange(history.count - (1+i), i)]description];
        if ([greyMatter objectForKey:keyString]) {

            NSInteger current = [[greyMatter valueForKey:keyString] integerValue]+1;
            [greyMatter setValue:[NSNumber numberWithInteger:current] forKey:keyString];
            
        }else{
            [greyMatter setValue:[NSNumber numberWithInt:1] forKey:keyString];
        }
    }
    return true;
}

-(int)getChoice{
    NSLog(@"AMAZING");
    if ([history count]>2){
        NSLog(@"issue0");
        NSMutableArray *choiceArray = [[NSMutableArray alloc]initWithCapacity:THRESHOLD*3];
        NSLog(@"issue2");
        //create array of values
        NSLog(@"issue in here?");
        for (int i = 0; i<MIN([history count],THRESHOLD);i++){
            NSArray *baseArray = [history subarrayWithRange:NSMakeRange(history.count - (1+i), i)];
            for (int j=0;j<3;j++){
                @autoreleasepool {
                    NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:baseArray];
                    [temp addObject:[NSNumber numberWithInt:j]];
                    NSString *keyString = [temp description];
                    choiceArray[i+(j*THRESHOLD)]= [NSNumber numberWithFloat:([[greyMatter objectForKey:keyString]floatValue]/[total[i]floatValue])];
                }
            }
        }
        int rock = 0;
        int paper = 0;
        int scissors = 0;
        for (int i=0;i<THRESHOLD;i++){
            rock += (1/THRESHOLD)*[choiceArray[i]floatValue];
            paper += (1/THRESHOLD)*[choiceArray[i+1*THRESHOLD]floatValue];
            scissors += (1/THRESHOLD)*[choiceArray[i+2*THRESHOLD]floatValue];
        }
        int likelyPlayerChoice = MAX(MAX(rock,paper),scissors);
        return ((likelyPlayerChoice+1)%3);
    }else if([history count]==1){
        return ([history[0]integerValue]+1)%3;
    }else{
        return arc4random_uniform(3);
    }
    return 0;
    //check each depth (each layer getting more weight as you go deeper? think on that later)
    //for each depth, get odds of next result
    //return result that would beat that
}
@end
