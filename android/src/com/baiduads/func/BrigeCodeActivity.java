package com.baiduads.func;



import org.json.JSONObject;

import com.adobe.fre.FREContext;
import com.baidu.mobads.AdSize;
import com.baidu.mobads.AdView;
import com.baidu.mobads.AdViewListener;
import com.baidu.mobads.SplashAd;
import com.baidu.mobads.SplashAdListener;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
/**
 * @author Rect
 * @see rectvv@gmail.com
 * @see www.shadowkong.com
 * @see github.com/platformanes
 * @version 2014-1-6
 */
public class BrigeCodeActivity extends Activity implements
OnClickListener {
	//声明开启Activity的Action
	public static final String MYACTIVITY_ACTION = "com.baiduads.func.BrigeCodeActivity";
	private String TAG = "BrigeCodeActivity";
	public static FREContext _context;
	private LinearLayout layout;
	public static Boolean isLogin = false;
	protected static final int UPDATE_TEXT = 0;
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		switch (v.getId()) {
		case 1:
			finish();
			break;
		case 3:
			
			break;
		}
	}
	
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		//构建界面

		super.onCreate(savedInstanceState);
		Log.d(TAG, "---------onCreate-------");
		
		// 隐藏标题栏  
		this.requestWindowFeature(Window.FEATURE_NO_TITLE);  
		// 隐藏状态栏  
		this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,  
				WindowManager.LayoutParams.FLAG_FULLSCREEN);
		layout = new LinearLayout(this);
		layout.setOrientation(LinearLayout.HORIZONTAL);//VERTICAL
		this.setContentView(layout);
		layout.setId(1);
        layout.setOnClickListener(this);
        
        Intent intent = this.getIntent();
        Bundle bundle = intent.getExtras();
        int bridgeKey = bundle.getInt("bridgeKey");
        
        switch(bridgeKey)
        {
        	case 0:
        		atSplash();
        		break;
        		
        	case 1:
        		String adsID = bundle.getString("adsID");
        		atViedo(adsID);
        		break;
        	
        		
        	default:
        			break;
        }
        
		
	}
	
	private void atViedo(String adsID)
	{
		
		setContentView(_context.getResourceId("layout.videointerstitial"));
		
		final LinearLayout mainL = (LinearLayout)findViewById(_context.getResourceId("id.videointerstitiallinear"));
		
		//创建前贴片视频广告，AdSize.VideoInterstitial；广告位ID为null(广告位为""或者null时，表示默认广告位)
		final AdView adView = new AdView(this, AdSize.VideoInterstitial, null);
		//设置监听接口，当视频播放完时，将视图彻底移除。
		adView.setListener(new AdViewListener(){

			@Override
			public void onAdClick(JSONObject arg0) {
				
			}

			@Override
			public void onAdFailed(String arg0) {
				finish();
			}

			@Override
			public void onAdReady(AdView arg0) {
				
			}

			@Override
			public void onAdShow(JSONObject arg0) {
				
			}

			@Override
			public void onAdSwitch() {
				
			}

			@Override
			public void onVideoClickAd() {
				callBack(TAG, "onVideoClickAd");
			}

			@Override
			public void onVideoClickClose() {
				callBack(TAG, "onVideoClickClose");
				finish();
			}

			@Override
			public void onVideoClickReplay() {
				callBack(TAG, "onVideoClickReplay");
				
			}

			@Override
			public void onVideoError() {
				callBack(TAG, "onVideoError");
				finish();
			}

			@Override
			public void onVideoFinish() {
				callBack(TAG, "onVideoFinish");
				//检测到播放完成后移除广告
				mainL.removeView(adView);
				finish();
			}

			@Override
			public void onVideoStart() {
				callBack(TAG, "onVideoStart");
			}
			
		});
		mainL.addView(adView,new LinearLayout.LayoutParams(-1,-1));
	}
	/**
	 * 启动式广告
	 */
	@SuppressWarnings("unused")
	private void atSplash()
	{
		setContentView(_context.getResourceId("layout.splash"));
		
		RelativeLayout adsParent = (RelativeLayout)this.findViewById(_context.getResourceId("id.adsRl"));
		SplashAd splashAd= new SplashAd(this,adsParent,new SplashAdListener(){
			@Override
			public void onAdDismissed() {
				
				callBack(TAG,"onAdDismissed");//跳转至您的应用主界面
				callBack(TAG,"启动式广告显示完毕返回");
				finish();
			}
			@Override
			public void onAdFailed(String arg0) {
				callBack(TAG, "onAdDismissed");
				finish();
			}
			@Override
			public void onAdPresent() {
				callBack(TAG, "onAdDismissed");
				finish();
			}
		});
	}
	private void callBack(String _TAG,String status){
		Log.d(_TAG, "-----status----"+status);
		_context.dispatchStatusEventAsync(_TAG,status);
	}
	
	
	@Override  
	public boolean onKeyDown(int keyCode, KeyEvent event)  
	{  
		if (keyCode == KeyEvent.KEYCODE_BACK )  
		{  
			finish();
		}  
		return super.onKeyDown(keyCode, event);

	}  

}
