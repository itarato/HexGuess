//
//  GameCenterManager.h
//  GuessHex
//
//  Created by Peter Arato on 2/23/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameCenterManager : NSObject {

}

+ (void)authenticateUser;
+ (BOOL)isGameCenterAvailable;
+ (BOOL)isUserAuthenticated;
+ (void)showDefaultErrorAlert;

@end
