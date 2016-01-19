//
//  ViewController.m
//  AreYouBallin
//
//  Created by Michael Moss on 11/21/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "Clothing.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) NSMutableArray *clothings;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clothings = [[NSMutableArray alloc] init];
    [self retrieveMenPantsWithCompletion:^(NSArray *products) {
        self.clothings = [products mutableCopy];
    }];
}

-(void)setClothings:(NSMutableArray *)clothings{
    _clothings = clothings;
    [self.tableView reloadData];
}


- (void)retrieveMenPantsWithCompletion: (void(^)(NSArray *))complete{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http:localhost:3000/secured/womens/pants" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        complete([responseObject objectForKey:@"products"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.clothings.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *testing = [self.clothings objectAtIndex:indexPath.row];
    Clothing *clothing = [[Clothing alloc] initWithDictionary:testing];
    cell.textLabel.text = clothing.name;
    cell.detailTextLabel.text = clothing.itemDescription;
    [clothing getImageWithCompletion:^(NSData *data) {
        UITableViewCell *cellToUpdate = [self.tableView cellForRowAtIndexPath:indexPath];
        if(cellToUpdate){
            cell.imageView.image = [UIImage imageWithData:data];
            [cell layoutSubviews];
        }
    }];
    return cell;
}
@end
