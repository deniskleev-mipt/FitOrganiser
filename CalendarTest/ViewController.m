

#import "ViewController.h"
#import "CalendarCollectionManager.h"
#import "CalendarObjectsGenerator.h"
#import "OVCollectionViewLayout.h"
#import "DetailsDayTableManager.h"
#import "CalendarObject.h"
#import "EXAddNotesViewController.h"
#import "NoteObject.h"
#import <CoreData/CoreData.h>
#import "GoodCell.h"

#import "EditTableViewController.h"

@interface ViewController () <CalendarCollectionManagerDelegate, EXAddNotesViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *spaceCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)CalendarCollectionManager *collectionViewManager;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)DetailsDayTableManager *tableViewManager; 
@property (strong, nonatomic)NSArray *items;
@property (strong, nonatomic)CalendarObject *currentCalendarObject;
@property (assign, nonatomic)NSInteger currentDateIndex;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation ViewController {
    NSInteger selectedDay;
    NSInteger selectedMonth;
    NSInteger selectedYear;

    
    NSInteger dayOfWeekToday;
    
    
    UILabel *noDataLabel;
    __weak IBOutlet UIView *backgroundViewForAddButton;
    
    int nowSelectedrow;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditTask"]) {
        NSLog(@".............prepareForSegue");
        //Title change//
        EditTableViewController *upcoming = segue.destinationViewController;
        
        nowSelectedrow = [self.myTableView indexPathForSelectedRow].row;
        
        int iskomiyIndex = 0;
        for (int i = 0; i < self.contactArray.count; i++) {
            if ([self.contactArray[i] valueForKey:@"name"] == [[self.array4Today objectAtIndex:nowSelectedrow] valueForKey:@"name"]) {
                iskomiyIndex = i;
               // return;
            }
        }
    
        
        NSLog(@"ЧОС: %@", [[self.array4Today objectAtIndex:nowSelectedrow] valueForKey:@"name"]);
        
        NSManagedObject *selectedDevice = [self.contactArray objectAtIndex:iskomiyIndex];
        
        
        
        EditTableViewController *destViewController = segue.destinationViewController;
        destViewController.contactdb = selectedDevice;
    }
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void) update1 { // обновить полную_БД
    
    NSManagedObjectContext *managedObjectContext1 = [self managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"EntityTask"];
    self.contactArray = [[managedObjectContext1 executeFetchRequest:fetchRequest1 error:nil] mutableCopy];
    
    // была закомментирована
    
    [self doFormArray4Today];
    [self.myTableView reloadData];
}


- (void) doFormArray4Today {
    
    [self.array4Today removeAllObjects];
    
    //self.array4Today = nil;
    
    
    // dayOfWeekToday — не обязательно сегодняшняя дата, м.б. и другая кликнутая !
    
    NSString *stringToday;
    if (dayOfWeekToday == 1) {
        stringToday = @"ponedelnik";
    } else if (dayOfWeekToday == 2) {
        stringToday = @"vtornik";
    } else if (dayOfWeekToday == 3) {
        stringToday = @"sreda";
    } else if (dayOfWeekToday == 4) {
        stringToday = @"chetverg";
    } else if (dayOfWeekToday == 5) {
        stringToday = @"pyatnica";
    } else if (dayOfWeekToday == 6) {
        stringToday = @"subbota";
    } else if (dayOfWeekToday == 7) {
        stringToday = @"voskresenie";
    }
    
    for (int i = 0; i < self.contactArray.count; i++) {
        if (([[self.contactArray[i] valueForKey:stringToday]  isEqual: @"YES"]) || ([[self.contactArray[i] valueForKey:@"dateStart"]  isEqual: [NSString stringWithFormat:@"%d.%d.%d",selectedDay,selectedMonth,selectedYear]])) {
            
            // ФОРМАТ: 17.8.2016
            //
            //
            // ТУТ ДОЛЖНА БЫТЬ ПРОВЕРКА НА ДАТУ
            NSString *taskDateStart = [self.contactArray[i] valueForKey:@"dateStart"];
            NSArray *arr = [taskDateStart componentsSeparatedByString:@"."];
            
            /**/
            NSLog(@"%d",selectedDay);
            NSLog(@"%d",selectedMonth);
            NSLog(@"%d",selectedYear);
            NSLog(@"%d",[arr[0] intValue]);
            NSLog(@"%d",[arr[1] intValue]);
            NSLog(@"%d",[arr[2] intValue]);
            /**/
            
             if  (selectedYear >= [arr[2] intValue]) {
                 if (selectedMonth > [arr[1] intValue]) {
                     [self.array4Today addObject:self.contactArray[i]];
                 }
                 else if (selectedMonth == [arr[1] intValue]) {
                     if (selectedDay >= [arr[0] intValue]) {
                         [self.array4Today addObject:self.contactArray[i]];
                     }
                 }
              }
        }
    }
    
    if (self.array4Today.count > 1) {
        [self sortArray4TodayUsingTime];
    }
    
    [self.myTableView reloadData];
}

