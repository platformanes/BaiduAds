BaiduAds
========

百度移动推广联盟ANE（android）
## 百度移动推广联盟ANE
* 官方SDK地址：[传送门](http://munion.baidu.com/about.html#/sdk/mobSdk)
* 说明：暂时只分享android版
* android对应版本：`Android SDK 3.4`
* IOS对应版本：`iOS SDK 3.4`

## 特别说明
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
## 作者

* [platformANEs](https://github.com/platformanes)由 [zrong](http://zengrong.net) 和 [rect](http://www.shadowkong.com/) 共同发起并完成。
