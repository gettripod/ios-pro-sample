//
//  ViewController.h
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrashRepotingVC.h"
#import "ShaketoReportVC.h"
#import <TripodFramework/TripodFrame.h>
@interface ViewController : UIViewController
{
    TripodViewController *tri;
    CrashRepotingVC *crashReport;
    ShaketoReportVC *shakeToReport;
}

@end

