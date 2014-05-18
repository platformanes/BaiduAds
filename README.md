BaiduAds
========

百度移动推广联盟ANE（android）
## 百度移动推广联盟ANE
* 官方SDK地址：[传送门](http://munion.baidu.com/about.html#/sdk/mobSdk)
* android对应版本：`Android SDK 3.4`
* IOS对应版本：`iOS SDK 3.4`

## Android版特别说明
* 此ANE需使用工具[RDT](RDT)来打包APK
* 若不想使用RDT，则请详细查看最下面的ADT打包说明

## 编写ANE过程

> A.参照我博客的教程[传送门](http://www.shadowkong.com/archives/1090)的前提下
>  
> B.取消合并jar,直接取eclipse中的 `bin/baiduadsane.jar` 到`Android-ARM`中 
>  
> C.取官方SDK提供的res 到 Android-ARM中 
>  
> D.修改`android-ARM\res\layout\simple_declaring.xml`中的 `xmlns:baiduadsdk` 对应值为你项目的包名
>  
> E.取官方DEMO中的libs中的`Baidu_MobAds_SDK.jar`库 到 `Android-ARM/RDT` 中
>
> F.解压`Baidu_MobAds_SDK.jar`得到`extra`放到`Android-ARM/ROOT` 中
> 
> G.按照`buildANE`下的bat命令生成ANE(注意配置`本地路径`)
		ANE编写到此结束.下面打包APK才是重中之重

## 使用RDT打包
* 参照 `buildAPK\baidu_apk.bat`中的命令 其中adt路径修改为你的本地路径
* 再次提醒，打包APK使用我定制的RDT工具，并非官方的ADT。

## 使用ADT打包
* 若不想使用我修改的工具打包
* 
		A.则需要在编写ANE的时候合并jar
		B.在打包APK后 使用Apktool工具把“extra”文件夹放入apk根目录
		PS：extra文件夹由Baidu_MobAds_SDK.jar解压所得
		

## iOS版特别说明

* 参数配置在项目根目录的`baiduadsdata.plist`文件中,各参数意义如下

		* @param baiAdPlaceId1 -- 广告位ID
		* @param baipublisherId -- your_own_app_id
		* @param baiAppSpec -- 注意：该计费名为测试用途，不会产生计费，请测试广告展示无误以后，替换为您的应用计费名，然后提交AppStore.
		* @param baiisenableLocation -- 启用location会有一次alert提示
		* @param baikeywords -- 人群属性接口 关键词数组 "-"分隔,例如"足球-篮球-网球" 
		* @param baiuserGender -- 人群属性接口 性别 0-男, 1-女,2-未知
		* @param baiuserBirthday -- 人群属性接口 用户生日
		* @param baiuserCity -- 人群属性接口 用户城市
		* @param baiuserPostalCode -- 人群属性接口 用户邮编
		* @param baiuseruserWork -- 人群属性接口 用户职业
		* @param baiuserEducation -- 人群属性接口 用户最高教育学历 - 0到6 表示 小学到博士
		* @param baiuserSalary -- 人群属性接口 用户收入
		* @param baiuserHobbies -- 群属性接口 用户爱好 "-"分隔,例如"足球-篮球-网球" 
		* @param baiuserOtherAttributes -- 人群属性接口 其他自定义字段 尚未启用,如需使用,请自行修改OC源码(by Rect)


* iOS版只需要调用4个函数即可

		//iOS func
		public function BaiduAdsiOSBanner(
			bannerX:int,
			bannerY:int,bannerWidth:int,bannerHeight:int
		):String{
			if(extContext ){
				return extContext.call(BAIDUADS_FUNCTION_BANNER,
					bannerX,
					bannerY,bannerWidth,bannerHeight
				) as String;
			}
			return "call BaiduAdsBanner failed";
		} 
		
		public function BaiduAdsiOSHideBanner():String{
			if(extContext ){
				return extContext.call(BAIDUADS_FUNCTION_BANNER_CLOSE) as String;
			}
			return "call BaiduAdsHideBanner failed";
		} 
		
		public function BaiduAdsiOSVedio(
			key:int,
			InterX:int,InterY:int,
			InterWidth:int,InterHeight:int):String{
			if(extContext ){
				return extContext.call(BAIDUADS_FUNCTION_INTERSTITIAL,key,InterX,
					InterY,InterWidth,InterHeight) as String;
			}
			return "call BaiduAdsiOSVedio failed";
		} 
		
		public function BaiduAdsiOSInterStatial(
			key:int,type:int):String{
			if(extContext ){
				return extContext.call(BAIDUADS_FUNCTION_INTERSTITIAL,key,type) as String;
					}
			return "call BaiduAdsInterStatial failed";
		} 
						 


* iOS版本参数设置使用`plist`文件,主要原因是由于ANE for iOS不支持传输数组.使用的朋友可以随意更改你认为比较靠谱的参数设置方式.
* 具体plist文件里面每个参数的解释 请查看aneTest下的源码解释
		
## 作者

* [platformANEs](https://github.com/platformanes)由 [zrong](http://zengrong.net) 和 [rect](http://www.shadowkong.com/) 共同发起并完成。
