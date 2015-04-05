//
//  AppDelegate.h
//  FiksGataMi
//
//  Created by Alexander Alemayhu on 31/03/15.
//  Copyright (c) 2015 Alexander Alemayhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void) storeDetails:(NSString *) fullname email:(NSString *)email;
-(NSString *) valueForKey:(NSString *)key;

@end

