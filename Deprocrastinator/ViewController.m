//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Mohamed Ayadi on 5/31/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate >

@property NSMutableArray *titles;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
- (IBAction)gesture:(UISwipeGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:_tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell  = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
    //swipedCell.textLabel.backgroundColor
    
//    
//    UIColor *color1 = swipedCell.backgroundColor;
//    
//    UIColor *color2 =[UIColor greenColor];
    
    if (swipedCell.textLabel.textColor == [UIColor blackColor]) {
        swipedCell.textLabel.textColor= [UIColor blackColor];
    }
    
//    if(color1 == color2){
    
        
//    }
    
//    
//    if([greenColor.backgroundColor isEqual:swipedCell.textLabel.backgroundColor])
//    {
//        
//        swipedCell.textLabel.backgroundColor = [UIColor whiteColor];
// 
//    }
//    if(swipedCell.textLabel.backgroundColor == [UIColor greenColor])
//    {
//        
//        swipedCell.textLabel.backgroundColor = [UIColor yellowColor];
//        
//    }
//
//    if(swipedCell.textLabel.backgroundColor == [UIColor yellowColor])
//    {
//        
//        swipedCell.textLabel.backgroundColor = [UIColor redColor];
//        
//    }
//
//    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSArray arrayWithObjects:@"get up", @"make coffee", @"whatever", nil].mutableCopy;

    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *thecell = [tableView cellForRowAtIndexPath:indexPath];
    thecell.textColor = [UIColor greenColor];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
    
}




-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.titles removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
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
    
    return  cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.titles.count;
    
}



@end
