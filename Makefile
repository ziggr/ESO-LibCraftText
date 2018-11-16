.PHONY: put zip lang test gentest alch

put:
	rsync -vrt --delete --exclude=.git \
		--exclude=l10n-unofficial \
		--exclude=published \
		--exclude=alch \
		--exclude=doc \
		--exclude=data \
		--exclude=test \
		. /Volumes/Elder\ Scrolls\ Online/live/AddOns/LibCraftText


# get/getpts copies SavedVariables/LibCraftText.lua from gaming PC to
# linux laptop's data/LibCraftText.lua
get:
	cp -f /Volumes/Elder\ Scrolls\ Online/live/SavedVariables/LibCraftText.lua data/

getpts:
	cp -f /Volumes/Elder\ Scrolls\ Online/pts/SavedVariables/LibCraftText.lua data/


zip:
	-rm -rf published/LibCraftText published/LibCraftText\ x.x.x.zip
	mkdir -p 				   published/LibCraftText
	cp -R lang 				   published/LibCraftText/lang
	cp ./LibCraftText.* 	   published/LibCraftText/
	cp ./LibCraftText_Example* published/LibCraftText/

	cd published; zip -r LibCraftText\ x.x.x.zip LibCraftText

	rm -rf published/LibCraftText

# lang merges saved variables data/LibCraftText.lua + previous data/lang_db.lua
# to generate a new data/lang_db_out.lua , along with 7 lang/xx.lua files.
#
# Be careful with dependencies here: lang_db_out is derived from lang_db, but
# the cp step then replaces lang_db with the results, which makes a cycle.
lang:
	lua lang_gen.lua
	lua lang/en.lua
	lua lang/*.lua
	cp  data/lang_db_out.lua data/lang_db.lua


# --repeat 6 to loop through all 6 supported languages. Skipping Italian.
test:
	lua test/test_parse.lua --repeat 7

# Also re-generates gen_test.data.lua, thanks to its dependency rule.
gentest: test/gen_test.data.lua
	lua test/test_gen.lua --repeat 7


test/gen_test.data.lua: test/gen_test.lua data/lang_db.lua
	lua test/gen_test.lua


alch: alch/alch.out

alch/alch: alch/alch.go
	cd alch; go build alch.go

alch/alch.out: alch/alch
	cd alch; ./alch 2>&1 > alch.out

