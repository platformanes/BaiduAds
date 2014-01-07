package com.baiduads.func;

import android.content.Intent;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.baidu.mobads.MultiFuncService;

/**
 * @author Rect
 * @see rectvv@gmail.com
 * @see www.shadowkong.com
 * @see github.com/platformanes
 * @version 2014-1-6
 */
public class BaiduAdsVideo implements FREFunction {

	private String TAG = "BaiduAdsVideo";
	private FREContext _context;
	@Override
	public FREObject call(final FREContext context, FREObject[] arg1) {
		// TODO Auto-generated method stub
		_context = context;
		FREObject result = null; 
		// TODO Auto-generated method stub
		//--------------------------------
		String adsID = "";
		try
		{
			adsID = arg1[0].getAsString();
			callBack("adsID:"+adsID);
		}
		catch (Exception e) {
			// TODO: handle exception
			callBack("argv is error");
			return null;
		}
		
		//videoPreLoad接受两个参数：
		//参数1、activity，
		//参数2、广告位ID，如果为""或者null,则指默认广告位
		MultiFuncService.getInstance(this._context.getActivity()).videoPreLoad(this._context.getActivity(), adsID);
		
		BrigeCodeActivity._context = context;
		Intent intent = new Intent(BrigeCodeActivity.MYACTIVITY_ACTION);
		int bridgeKey = 1;
		intent.putExtra("bridgeKey", bridgeKey);
		intent.putExtra("adsID", adsID);
		Log.d(TAG, "---------startActivity-------");
		_context.getActivity().startActivityForResult(intent, 0);
		
		callBack("success");
		//--------------------------------
		
		return result;
	}

	
	public void callBack(String status){
		Log.d(TAG, status);
		_context.dispatchStatusEventAsync(TAG,status);
	}

}
