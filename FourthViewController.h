//
//  FourthViewController.h
//  爱易
//
//  Created by 路伟饶 on 2016/7/20.
//  Copyright © 2016年 xiaolu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourthViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
