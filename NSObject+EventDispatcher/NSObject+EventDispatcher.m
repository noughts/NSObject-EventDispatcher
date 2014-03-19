#import "NSObject+EventDispatcher.h"
#import <objc/runtime.h>

@implementation NSObject (EventDispatcher)

-(void)addEventListener:(NSString*)name observer:(UIViewController*)observer selector:(SEL)selector{
	// objectがポイント。ここに自分自身を渡すことにより、自分自身からpostされた通知にのみ限定して反応するようになります。
	[[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:self];
}


/// blocks を使ってイベントハンドリング
// この戻り値を removeEventListerner に渡すと、イベント監視を終了できます
-(id)addEventListener:(NSString*)name usingBlock:(void (^)(NSNotification* notification))block{
	// objectがポイント。ここに自分自身を渡すことにより、自分自身からpostされた通知にのみ限定して反応するようになります。
	id observer = [[NSNotificationCenter defaultCenter] addObserverForName:name object:self queue:nil usingBlock:block];
	return observer;
}


/// 指定した配列内のオブザーバーのイベントリスンを全て解除
// blockを使ってaddEventListenerした返り値を配列に保持していき、これに渡すと一気に解除できます。
-(void)removeEventListeners:(NSArray*)observers{
	for (id observer in observers) {
		[[NSNotificationCenter defaultCenter] removeObserver:observer];
	}
}


/// blocks を使った時のイベント監視を停止
-(void)removeEventListener:(id)notificationObserver{
	[[NSNotificationCenter defaultCenter] removeObserver:notificationObserver];
}



/// イベント監視を停止
-(void)removeEventListener:(NSString*)name observer:(UIViewController*)observer{
	[[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:self];
}




-(void)dispatchEvent:(NSString*)name userInfo:(NSDictionary*)userInfo{
	NSNotification* n = [NSNotification notificationWithName:name object:self userInfo:userInfo];
	[[NSNotificationCenter defaultCenter] postNotification:n];
}


/// NSNotification をそのまま伝播する
-(void)dispatchEventWithNotification:(NSNotification*)notification{
	NSNotification* newNotification = [NSNotification notificationWithName:notification.name object:self userInfo:notification.userInfo];
	[[NSNotificationCenter defaultCenter] postNotification:newNotification];
}



@end
