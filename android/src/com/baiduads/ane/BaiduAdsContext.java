package com.baiduads.ane;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.baiduads.func.BaiduAdsExit;
import com.baiduads.func.BaiduAdsIcons;
import com.baiduads.func.BaiduAdsInter;
import com.baiduads.func.BaiduAdsSplash;
import com.baiduads.func.BaiduAdsDes;
import com.baiduads.func.BaiduAdsCode;
import com.baiduads.func.BaiduAdsVideo;

/**
 * @author Rect
 * @see rectvv@gmail.com
 * @see www.shadowkong.com
 * @see github.com/platformanes
 * @version 2014-1-6
 */
public class BaiduAdsContext extends FREContext {
	/**
	 * 启动式
	 */
	public static final String BAIDUADS_FUNCTION_SPLASH = "baiduads_function_splash";
	/**
	 * 声明式
	 */
	public static final String BAIDUADS_FUNCTION_DEC = "baiduads_function_simple_dec";
	/**
	 * 代码式
	 */
	public static final String BAIDUADS_FUNCTION_CODE = "baiduads_function_simple_code";
	/**
	 * 视频式
	 */
	public static final String BAIDUADS_FUNCTION_VIEDO = "baiduads_function_video";
	/**
	 * 插屏式
	 */
	public static final String BAIDUADS_FUNCTION_INTERAD = "baiduads_function_interad";
	/**
	 * 轮盘式
	 */
	public static final String BAIDUADS_FUNCTION_ICONSAD = "baiduads_function_iconsad";
	/**
	 * 退出
	 */
	public static final String BAIDUADS_FUNCTION_EXIT = "baiduads_function_exit";
	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		// TODO Auto-generated method stub
		Map<String, FREFunction> map = new HashMap<String, FREFunction>();
//	       //映射
		   map.put(BAIDUADS_FUNCTION_SPLASH, new BaiduAdsSplash());
	       map.put(BAIDUADS_FUNCTION_DEC, new BaiduAdsDes());
	       map.put(BAIDUADS_FUNCTION_CODE, new BaiduAdsCode());
	       
	       map.put(BAIDUADS_FUNCTION_VIEDO, new BaiduAdsVideo());
	       map.put(BAIDUADS_FUNCTION_INTERAD, new BaiduAdsInter());
	       map.put(BAIDUADS_FUNCTION_ICONSAD, new BaiduAdsIcons());
	       
	       map.put(BAIDUADS_FUNCTION_EXIT, new BaiduAdsExit());
	       return map;
	}

}
