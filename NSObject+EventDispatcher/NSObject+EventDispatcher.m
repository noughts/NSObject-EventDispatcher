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
	[self.observersTable addObject:observer];
	return observer;
}


/// 全てのイベントリスナを解除
-(void)removeAllEventListener:(id)notificationObserver{
	// block で add したリスナを解除
	for ( id observer in self.observersTable.allObjects ){
		[[NSNotificationCenter defaultCenter] removeObserver:observer];
	}
	[self.observersTable removeAllObjects];
	
	// selector で add したリスナを解除
	[[NSNotificationCenter defaultCenter] removeObserver:notificationObserver];
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



/// blockを使ったときのオブザーバーをremoveEventListenerする時用に保持するためのテーブル
-(NSHashTable*)observersTable{
	NSHashTable* observers = objc_getAssociatedObject( self, _cmd );
	if( observers == nil ){
		observers = [NSHashTable weakObjectsHashTable];
		objc_setAssociatedObject( self, _cmd, observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return observers;
}



@end
