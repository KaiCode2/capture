//
//  AppDelegate.h
//  capture
//
//  Created by kai don aldag on 2014-08-18.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)UITabBarController *tabBarController;

@property(strong, nonatomic)NSPersistentStoreCoordinator *psc;
@property(strong, nonatomic)NSManagedObjectContext *moc;

-(void)saveContext;

@end
