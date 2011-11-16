package utils;

/**
 * ...
 * @author MikeC
 */

class ColorConverter 
{

    public static inline function toRGB(int:Int) : RGB
    {
        return {
            r: ((int >> 16) & 255) / 255,
            g: ((int >> 8) & 255) / 255,
            b: (int & 255) / 255,
        }
    }
    
    public static function toInt(rgb:RGB) : Int
    {
        return (Math.round(rgb.r * 255) << 16) | (Math.round(rgb.g * 255) << 8) | Math.round(rgb.b * 255);
    }
    
    public static function rgb2hsl(rgb:RGB) : HSL
    {
        var max:Float = maxRGB(rgb);
        var min:Float = minRGB(rgb);
        var add:Float = max + min;
        var sub:Float = max - min;
        
        var h:Float = if (max == min)
        {
            0;
        } else if (max == rgb.r)
        {
            (60 * (rgb.g - rgb.b) / sub + 360) % 360;
        } else if (max == rgb.g)
        {
            60 * (rgb.b - rgb.r) / sub + 120;
        } else if (max == rgb.b)
        {
            60 * (rgb.r - rgb.g) / sub + 240;
        }
        
        var l:Float = add / 2;
        
        var s:Float = if (max == min)
        {
            0;
        } else if (l <= 1 / 2)
        {
            sub / add;
        } else
        {
            sub / (2 - add);
        }
        
        return {
            h: h,
            s: s,
            l: l,
        }
        
    }
    
    public static function hsl2rgb(hsl:HSL) : RGB
    {
        var q:Float = if (hsl.l < 1 / 2)
        {
            hsl.l * (1 + hsl.s);
        } else
        {
            hsl.l + hsl.s - (hsl.l * hsl.s);
        }
        
        var p:Float = 2 * hsl.l - q;
        
        var hk:Float = (hsl.h % 360) / 360;
        
        var tr:Float = hk + 1 / 3;
        var tg:Float = hk;
        var tb:Float = hk - 1 / 3;
        
        var tc:Array<Float> = [tr,tg,tb];
        for (n in 0...tc.length)
        {
            var t:Float = tc[n];
            if (t < 0) t += 1;
            if (t > 1) t -= 1;
            tc[n] = if (t < 1 / 6)
            {
                p + ((q - p) * 6 * t);
            } else if (t < 1 / 2)
            {
                q;
            } else if (t < 2 / 3)
            {
                p + ((q - p) * 6 * (2 / 3 - t));
            } else
            {
                p;
            }
        }
        
        return {
            r: tc[0],
            g: tc[1],
            b: tc[2],
        }
    }
    
    public static function rgb2hsv(rgb:RGB) : HSV
    {
        var max:Float = maxRGB(rgb);
        var min:Float = minRGB(rgb);
        var add:Float = max + min;
        var sub:Float = max - min;
        
        var h:Float = if (max == min)
        {
            0;
        } else if (max == rgb.r)
        {
            (60 * (rgb.g - rgb.b) / sub + 360) % 360;
        } else if (max == rgb.g)
        {
            60 * (rgb.b - rgb.r) / sub + 120;
        } else if (max == rgb.b)
        {
            60 * (rgb.r - rgb.g) / sub + 240;
        }
        
        var s:Float = if (max == 0)
        {
            0;
        } else
        {
            1 - min / max;
        }
        
        var v:Float = max;
        
        return {
            h: h,
            s: s,
            v: v,
        }
    }
    
    public static function hsv2rgb(hsv:HSV) : RGB
    {
        var d:Float = (hsv.h%360) / 60;
        if (d < 0) d += 6;
        var hf:Int = Math.floor(d);
        var hi:Int = hf % 6;
        var f:Float = d - hf;
        
        var v:Float = hsv.v;
        var p:Float = hsv.v * (1 - hsv.s);
        var q:Float = hsv.v * (1 - f * hsv.s);
        var t:Float = hsv.v * (1 - (1 - f) * hsv.s);
        
        return switch(hi)
        {
            case 0: { r:v, g:t, b:p };
            case 1: { r:q, g:v, b:p };
            case 2: { r:p, g:v, b:t };
            case 3: { r:p, g:q, b:v };
            case 4: { r:t, g:p, b:v };
            case 5: { r:v, g:p, b:q };
        }
    }
    
    public static function hsl2hsv(hsl:HSL) : HSV
    {
        return rgb2hsv(hsl2rgb(hsl));
    }
    
    public static function hsv2hsl(hsv:HSV) : HSL
    {
        return rgb2hsl(hsv2rgb(hsv));
    }
    
    public static inline function maxRGB(rgb:RGB) : Float
    {
        return Math.max(rgb.r, Math.max(rgb.g, rgb.b));
    }
    
    public static inline function minRGB(rgb:RGB) : Float
    {
        return Math.min(rgb.r, Math.min(rgb.g, rgb.b));
    }
}

typedef RGB = {
    var r:Float;
    var g:Float;
    var b:Float;
}

typedef HSL = {
    var h:Float;
    var s:Float;
    var l:Float;
}

typedef HSV = {
    var h:Float;
    var s:Float;
    var v:Float;
}