- (void) sortArray4TodayUsingTime {
    /*
    NSMutableArray *mutArray4Today = self.array4Today;
    
    NSMutableArray *temp;
    
    while (mutArray4Today.count > 0) {
    
        int min  = 0;
        for (int i = 1; i < mutArray4Today.count; i++) {
            //[mutArray4Today[i] valueForKey:@"timeStart"]
            if () {
                
            }
        }
        
        
    }
    */
    
    
}

-(void) showStats {
    NSLog(@"contactArray.count = %lu",(unsigned long)self.contactArray.count);
    NSLog(@"array4Today.count = %lu",(unsigned long)self.array4Today.count);
}

- (void) viewDidAppear:(BOOL)animated {
    [self showStats];
}

- (IBAction)clickedDoneCell:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    CGRect buttonFrame = [button convertRect:button.bounds toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonFrame.origin];
    
    /*
    if (button.imageView.image == [UIImage imageNamed:@"chek-off_72.png"]) {
        button.imageView.image = [UIImage imageNamed:@"chek-on_72.png"];
    }
    */
    
    GoodCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.nameLabel.text;
    NSLog(@"str = %@",str);
    [self findAndSave:str];
}

- (void) findAndSave: (NSString*) str {
    NSLog(@"findAndSave. str = %@",str);
    
    for (int i= 0; i < self.contactArray.count; i++) {
        if  ([[self.contactArray[i] valueForKey:@"name"]  isEqual: str]) {
            NSLog(@"found");
            
            
            NSManagedObject *selectedDevice = self.contactArray[i];
            NSManagedObjectContext *context = [self managedObjectContext];
            
            // Update existing device
            
            /*
            if ([[self.contactArray[i] valueForKey:@"isClicked"]  isEqual: @"YES"]) {
                [selectedDevice setValue:@"NO" forKey:@"isClicked"];
            } else
                [selectedDevice setValue:@"YES" forKey:@"isClicked"];
            */
            
            NSString *stringOfSelectedDays = [self.contactArray[i] valueForKey:@"stringOfSelectedDays"];
            NSLog(@"1. stringOfSelectedDays = %@",stringOfSelectedDays);
            
            if (stringOfSelectedDays) {
                NSString *thisDay = [NSString stringWithFormat:@"%d.%d.%ld",selectedDay,selectedMonth,selectedYear];
                
                
                NSArray *preDates = [stringOfSelectedDays componentsSeparatedByString:@" "];
                NSMutableArray *dates = [preDates mutableCopy];
                
                BOOL found  = NO;
                for (int i= 0; i < dates.count; i++) {
                    if (dates[i] == thisDay) {
                        found = YES;
                        [dates removeObjectAtIndex:i];
                        
                        
                        stringOfSelectedDays = [dates componentsJoinedByString:@" "];
                        NSLog(@"after deleting... stringOfSelectedDays = %@",stringOfSelectedDays);
                    }
                }
                
                if (!found) {
                    stringOfSelectedDays = [stringOfSelectedDays stringByAppendingString:[NSString stringWithFormat:@" %@",thisDay]];
                }
            }
            else { // == NULL
                NSString *thisDay = [NSString stringWithFormat:@"%d.%d.%d",selectedDay,selectedMonth,selectedYear];
                stringOfSelectedDays = thisDay;
            }
                    
            
            
            NSLog(@"2. stringOfSelectedDays = %@",stringOfSelectedDays);
            
            [selectedDevice setValue:stringOfSelectedDays forKey:@"stringOfSelectedDays"];
            
            
            NSError *error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
            
            /*
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];

            [dict setObject:@"YES" forKey:@"19.8.2016"];
            [dict setObject:@"NO" forKey:@"20.8.2016"];
            
            [selectedDevice setValue:dict forKey:@"array"];
            */
            
            NSLog(@"saved");
            
            [self update1]; // <- включает [self.myTableView reloadData];
            
            return;
        }
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.myTableView.bounds.size.width, self.myTableView.bounds.size.height)];
    noDataLabel.text             = @"Задачи отсутствуют";
    noDataLabel.font=[noDataLabel.font fontWithSize:25];
    noDataLabel.textColor        = [UIColor grayColor];
    noDataLabel.textAlignment    = NSTextAlignmentCenter;
    self.myTableView.backgroundView = noDataLabel;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    noDataLabel.hidden = YES;
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *string = [NSString stringWithFormat:@"T0D4Y %ld.%ld.%ld", (long)day, (long)week, (long)year];
    
    // для проверки на дату
    selectedDay = day;
    selectedMonth = week;
    selectedYear = year;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update1) name:@"DoUpdateTableView" object:nil];
    // выше обновляем Полную_БД и данные в таблице (после добавления новой задачи)
    
    
    NSManagedObjectContext *managedObjectContext1 = [self managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"EntityTask"];
    self.contactArray = [[managedObjectContext1 executeFetchRequest:fetchRequest1 error:nil] mutableCopy];

    //123123123123123123
    for (int i=0; i<self.contactArray.count; i++) {
        NSLog(@"123123123123");
        if ([self.contactArray[i] valueForKey:@"array"]) {
            NSLog(@"нашел");
            NSLog([self.contactArray[i] valueForKey:@"array"][0]);
        }
    }
    
    // Первый заход в контроллер
    CFAbsoluteTime at = CFAbsoluteTimeGetCurrent();
    CFTimeZoneRef tz = CFTimeZoneCopySystem();
    SInt32 WeekdayNumber = CFAbsoluteTimeGetDayOfWeek(at, tz);

    dayOfWeekToday = WeekdayNumber;
    self.array4Today = [[NSMutableArray alloc]init];
    
    [self doFormArray4Today];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"Roboto-Regular" size:19.0f], NSFontAttributeName,
                                                                     [UIColor colorWithRed:(66/255.0) green:(101/255.0) blue:(140/255.0) alpha:1], NSForegroundColorAttributeName,
                                                                     nil, nil,nil]];
    
    self.currentCalendarObject = [CalendarObject new];
   
     [self.collectionView registerNib:[UINib nibWithNibName:@"CalendarCell" bundle:nil] forCellWithReuseIdentifier:@"CalendarCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NoteCell" bundle:nil] forCellReuseIdentifier:@"NoteCell"];
    
   [CalendarObjectsGenerator generateObjectsForDays:14 completionBlockDays:^(id object, NSInteger index, NSError *error) {
       self.currentDateIndex = index;
       if ([object isKindOfClass:[NSArray class]]) {
           self.items = (NSArray*)object;
           [self initialSetup];
       }
    

   }];
    
}


