.PHONY: put zip

put:
	rsync -vrt --delete --exclude=.git . /Volumes/Elder\ Scrolls\ Online/live/AddOns/LibCraftText

get:
	cp -f /Volumes/Elder\ Scrolls\ Online/live/SavedVariables/ZZDailyWrits.lua data/


zip:
	-rm -rf published/LibCraftText published/LibCraftText\ x.x.x.zip
	mkdir -p published/LibCraftText
	cp -R lang published/LibCraftText/lang
	cp ./LibCraftText* published/LibCraftText/

	cd published; zip -r LibCraftText\ x.x.x.zip LibCraftText

	rm -rf published/LibCraftText
