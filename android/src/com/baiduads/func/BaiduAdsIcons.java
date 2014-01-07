package com.baiduads.func;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.baidu.mobads.IconsAd;

/**
 * @author Rect
 * @see rectvv@gmail.com
 * @see www.shadowkong.com
 * @see github.com/platformanes
 * @version 2014-1-6
 */
public class BaiduAdsIcons implements FREFunction {

	private String TAG = "BaiduAdsIcons";
	private FREContext _context;
	@Override
	public FREObject call(final FREContext context, FREObject[] arg1) {
		// TODO Auto-generated method stub
		_context = context;
		FREObject result = null; 
		// TODO Auto-generated method stub
		//--------------------------------
		try
		{
			int iconKey = arg1[0].getAsInt();
			String drawableA = arg1[1].getAsString();
			String drawableB = arg1[2].getAsString();
			callBack("drawableA:"+drawableA);
			callBack("drawableB:"+drawableB);
			callBack("iconKey:"+iconKey);
			iconChoose(iconKey,drawableA,drawableB);
			
		}
		catch (Exception e) {
			// TODO: handle exception
			callBack("argv is error");
			return null;
		}

		callBack("success");
		//--------------------------------
		
		return result;
	}
/**
 * 
 * @param iconKey
 * @param drawableA
 * @param drawableB
 */
	private void iconChoose(int iconKey,String drawableA,String drawableB)
	{
//		调用方式1： 不传drawable，则使用默认图标
//		IconsAd iconsAd=new IconsAd(this);
		
//		调用方式2： 传入1个R.drawable资源，表示自定义浮标;
//		浮标会缩放到：42dip * 48dip, 即宽高比:7:8，建议适当留白以增加点击范围
//		IconsAd iconsAd=new IconsAd(this,new int[]{R.drawable.ico_xp});
		
//		调用方式3： 传入2个R.drawable资源，第二个为自定义轮盘收起按钮；
//		收起按钮 会缩放到： (屏幕窄边)/6 * (屏幕窄边)/4, 即宽高比：2:3
//		IconsAd iconsAd=new IconsAd(this,new int[]{R.drawable.mp_icon, R.drawable.mp_close });
		IconsAd iconsAd = null;
		switch(iconKey)
		{
		case 0:
			iconsAd = new IconsAd(this._context.getActivity());
			break;
		case 1:
			 iconsAd = new IconsAd(this._context.getActivity(),new int[]{
				this._context.getResourceId(drawableA)});
			break;
		case 2:
			 iconsAd = new IconsAd(this._context.getActivity(),new int[]{
				this._context.getResourceId(drawableA), 
				this._context.getResourceId(drawableB)});
			break;
			
		}
		
		iconsAd.loadAd(this._context.getActivity());
	}
	public void callBack(String status){
		Log.d(TAG, status);
		_context.dispatchStatusEventAsync(TAG,status);
	}

}
