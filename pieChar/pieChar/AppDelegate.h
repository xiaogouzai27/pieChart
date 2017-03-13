//
//  AppDelegate.h
//  pieChar
//
//  Created by everp2p on 17/3/13.
//  Copyright © 2017年 TangLiHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

