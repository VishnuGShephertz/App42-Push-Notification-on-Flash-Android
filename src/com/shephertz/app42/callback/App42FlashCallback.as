package com.shephertz.app42.callback
{
	import com.shephertz.app42.paas.sdk.as3.App42CallBack;
	import com.shephertz.app42.paas.sdk.as3.App42Exception;
	import com.shephertz.app42.paas.sdk.as3.util.Util;

	public class App42FlashCallback implements App42CallBack
	{
		public function onSuccess(obj:Object):void{
			trace("response ",Util.toString(obj));
		}
		public function onException(exception:App42Exception):void{
			trace("response ",Util.toString(exception));
		}
	}
}