//
//  SWLAFN.m
//  washChuangLian
//
//  Created by 单维龙 on 16/3/7.
//  Copyright © 2016年 離去之原. All rights reserved.
//

#import "AFN.h"
#import "AFNetworking.h"
//#import "MBProgressHUD.h"

@interface AFN ()
@end

static AFHTTPSessionManager *_manager;
//static MBProgressHUD *_hud;
static NBViewController *_viewController;
static dispatch_source_t _timer;
@implementation AFN

+ (void)postWithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters onView:(UIViewController *)view getData:(SuccessBlock)getData failure:(FailedBlock)failure {
//    _hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    _hud.labelText = @"正在加载";
//    _hud.labelFont = [UIFont boldSystemFontOfSize:13];
//    _hud.dimBackground = NO;
//    _hud.margin = 10;
//    _hud.removeFromSuperViewOnHide = YES;
//    _hud.userInteractionEnabled = YES;
    /**
     *  本地缓存
     */
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    NSString *pathString = path.lastObject;
//    NSString *pathLast = [NSString  stringWithFormat:@"/Caches/default/com.hackemist.SDWebImageCache.default/%lu.text",(unsigned long)[urlStr hash]];
//    NSString *pathName = [pathString stringByAppendingString:pathLast];
    
//    NSLog(@"%@",pathName);
    /**
     *  post网络请求
     */
   
    _manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];

    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *headerFieldValueDictionary =@{@"Authorization": @"Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",@"Accept": @"application/json"};
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    _manager.requestSerializer = requestSerializer;
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];

    [_manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%@-------%@",urlStr, parameters);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        
        if ( ![[responseObject objectForKey:@"status"] isEqualToNumber:@0]) {
            if ([[responseObject objectForKey:@"status"] isEqualToNumber:@100]) {
//                MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:view.view animated:YES];
//                errorHud.mode = MBProgressHUDModeText;
//                errorHud.label.text= responseObject[@"msg"];
//                errorHud.removeFromSuperViewOnHide = YES;
                dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
                
                dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,queue);
                //这里必须有一个强指针指向,因为GCD定时器本质还是一个OC对象
                _timer = timer;
                //设置定时器开始时间,这里的时间单位是纳秒
                dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW,2 * NSEC_PER_SEC);
                //设置定时器
                dispatch_source_set_timer(_timer,startTime,(int64_t)(0 * NSEC_PER_SEC),0);
                //设置定时器所做的事情,block回调
                dispatch_source_set_event_handler(timer,^{
                    //定时器要做的事情
                    dispatch_cancel(_timer);
                    _timer = nil;
                    dispatch_sync(dispatch_get_main_queue(), ^{
//                        [errorHud hideAnimated:YES];
//                        [[NBAccountManager sharedManager] signOut];
//                        [view jumpToLoginVC];
                    });
                });
                //CGD定时器默认是暂停的,需要手动开启
                dispatch_resume(timer);
                //定时器的关闭
              
                
            } else {
//            MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:view.view animated:YES];
//            errorHud.mode = MBProgressHUDModeText;
//            errorHud.label.text= responseObject[@"msg"];
//            errorHud.removeFromSuperViewOnHide = YES;
//            [errorHud hideAnimated:YES afterDelay:1.5];
            getData(responseObject);
            }
        } else {
            getData(responseObject);
        }
        NSLog(@"%@",responseObject);
        
//        id cacheFile = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        [cacheFile writeToFile:pathName atomically:YES];
        
//        [_hud setHidden:YES];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        
        [_manager.operationQueue setSuspended:YES];
        [_manager.operationQueue cancelAllOperations];
//        NSLog(@"requestError: %@",error);
//        if (error.code == -1001) {
//            
//            MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//            errorHud.mode = MBProgressHUDModeText;
//            errorHud.labelText = @"请求超时";
//            errorHud.removeFromSuperViewOnHide = YES;
//            [errorHud hide:YES afterDelay:1.5];
//        } else {
//            
//            MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:view.view animated:YES];
//            errorHud.mode = MBProgressHUDModeText;
//            errorHud.label.text = @"网络异常,请刷新重试";
//            errorHud.removeFromSuperViewOnHide = YES;
//            [errorHud hideAnimated:YES afterDelay:1.5];
//        }
        
//        if ([[NSFileManager defaultManager] fileExistsAtPath:pathName]) {
//            id cacheFile = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:pathName] options:NSJSONReadingMutableContainers error:nil];
//            getData(cacheFile);
//        }
    }];
}

+ (void)cancelRequest {
    
    [_manager.operationQueue cancelAllOperations];
    [_manager.session invalidateAndCancel];
//    _hud.hidden = YES;
}
+ (void)runInMainQueue:(void (^)())block{
    dispatch_async(dispatch_get_main_queue(), block);
}


@end
