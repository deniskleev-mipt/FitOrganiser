//
//  AppDelegate.h
//  CalendarTest
//
//  Created by Владимир Воробьев on 27.07.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong,nonatomic) UIImage *image;
@property (strong,nonatomic) NSString *min;
@property (strong,nonatomic) NSString *max;

@property (strong,nonatomic) NSString *ponedelnik;
@property (strong,nonatomic) NSString *vtornik;
@property (strong,nonatomic) NSString *sreda;
@property (strong,nonatomic) NSString *chetverg;
@property (strong,nonatomic) NSString *pyatnica;
@property (strong,nonatomic) NSString *subbota;
@property (strong,nonatomic) NSString *voskresenie;



@property (strong,nonatomic) NSString *firstTimeOpened;

@property (strong,nonatomic) NSString *lastweight; //  для pop-up изменения веса

//((AppDelegate*)[[UIApplication sharedApplication] delegate]).toChangeExistingWeight

@property (strong,nonatomic) NSString *toChangeExistingWeight; //bool

@property (strong,nonatomic) NSString *toEdit; 


@end

