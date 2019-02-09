//
//  MainViewController.h
//  SriBalajiSaiRam_Chit
//
//  Created by kireeti on 09/02/19.
//  Copyright © 2019 KireetiSoftSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface MainViewController : ViewController<UITableViewDelegate,UITableViewDataSource>
{
   IBOutlet  UITableView *tableView;
}
@property (nonatomic,retain)NSDictionary *dictLoginDetails;
@property(nonatomic,retain)NSMutableArray *arrBranchesList;
@end
