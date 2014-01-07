package com.baiduads.func;

import android.content.Intent;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

/**
 * @author Rect
 * @see rectvv@gmail.com
 * @see www.shadowkong.com
 * @see github.com/platformanes
 * @version 2014-1-6
 */
public class BaiduAdsSplash implements FREFunction {

	private String TAG = "BaiduAdsSplash";
	private FREContext _context;
	@Override
	public FREObject call(final FREContext context, FREObject[] arg1) {
		// TODO Auto-generated method stub
		_context = context;
		FREObject result = null; 
		// TODO Auto-generated method stub
		//--------------------------------
		
		BrigeCodeActivity._context = context;
		Intent intent = new Intent(BrigeCodeActivity.MYACTIVITY_ACTION);
		int bridgeKey = 0;
		intent.putExtra("bridgeKey", bridgeKey);
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
