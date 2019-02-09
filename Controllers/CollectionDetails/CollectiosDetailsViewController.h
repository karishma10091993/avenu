//
//  CollectiosDetailsViewController.h
//  SriBalajiSaiRam_Chit
//
//  Created by kireeti on 09/02/19.
//  Copyright © 2019 KireetiSoftSolutions. All rights reserved.

#import <UIKit/UIKit.h>

@interface CollectiosDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    IBOutlet UIView *viewBranchDetails;
    IBOutlet UIButton *btnBranchSelection;
    IBOutlet UIButton *btnDateSelection;
    
    IBOutlet UILabel *lblCashValue;
    IBOutlet UILabel *lblCheck_DDValue;
    IBOutlet UILabel *lblAdjValue;
    IBOutlet UILabel *lblTotalValue;
    IBOutlet UILabel *lblRTGSValue;
    
    IBOutlet UILabel *lblCashPercentage;
    IBOutlet UILabel *lblCheck_DDPercentage;
    IBOutlet UILabel *lblAdjPercentage;
    IBOutlet UILabel *lblRTGSVPercentage;
    
    IBOutlet UILabel *lblCompanyName;
    IBOutlet UIImageView *imgCompanyLogo;

}

-(IBAction)btnDateselection:(id)sender;

@property(nonatomic,retain)NSDictionary *dictLoginDetails;
@property(nonatomic,retain)NSMutableArray *arrBranchesList;

@end
