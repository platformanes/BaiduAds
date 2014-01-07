package com.baiduads.ane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**
 * @author Rect
 * @version  Time：2013-5-8 
 */
public class BaiduAdsExtension implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		// TODO Auto-generated method stub
		return new BaiduAdsContext();
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub

	}

}
