.PHONY: put zip lang

put:
	rsync -vrt --delete --exclude=.git . /Volumes/Elder\ Scrolls\ Online/live/AddOns/LibCraftText

get:
	cp -f /Volumes/Elder\ Scrolls\ Online/live/SavedVariables/LibCraftText.lua data/

getpts:
	cp -f /Volumes/Elder\ Scrolls\ Online/pts/SavedVariables/LibCraftText.lua data/


zip:
	-rm -rf published/LibCraftText published/LibCraftText\ x.x.x.zip
	mkdir -p published/LibCraftText
	cp -R lang published/LibCraftText/lang
	cp ./LibCraftText.* published/LibCraftText/

	cd published; zip -r LibCraftText\ x.x.x.zip LibCraftText

	rm -rf published/LibCraftText

lang:
	lua lang_gen.lua
