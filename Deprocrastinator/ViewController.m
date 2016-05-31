//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Mohamed Ayadi on 5/31/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property NSMutableArray *titles;
@property NSMutableArray *descriptions;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSMutableArray new];

    
}
- (IBAction)edit:(UIBarButtonItem *)sender
{
    if (self.editing)
    {
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    }
    else
    {
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style =  UIBarButtonItemStyleDone;
        sender.title = @"Done";
        
        
    }
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    NSString *title =[self.titles objectAtIndex:sourceIndexPath.row];
    [self.titles removeObject:title];
    [self.titles insertObject:title atIndex:destinationIndexPath.row];
    
    NSString *description =[self.descriptions objectAtIndex:sourceIndexPath.row];
    [self.descriptions removeObject:description];
    [self.descriptions insertObject:description atIndex:destinationIndexPath.row];
    
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
    
}
- (IBAction)add:(UIBarButtonItem *)sender {
    [self presentDreamEntry];
}


-(void) presentDreamEntry{
    UIAlertController *alertContoller = [UIAlertController alertControllerWithTitle:@"Enter text" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertContoller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Text";
    }];
    
    
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *saveAction =[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        UITextField *textField1 = alertContoller.textFields.firstObject;
        
        
        [self.titles addObject:textField1.text];
        [self.tableView reloadData];
        
    }];
    [alertContoller addAction:cancelAction];
    [alertContoller addAction:saveAction];
    
    [self presentViewController:alertContoller animated:true completion:nil];
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.descriptions objectAtIndex:indexPath.row];
    return  cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.titles.count;
    
}


@end
