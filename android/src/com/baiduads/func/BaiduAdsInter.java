package com.baiduads.func;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.baidu.mobads.InterstitialAd;
import com.baidu.mobads.InterstitialAdListener;

/**
 * @author Rect
 * @see rectvv@gmail.com
 * @see www.shadowkong.com
 * @see github.com/platformanes
 * @version 2014-1-6
 */
public class BaiduAdsInter implements FREFunction {

	private String TAG = "BaiduAdsInter";
	private FREContext _context;
	private static InterstitialAd interAd = null;;
	private static boolean isShow = true;
	@Override
	public FREObject call(final FREContext context, FREObject[] arg1) {
		// TODO Auto-generated method stub
		_context = context;
		FREObject result = null; 
		// TODO Auto-generated method stub
		//--------------------------------
		isShow = false;
		interInit();

		if(interAd != null && interAd.isAdReady()){
			interAd.showAd(this._context.getActivity());
		}else{
			interAd.loadAd();
		}

		callBack("success");
		//--------------------------------

		return result;
	}

	private void interInit()
	{
		if(null != interAd)
			return;

		interAd = new InterstitialAd(_context.getActivity());
		interAd.setListener(new InterstitialAdListener(){

			@Override
			public void onAdClick(InterstitialAd arg0) {
				callBack("onAdClick");
			}

			@Override
			public void onAdDismissed() {
				callBack("onAdDismissed");
				interAd.loadAd();
			}

			@Override
			public void onAdFailed(String arg0) {
				callBack("onAdFailed");
			}

			@Override
			public void onAdPresent() {
				callBack("onAdPresent");
			}

			@Override
			public void onAdReady() {
				callBack("onAdReady");

			}

		});
		interAd.loadAd();
	}
	public void callBack(String status){


		Log.d(TAG, status);
		_context.dispatchStatusEventAsync(TAG,status);

		if("onAdReady" == status && false == isShow)
		{

			if(interAd != null && interAd.isAdReady()){
				isShow = true;
				interAd.showAd(this._context.getActivity());
			}else{
				interAd.loadAd();
			}

		}

	}
}
