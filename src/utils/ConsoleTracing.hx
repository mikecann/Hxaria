package utils;
import haxe.PosInfos;
import js.Lib;

/**
 * ...
 * @author mikecann.co.uk
 */

class ConsoleTracing 
{

	public static function setRedirection() 
	{		
        haxe.Log.trace = myTrace;
    }

    private static function myTrace( v : Dynamic, ?inf : PosInfos ) 
	{
		var c:Dynamic = untyped __js__('console');
		c.log(inf.className+"::"+inf.methodName+"["+inf.lineNumber+"] "+v);
    }
	
}