- (void)initialSetup {
    NSLog(@"index my index %ld", (long)self.currentDateIndex);
    CGFloat space = 7;
    OVCollectionViewLayout * customLayot = [[OVCollectionViewLayout alloc] init];
    CGFloat deviceWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat clearWidth = deviceWidth - (7 * space);
    CGFloat widthCell = clearWidth/7.0f;
    customLayot.cellSize = CGSizeMake(widthCell, 60);
    customLayot.sectionSpacing = CGSizeMake(space, 0);
    self.collectionView.collectionViewLayout = customLayot; 

    
    
    self.collectionViewManager = [[CalendarCollectionManager alloc]initWithCollectionView:self.collectionView];
    self.collectionViewManager.delegate = self;
    [self.collectionViewManager setItems:self.items];
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentDateIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
    
    self.tableViewManager = [[DetailsDayTableManager alloc]initWithTableView:self.tableView]; 
}


#pragma mark - Actions
- (IBAction)addTaskButtonClicked:(id)sender {
    [self realAddTask];
}

- (IBAction)addNewTask:(UITapGestureRecognizer *)sender {

    
}

- (void) realAddTask {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"AddTask"];
    controller.delegate = self;
    [controller setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - CalendarCollectionManagerDelegate

- (void)didSelectCalendarObject:(id)item {
    if ([item isKindOfClass:[CalendarObject class]]) {
        
        CalendarObject *object = item;
        self.currentCalendarObject = object;
        [self.tableViewManager setItems:object.notes];
        
      //  NSLog(@"выбранный день недели: %ld",(long)object.numberDaysOfWeek);
        NSLog(@"выбранный день: %@ месяц: %@ год %@",object.year, object.day, object.month);
        
        dayOfWeekToday = object.numberDaysOfWeek;
        selectedDay = [object.day intValue];
        selectedYear = [object.year intValue];
        
        if ([object.month  isEqual: @"авг."]) {
            selectedMonth = 8;
        } else if ([object.month  isEqual: @"сент."]) {
            selectedMonth = 9;
        } else if ([object.month  isEqual: @"окт."]) {
            selectedMonth = 10;
        } else if ([object.month  isEqual: @"нояб."]) {
            selectedMonth = 11;
        } else if ([object.month  isEqual: @"дек."]) {
            selectedMonth = 12;
        } else if ([object.month  isEqual: @"янв."]) {
            selectedMonth = 1;
        } else if ([object.month  isEqual: @"февр."]) {
            selectedMonth = 2;
        } else if ([object.month  isEqual: @"март"]) {
            selectedMonth = 3;
        } else if ([object.month  isEqual: @"апрель"]) {
            selectedMonth = 4;
        } else if ([object.month  isEqual: @"май"]) {
            selectedMonth = 5;
        } else if ([object.month  isEqual: @"июнь"]) {
            selectedMonth = 6;
        } else if ([object.month  isEqual: @"июль"]) {
            selectedMonth = 7;
        }
        
        NSLog(@"блять шамс: %d",selectedMonth);
        
        [self doFormArray4Today];
        
       // [self showStats];
        
        [self.myTableView reloadData];
    }
}

#pragma  mark - EXAddNotesViewControllerDelegate

- (void)notesViewController:(UIViewController *)controller didFinishWithNote:(NSString *)noteString {
    NSLog(@"noteString %@", noteString);
    NoteObject *object = [NoteObject new];
    object.descriptionNote = noteString;
    [self.currentCalendarObject.notes addObject:object];
    [self.tableViewManager setItems:self.currentCalendarObject.notes];
    [controller dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    noDataLabel.hidden = YES;
    
    if (self.array4Today.count == 0) {
        noDataLabel.hidden = NO;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"self.array4Today.count = %lu",(unsigned long)self.array4Today.count);
    
    return self.array4Today.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath");
    GoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.nameLabel.text = @"";
    cell.button.imageView.image = nil;
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",[self.array4Today[indexPath.row] valueForKey:@"name"]];
    
    /*
    if ([[self.array4Today[indexPath.row] valueForKey:@"isClicked"]  isEqual: @"YES"]) {
        NSLog(@"yes from coredata");
        
        [cell.button setImage:[UIImage imageNamed:@"chek-on_72.png"] forState:UIControlStateNormal];
    }
    else //if ([[self.array4Today[indexPath.row] valueForKey:@"isClicked"]  isEqual: @"NO"])
    {
        NSLog(@"no from coredata");
        [cell.button setImage:[UIImage imageNamed:@"chek-off_72.png"] forState:UIControlStateNormal];
    }
     */
    
    [cell.button setImage:[UIImage imageNamed:@"chek-off_72.png"] forState:UIControlStateNormal];
    
    // Узнаем, выполнено ли задание СЕГОДНЯ?
    if ([self.array4Today[indexPath.row] valueForKey:@"stringOfSelectedDays"]) {
        NSString *stringOfSelectedDays = [self.array4Today[indexPath.row] valueForKey:@"stringOfSelectedDays"];
        
        NSArray *dates = [stringOfSelectedDays componentsSeparatedByString:@" "];
        NSString *dayToday = [NSString stringWithFormat:@"%d.%d.%d",selectedDay,selectedMonth,selectedYear];
        for (int i= 0; i < dates.count; i++) {
            if (dates[i] == dayToday) {
                [cell.button setImage:[UIImage imageNamed:@"chek-on_72.png"] forState:UIControlStateNormal];
            }
        }
        
    }
    
    return cell;
 }

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
