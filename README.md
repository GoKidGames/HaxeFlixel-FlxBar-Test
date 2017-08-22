# HaxeFlixel-FlxBar-Test
Test subject to demonstrate the FlxBar memory leak when using parentRef/variable.

UPDATE:
It's not a memory leak. It does use a lot of memory due to reflection but it gets GC. Updating the value manually is better for most uses, IMO.
