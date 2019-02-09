//
//  CompanyInvestmentViewController.h
//  SriBalajiSaiRam_Chit
//
//  Created by kireeti on 09/02/19.
//  Copyright © 2019 KireetiSoftSolutions. All rights reserved.

#import <UIKit/UIKit.h>

@interface CompanyInvestmentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIView *viewCompanyInvestmentTable;
    IBOutlet UILabel *lblCompanyName;
    IBOutlet UILabel *lblDividendValue;
    IBOutlet UILabel *lblInvestmentValue;
    IBOutlet UILabel *lblVacantCountValue;
    IBOutlet UIButton *btnSelectBranch;
    IBOutlet UILabel *lblDividendPercentage;
    IBOutlet UILabel *lblInvestmentPercentage;
    
    IBOutlet UIImageView *imgCompanyLogo;

}
@property(nonatomic,retain)NSMutableArray *arrBranchesList;
@property(nonatomic,retain)NSDictionary *dictLoginDetails;

-(IBAction)btnSelectBranch_TouchUpInside:(id)sender;
@end
