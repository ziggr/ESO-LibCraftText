


# Learnin' the Dailies

Have 10 alts:

- Each certfied to perform writs
- One of each crafting rank
- For Provisioning recipe writs, distribute alts across EP AD DC ranks 1-3
  (Provisioning rank 4+ ignore alliance)

Daily

- For each alt:

  - Log in
  - `/lct abandon` to **Abandon all daily crafting quests** from yesterday's cycle, then forget all previously recorded daily quest text.
  - Acquire all daily crafting quests for today's cycle
  - For each language: ---
    - `/lct scanlang` to record current language, then switch to next. 
      Or use `/lct scan` and `/lct lang` separately if you want to take twice as long.
  - Repeat `/lct` cycle until you loop back to EN English

  - `/logout`

- Repeat Login-Logout steps 2-9 for each alt

- Occasionally check SavedVariables to see if you collected all 7 languages

Takes about an hour to scan 10 alts x 7 languages using `/lct scan` + `/lct lang` separately:
```
2018-11-03 08:39:45 -0700 start
2018-11-03 08:52:16 -0700 `/logout` alt-one 12min/2alts = 6min/alt
2018-11-03 08:58:52 -0700 alt-two 18min/3alts = 6min/alt
2018-11-03 09:03:52 -0700
2018-11-03 09:10:20 -0700 alt-four 30min/5 alts = 6min/alt
2018-11-03 09:14:23 -0700
2018-11-03 09:17:30 -0700 alt-six
2018-11-03 09:20:17 -0700 alt-seven
2018-11-03 09:23:37 -0700 alt-eight
2018-11-03 09:29:42 -0700 alt-nine. Done. 50min/10alts = 5min/altmak 

...
2018-11-03 10:10:32 -0700 make gentest passes, lang_db.lua scrubbed. ~90min
```

## Alinor

The Alinor crafting area is perfect for this. Park your alts in the circle by the writ boards.

## Absorb the scan

### 1. `make getpts`
to copy the SavedVariables to `data/LibCraftText.lua`

### 2.`make lang`
to merge SavedVariables and `data/lang_db.lua` into a new `data/lang_db_out.lua` as well as generate 7 new `lang/xx.lua` localization files.

Compare `lang_db_out.lua` against `lang_db.out` to see if it picked up everything you expect, and didn't ruin any previous data or go haywire. When you're happy with the result, copy `lang_db_out.lua` over `lang_db.lua` to start using it for test generation.

### 3. `make gentest`
to copy newly acquired condition text into `test/gen_test.data.lua`

#### 3.1 Repair Damaged lang_db.lua

Once the new text is absorbed, there's a good chance that some of the old tests that _used_ to pass no longer do. This is because one or more of the new lang_tables in SavedVariables are BROKEN. I've seen "Craft a Nightwood Shield" lang_table polluted with "Craft a Nightwood Ice Staff" russian and other languages. Not sure how this still happens, but it does.

Find and delete the offending `lang_db.lua` entries until `make gentest` passes again.

# `/script` Commands

`/script SetCVar("language.2","en")` Change language to `en`. Official languages are `en de fr` , unofficial are `es ru it ja` but `it` is really incomplete. Also `/lct en` is an alias for SetCVar(en)





