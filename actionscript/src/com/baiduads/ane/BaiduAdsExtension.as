package com.baiduads.ane 
{ 
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	/**
	 * 
	 * @author Rect  2013-5-6 
	 * 
	 */
	public class BaiduAdsExtension extends EventDispatcher 
	{ 
		private static const BAIDUADS_FUNCTION_SPLASH:String = "baiduads_function_splash";//与java端中Map里的key一致
		private static const BAIDUADS_FUNCTION_DEC:String = "baiduads_function_simple_dec";//与java端中Map里的key一致
		private static const BAIDUADS_FUNCTION_CODE:String = "baiduads_function_simple_code";//与java端中Map里的key一致
		private static const BAIDUADS_FUNCTION_VIEDO:String = "baiduads_function_video";//与java端中Map里的key一致+
		private static const BAIDUADS_FUNCTION_INTERAD:String = "baiduads_function_interad";//与java端中Map里的key一致
		private static const BAIDUADS_FUNCTION_ICONSAD:String = "baiduads_function_iconsad";//与java端中Map里的key一致
		
		private static const BAIDUADS_FUNCTION_EXIT:String = "baiduads_function_exit";//与java端中Map里的key一致
		
		private static const EXTENSION_ID:String = "com.baiduads.ane.BaiduAds";//与extension.xml中的id标签一致
		private var extContext:ExtensionContext;
		
		/**单例的实例*/
		private static var _instance:BaiduAdsExtension; 
		public function BaiduAdsExtension(target:IEventDispatcher=null)
		{
			super(target);
			if(extContext == null) {
				extContext = ExtensionContext.createExtensionContext(EXTENSION_ID, "");
				extContext.addEventListener(StatusEvent.STATUS, statusHandler);
			}
			
		} 
		
		//第二个为参数，会传入java代码中的FREExtension的createContext方法
		/**
		 * 获取实例
		 * @return DLExtension 单例
		 */
		public static function getInstance():BaiduAdsExtension
		{
			if(_instance == null) 
				_instance = new BaiduAdsExtension();
			return _instance;
		}
		
		/**
		 * 转抛事件
		 * @param event 事件
		 */
		private function statusHandler(event:StatusEvent):void
		{
			dispatchEvent(event);
		}
		
		
		public function BaiduAdsSplash(key:int):String{
			if(extContext ){
				return extContext.call(BAIDUADS_FUNCTION_SPLASH,key) as String;
			}
			return "call BaiduAdsSplash failed";
		} 
		
		public function BaiduAdsDes(key:int):String{
			if(extContext ){
				return extContext.call(BAIDUADS_FUNCTION_DEC,key) as String;
			}
			return "call BaiduAdsDes failed";
		} 
		/**
		 *  参数详细查看java代码和百度文档
		 * @param isCodeSet 是否在代码中设置appId
		 * @param appSid  appID
		 * @param appSec appDes
		 * @param baiduKey 参数详细查看java代码和百度文档
		 * @param countriesKey 参数详细查看java代码和百度文档
		 * @return 
		 * 
		 */		
		public function BaiduAdsCode(
			isCodeSet:Boolean = false,
			appSid:String = "debug",
			appSec:String = "debug",
			baiduKey:String = "baidu",
			countriesKey:String = "中国"):String{
			if(extContext ){
				return extContext.call(BAIDUADS_FUNCTION_CODE,isCodeSet,appSid,appSec,baiduKey,countriesKey) as String;
			}
			return "call BaiduAdsCode failed";
		} 
		/**
		 * 参数详细查看java代码和百度文档
		 * @param adsSid 广告ID 默认为null
		 * @return 
		 * 
		 */		
		public function BaiduAdsViedo(adsSid:String = ""):String{
			if(extContext ){
				return extContext.call(BAIDUADS_FUNCTION_VIEDO,adsSid) as String;
			}
			return "call BaiduAdsViedo failed";
		} 
			
		public function BaiduAdsInterAds(ext:String = ""):String{
			if(extContext ){
				return extContext.call(BAIDUADS_FUNCTION_INTERAD,ext) as String;
			}
			return "call BaiduAdsInterAds failed";
		} 
		/**
		 * 参数详细查看java代码和百度文档
		 * @param iconKey 
		 * @param drawableA  资源路径A
 		 * @param drawableB  资源路径B
		 * @return 
		 * 
		 */		
		public function BaiduAdsIconsAds(iconKey:int = 0,drawableA:String = "",drawableB:String = ""):String{
			if(extContext ){
				return extContext.call(BAIDUADS_FUNCTION_ICONSAD,iconKey,drawableA,drawableB) as String;
			}
			return "call BaiduAdsIconsAds failed";
		} 
		
		public function BaiduAdsExit(key:int):String{
			if(extContext){ 
				return extContext.call(BAIDUADS_FUNCTION_EXIT,key) as String;
			}
			return "call exit failed";
		}
	} 
}