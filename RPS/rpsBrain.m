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
        total[i]=[NSNumber numberWithFloat:[total[i] integerValue]+1];//issue here probably
//        NSString *keyString = [[history subarrayWithRange:NSMakeRange(history.count - (1+i), i)]description];
        NSString *keyString = [[[history subarrayWithRange:NSMakeRange(history.count - (1+i), i)] valueForKey:@"description"] componentsJoinedByString:@""];
        if ([greyMatter objectForKey:keyString]) {

            NSInteger current = [[greyMatter valueForKey:keyString] floatValue]+1;
            [greyMatter setValue:[NSNumber numberWithInteger:current] forKey:keyString];
            
        }else{
            [greyMatter setValue:[NSNumber numberWithInt:1] forKey:keyString];
        }
    }
    return true;
}

-(int)getChoice{
    if ([history count]>2){
        NSMutableArray *choiceArray = [[NSMutableArray alloc]initWithCapacity:THRESHOLD*3];
        for(int i=0; i<THRESHOLD*3;i++){
            [choiceArray addObject:[NSNumber numberWithFloat:0]];
        }
        //create array of values
        for (int i = 0; i<MIN([history count],THRESHOLD-1);i++){
            NSArray *baseArray = [history subarrayWithRange:NSMakeRange(history.count - (1+i), i)];
            for (int j=0;j<3;j++){
                NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:baseArray];
                [temp addObject:[NSNumber numberWithInt:j]];
//                NSString *keyString = [temp description];
                NSString *keyString = [[temp valueForKey:@"description"] componentsJoinedByString:@""];
                float storedValue = [[greyMatter objectForKey:keyString]floatValue];
                int divisor = [total[i+1]intValue];
                if (divisor==0){
                    choiceArray[i+(j*THRESHOLD)] = [NSNumber numberWithFloat:0];
                }else{
                    choiceArray[i+(j*THRESHOLD)]= [NSNumber numberWithFloat:(storedValue/divisor)];
                }
            }
        }
        float rock = 0;
        float paper = 0;
        float scissors = 0;
        float one = 1;
        for (int i=0;i<THRESHOLD;i++){
            float j = (float)(i+1);
            NSLog(@"i %i r %f p %f s %f",i,(one/THRESHOLD)*[choiceArray[i]floatValue],(one/THRESHOLD)*[choiceArray[i+1*THRESHOLD]floatValue],(one/THRESHOLD)*[choiceArray[i+2*THRESHOLD]floatValue]);
            rock += j*(one/THRESHOLD)*[choiceArray[i]floatValue];
            paper += j*(one/THRESHOLD)*[choiceArray[i+1*THRESHOLD]floatValue];
            scissors += j*(one/THRESHOLD)*[choiceArray[i+2*THRESHOLD]floatValue];
        }
        NSLog(@"r %f p %f s %f",rock,paper,scissors);
        int likelyPlayerChoice = (int)MAX(MAX(rock,paper),scissors);
        if (rock>paper){
            if (rock>scissors){
                return 1;
            }else{
                return 0;
            }
        }else{
            if (paper>scissors){
                return 2;
            }else{
                return 0;
            }
        }
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
