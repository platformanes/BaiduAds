package com.baiduads.func;

import org.json.JSONObject;

import android.util.Log;
import android.widget.RelativeLayout;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.baidu.mobads.AdSettings;
import com.baidu.mobads.AdView;
import com.baidu.mobads.AdViewListener;

/**
 * @author Rect
 * @see rectvv@gmail.com
 * @see www.shadowkong.com
 * @see github.com/platformanes
 * @version 2014-1-6
 */
public class BaiduAdsCode implements FREFunction {

	private String TAG = "BaiduAdsCode";
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
			boolean isCodeSet = arg1[0].getAsBool();
			String appSid = arg1[1].getAsString();
			String appSec = arg1[2].getAsString();
			if(isCodeSet)
			{
				// 代码设置AppSid和Appsec，此函数必须在AdView实例化前调用
				 AdView.setAppSid(_context.getActivity(),appSid);
				 AdView.setAppSec(_context.getActivity(),appSec);
			}
			
			String baiduKey = arg1[3].getAsString();
			String countriesKey = arg1[4].getAsString();
			
			callBack("isCodeSet:"+isCodeSet);
			callBack("appSid:"+appSid);
			callBack("appSec:"+appSec);
			callBack("baiduKey:"+baiduKey);
			callBack("countriesKey:"+countriesKey);
			
			// 人群属性
			AdSettings.setKey(new String[] { baiduKey, countriesKey});
			
			RelativeLayout rlMain = new RelativeLayout(_context.getActivity());
			// 创建广告View
			AdView adView = new AdView(_context.getActivity());
			// 设置监听器
			adView.setListener(new AdViewListener() {
				public void onAdSwitch() {
					callBack("onAdSwitch");
				}
				public void onAdShow(JSONObject info) {
					callBack("onAdShow " + info.toString());
				}
				public void onAdReady(AdView adView) {
					callBack("onAdReady " + adView);
				}
				public void onAdFailed(String reason) {
					callBack("onAdFailed " + reason);
				}
				public void onAdClick(JSONObject info) {
					callBack("onAdClick " + info.toString());
				}
				public void onVideoStart() {
					callBack("onVideoStart");
				}
				public void onVideoFinish() {
					callBack("onVideoFinish");
				}
				@Override
				public void onVideoClickAd() {
					callBack("onVideoFinish");
				}
				@Override
				public void onVideoClickClose() {
					callBack("onVideoFinish");
				}
				@Override
				public void onVideoClickReplay() {
					callBack("onVideoFinish");
				}
				@Override
				public void onVideoError() {
					callBack("onVideoFinish");
				}
			});
			rlMain.addView(adView);
			_context.getActivity().setContentView(rlMain);
			
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

	
	public void callBack(String status){
		Log.d(TAG, status);
		_context.dispatchStatusEventAsync(TAG,status);
	}
}
