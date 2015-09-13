//
//  ContactVC.m
//  MyChat
//
//  Created by Mac on 15/9/13.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import "ContactVC.h"
#import "XMPPTool.h"
@interface ContactVC ()

@property (nonatomic, strong)NSMutableArray *users;

@end

@implementation ContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUsers];
    
}

- (void)loadUsers{
    NSManagedObjectContext *rosterContext = [XMPPTool shareInsans].rosterStorage.mainThreadManagedObjectContext;
    
    NSFetchRequest *requst = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    requst.sortDescriptors = @[sort];
    NSError *err = nil;
    NSArray * arr = [rosterContext executeFetchRequest:requst error:&err];
    NSLog(@"%@", arr);
    self.users = [NSMutableArray arrayWithArray:arr];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    XMPPUserCoreDataStorageObject *user = self.users[indexPath.row];
    [user addObserver:self forKeyPath:@"sectionNum" options:NSKeyValueObservingOptionNew context:nil];
    
    if ([user.sectionNum isEqualToNumber:@(0)]) {
        cell.detailTextLabel.text = @"在线";
    }
    else if([user.sectionNum isEqualToNumber:@(2)]){
        cell.detailTextLabel.text = @"离线";
    }
    else{
        cell.detailTextLabel.text = @"未知";
    }
    
    cell.textLabel.text = user.displayName;
    return cell;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray *indexArr = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"q",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",];
    return indexArr;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [self.tableView reloadData];
}
@end
