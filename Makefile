.PHONY: put zip lang test gentest

put:
	rsync -vrt --delete --exclude=.git --exclude=l10n-unofficial --exclude=published . /Volumes/Elder\ Scrolls\ Online/live/AddOns/LibCraftText

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
	lua lang/en.lua
	lua lang/*.lua

# --repeat 6 to loop through all 6 supported languages. Skipping Italian.
test:
	lua test/test_parse.lua --repeat 7

gentest: test/gen_test.data.lua
	lua test/test_gen.lua --repeat 7


test/gen_test.data.lua: test/gen_test.lua data/lang_db.lua
	lua test/gen_test.lua
