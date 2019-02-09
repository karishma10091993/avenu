//
//  LoginViewController.m
//  SriBalajiSaiRam_Chit
//
//  Created by kireeti on 09/02/19.
//  Copyright © 2019 KireetiSoftSolutions. All rights reserved.

#import "SharedController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "Constants.h"

@interface LoginViewController ()
{
    SharedController *sharedController;
    NSMutableDictionary *dictLoginResult;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.title = @"CHITCARE ERP Director's Module";
    

   // lbl.attributedText = attrStr;
    
    
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 300, 50)];
    lblTitle.text = @"SriBalaji SaiRam ChitFund Director's Module";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.lineBreakMode = UILineBreakModeWordWrap;
    lblTitle.numberOfLines = 0;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont boldSystemFontOfSize:15];
    self.navigationItem.titleView = lblTitle;

    sharedController = [SharedController sharedController];
    lblCompanyName.text = KStringCompanyName;
    lblCompanyName.lineBreakMode = UILineBreakModeWordWrap;
    lblCompanyName.numberOfLines = 0;
    imgCompanyLogo.image = [UIImage imageNamed:kImageLogo];
    //profilelogoimg.frame=CGRectMake(0, 0, [self viewWidth], 120);
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        imgCompanyLogo.frame= CGRectMake(250, 150, 50, 50);
        lblCompanyName.frame=CGRectMake(310, 150, 250, 50);
        txtFldUserName.frame=CGRectMake(380, 204, 200, 40);
        txtFldPwd.frame=CGRectMake(380, 250, 200, 40);
        lblusrname.frame=CGRectMake(250, 204, 100, 40);
        lblpwd.frame=CGRectMake(250, 250, 100, 40);
        btnsbmt.frame=CGRectMake(350, 350, 100, 40) ;
    }
    dictLoginResult = [[NSMutableDictionary alloc] init];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
txtFldUserName.text = @"kesselnadmins";
txtFldPwd.text = @"@admin$essel#";
    //txtFldUserName.text = @"";
    //txtFldPwd.text = @"";
  }

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0,-60) animated:YES];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 111)
    {
        [scrollView setContentOffset:CGPointMake(0,50) animated:YES];
    }
    else
    {
        [scrollView setContentOffset:CGPointMake(0,60) animated:YES];
    }
}

-(IBAction)submit_TouchUpInside:(UIButton*)sender
{
    if(txtFldPwd.text.length == 0 || txtFldUserName.text.length == 0)
    {
        [sharedController showAlertWithTitle:@"" message:@"Please enter user name and password" delegate:nil];
    }
    else
    {
        [sharedController loginDetails:txtFldUserName.text Password:txtFldPwd.text delegate:self];
    }
}

-(void)controllerDidFinishLoadingWithResult:(id)result
{
    NSLog(@"result  is %@",result);
    
    [dictLoginResult removeAllObjects];
    dictLoginResult = [result objectForKey:@"LoginResult"];
    NSLog(@"%@",dictLoginResult);
    
    if([[[dictLoginResult objectForKey:@"RoleID"] stringValue] isEqualToString:@"4"] && [[[dictLoginResult objectForKey:@"DirectorType"] stringValue] isEqualToString:@"1"])
//    if([[dictLoginResult objectForKey:@"RoleID"] isEqualToString:@"4"])
    {
        MainViewController *mainVc = [[MainViewController alloc] init];
        mainVc.dictLoginDetails = dictLoginResult;
        [self.navigationController pushViewController:mainVc animated:YES];
    }
    else
    {
        [sharedController showAlertWithTitle:@"" message:@"Please enter Director Credentials" delegate:self];
    }
}

- (void)controllerDidFailLoadingWithError:(NSError*)error
{
    NSLog(@"%@",error);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
