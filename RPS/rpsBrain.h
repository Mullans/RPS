//
//  rpsBrain.h
//  RPS
//
//  Created by Sean Mullan on 1/19/15.
//  Copyright (c) 2015 SilentLupin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface rpsBrain : NSObject{
    NSMutableArray* history;
    NSMutableDictionary* greyMatter;
    NSMutableArray *total;
}

-(BOOL)addToBrain:(int)newData;
-(int)getChoice;
@end
