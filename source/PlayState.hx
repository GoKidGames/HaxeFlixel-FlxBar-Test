package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;

class PlayState extends FlxState
{
    private var _flxBars:Array<FlxBar>;
    private var _parentRefs:Array<FlxSprite>;
    private var _toggleManualButton:FlxButton;
    private var _barCount:Int;
    
    override public function create():Void
    {
        FlxG.debugger.visible = true;
        
        var cols:Int = 8;
        var rows:Int = 6;
        var spacing:Int = 4;
        var barHeight:Int = 6;
        var spriteSize:Int = 32;
        var buttonHeight:Int = 30;
        var buttonWidth:Int = 80;
        var startX:Float = (FlxG.width - ((spriteSize + spacing) * cols)) / 2;
        var startY:Float = (FlxG.height - ((spriteSize + spacing) * rows) + (buttonHeight + spacing)) / 2;
        var x:Float = 0;
        var y:Float = 0;
        var count:Int = 0;
        
        var randomizeButton = new FlxButton(startX + buttonWidth + spacing, startY - (buttonHeight + spacing), "Randomize", randomizeHealth);
        _toggleManualButton = new FlxButton(startX, startY - (buttonHeight + spacing), "ParentRef", toggleManual);
        
        _barCount = cols * rows;
        
        _parentRefs = new Array();
        _flxBars = new Array();
        
        for (i in 0...cols)
        {
            for (j in 0...rows)
            {
                x = startX + (i * (spriteSize + spacing));
                y = startY + (j * (spriteSize + spacing));
                
                _parentRefs[count] = new FlxSprite(x, y).makeGraphic(spriteSize, spriteSize, 0xFF666666);
                _flxBars[count] = new FlxBar(x, y, null, spriteSize, barHeight, _parentRefs[count], "health");
                
                add(_parentRefs[count]);
                add(_flxBars[count]);
                
                count++;
            }
        }
        
        randomizeHealth();
        
        add(randomizeButton);
        add(_toggleManualButton);
        
        super.create();
    }
    
    override public function update(elapsed:Float):Void
    {
        if (_toggleManualButton.text == "Manual")
        {
            for (i in 0..._barCount)
                if (_flxBars[i].value != _parentRefs[i].health)
                    _flxBars[i].value = _parentRefs[i].health;
        }
        
        super.update(elapsed);
    }
    
    private function randomizeHealth():Void
    {
        for (i in 0..._barCount)
            _parentRefs[i].health = Math.random() * 100;
    }
    
    private function toggleManual():Void
    {
        if (_toggleManualButton.text == "Manual")
        {	
            for (i in 0..._barCount)
                _flxBars[i].setParent(_parentRefs[i], "health");
            
            _toggleManualButton.text = "ParentRef";
        }
        else
        {
            for (i in 0..._barCount)
                _flxBars[i].setParent(null, "");
            
            _toggleManualButton.text = "Manual";
        }
    }
}
