/*
 
 子 VC やViewのイベントを親 VC で受け取るなどが便利にできます。
 
 Signal と違い、子VCにaddEventListenerしたあと、removeEventListenerしなくても、子VCは正常にdeallocされるので手間なくて便利です。
 ただし addEventListener:usingBlock を使うときは、循環参照を防ぐため、中に self をそのまま入れず、__weak を使って定義しなおした変数を使いましょう。
 
 [親VC]
 ChildViewController* vc = segue.destinationViewController;
 [vc addEventListener:@"addMemberButtonTap" observer:self selector:@selector(hoge:)];
 
 -(void)hoge:(NSNotification*)notification{
 NSLog( @"hoge %@", notification );
 }
 
 [子VC]
 -(IBAction)onButtonTap:(id)sender{
 [self dispatchEvent:@"addMemberButtonTap" userInfo:@{@"p1":@123}];
 }
 
 
 */

#import <Foundation/Foundation.h>

@interface NSObject (EventDispatcher)

-(void)addEventListener:(NSString*)name observer:(UIViewController*)observer selector:(SEL)selector;
-(id)addEventListener:(NSString*)name usingBlock:(void (^)(NSNotification* notification))block;
-(void)dispatchEvent:(NSString*)name userInfo:(NSDictionary*)userInfo;
-(void)removeEventListener:(id)notificationObserver;

/// 全てのイベントリスナを解除
-(void)removeAllEventListener:(id)notificationObserver;

/// イベント監視を停止
-(void)removeEventListener:(NSString*)name observer:(UIViewController*)observer;

/// NSNotification をそのまま伝播する
-(void)dispatchEventWithNotification:(NSNotification*)notification;

@end






