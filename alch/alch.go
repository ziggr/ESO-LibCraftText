package main

import (
    "fmt"
    "strings"
    )

const CELL_EMPTY    = "  "
const CELL_LEARNING = "!!"
const CELL_NEGATE   = "--"

// TraitWord -----------------------------------------------------------------
//
// We mostly store sets of traits as bits in a TraitWord. Hopefully this will
// reduce storage and compuation costs.
//
type TraitWord uint32

func (tw TraitWord) String() string {
    var s string
    var t []string
    for _,tr := range ALL_TRAITS {
        if 0 != (tr.trait_word & tw) {
            s = tr.abbrev
        } else {
            s = CELL_EMPTY
        }
        t = append(t,s)
    }
    return fmt.Sprintf("%s",t)
}

// How many 1 bits?
func (tw TraitWord)CountTraits() int {
    result := 0
    // fmt.Printf("     ct tw:%s\n", tw)
    for _,pt := range ALL_TRAITS {
        if 0 != (tw & pt.trait_word) {
            result += 1
            // fmt.Printf("      %2d   %s\n", result, pt.trait_word)
        }
    }
    return result
}

// Return a line showing possible as lowercase, and intersections with
// highlight as uppercase.
func ScoreLine(possible, highlight TraitWord) string {
    var s string
    var t []string
    for _,tr := range ALL_TRAITS {
        if 0 != (tr.trait_word & possible) {
            s = tr.abbrev
        } else {
            s = CELL_EMPTY
        }
        if 0 != (tr.trait_word & highlight) {
            s = strings.ToUpper(s)
        }
        t = append(t,s)
    }
    return fmt.Sprintf("%s",t)
}

// Trait ---------------------------------------------------------------------
//
// A single trait such as "Increase Spell Power" or "Vitality" that an alchemy
// reagent can produce in a potion or poison.
//
type Trait struct {
    trait_word      TraitWord
    abbrev          string
    name            string
    negate_name     string

    negate_trait    *Trait

    reagent_list    []*Reagent
    // reagent list here
}

// Reagent -------------------------------------------------------------------
//
// An alchemy ingredient such as "Blessed Thistle" or "Imp Stool".
// Each reagent has exactly 4 traits.
//
type Reagent struct {
    abbrev          string
    name            string

    trait_list      [4]*Trait
    possible        TraitWord       // Our 4 traits
    negated         TraitWord       // What those 4 traits negate
    unknown         TraitWord       // Which of our 4 traits have we not yet learned?
}

func (o *Reagent)String() string {
    var tr_list []string
    for _,tr := range ALL_TRAITS {
        ks := o.Known(tr)
        s := CELL_EMPTY
        switch ks {
        case known:
            s = strings.ToUpper(tr.abbrev)
        case unknown:
            s = strings.ToLower(tr.abbrev)
        case negated:
            s = CELL_NEGATE
        }
        tr_list = append(tr_list, s)
    }
    return fmt.Sprintf("%-9.9s: %s", o.abbrev, tr_list)
}

func (o *Reagent)Known(t *Trait) KnownState {
                        // Do any of our traits negate the requested trait?
    if 0 != (t.trait_word & o.negated) {
        return negated
    }
                        // Is it one of our 4 traits?
    if 0 == (t.trait_word & o.possible) {
        return not_possible
    }
                        // And not still unknown?
    if 0 == (t.trait_word & o.unknown) {
        return known
    }
    return unknown
}

func (o *Reagent)Learn(tw TraitWord) {
    o.unknown = o.unknown & (^tw)
}

func (o *Reagent)Contributes(tw TraitWord) TraitWord {
    if nil == o { return 0 }
    return o.possible & tw
}

// Return a trait line with
// Known traits uppercase
// Unknown traits lowercase
// Unknown LEARNED traits (from learn_tw) as !!
// negated traits dashed out --
func (o *Reagent)LearnLine(learn_tw TraitWord) string {
    if o == nil { return "" }
    var tr_list []string
    learn_ct := 0
    for _,tr := range ALL_TRAITS {
        ks := o.Known(tr)
        s := CELL_EMPTY
        switch ks {
        case known:
            s = strings.ToUpper(tr.abbrev)
        case unknown:
            if 0 != (tr.trait_word & learn_tw) {
                s = CELL_LEARNING
                learn_ct++
            } else {
                s = strings.ToLower(tr.abbrev)
            }
        case negated:
            s = CELL_NEGATE
        }
        tr_list = append(tr_list, s)
    }
    return fmt.Sprintf("%-9.9s %2d: %s", o.abbrev, learn_ct, tr_list)
}

// Big giant table of reagents down the left, traits across the top.
func DumpAllReagents() {
    for _,v := range ALL_REAGENTS {
        fmt.Println(v)
    }
}

// KnownState ----------------------------------------------------------------
//
// Result from Reagent.Known(). Have we Learn()ed this trait for this reagent?
// Is it one of the reagent's 4 possible traits? 4 negated traits?
//
type KnownState uint32
const (
    known           KnownState = iota
    unknown
    not_possible
    negated
)

// Combination ---------------------------------------------------------------
//
// A set of 2 or 3 reagents. Mixed together they produce 0 or more traits.
// They learn 0 or more reagent traits.
type Combination struct {
    a   *Reagent
    b   *Reagent
    c   *Reagent        // c can be nil

                        // Lazy-calc and cache
    result_tw           TraitWord
    result_tw_valid     bool
    score               int
    score_valid         bool
}

// Return the traits produced by a mix of these 2 or 3 reagents.
func (o *Combination) CalcTraits() TraitWord {
    if o.result_tw_valid { return o.result_tw }

                        // Any trait in 2 or more reagents.
    on := o.a.possible & o.b.possible
    if nil != o.c {
        on |= (o.a.possible & o.c.possible)
        on |= (o.b.possible & o.c.possible)
    }

                        // And disabled by ANY negate
    off := o.a.negated | o.b.negated
    if nil != o.c {
        off |= o.c.negated
    }

    result := on & ^off

    o.result_tw = result
    o.result_tw_valid = true

    return o.result_tw
}

// Return the number of reagent trait cells that would be learned by mixing
// this potion.
//
// If ANY of the reagents contributes nothing to this potion, return 0.
//
func (o *Combination)Score() int {
    if o.score_valid { return o.score }

    score := 0
    tw := o.CalcTraits()
    if o.a.Contributes(tw) == 0 ||
       o.b.Contributes(tw) == 0 ||
       (o.c != nil && (o.c.Contributes(tw) == 0)) {
    } else {
        score += (tw & o.a.unknown).CountTraits()
        score += (tw & o.b.unknown).CountTraits()
        if nil != o.c {
            score += (tw & o.c.unknown).CountTraits()
        }
    }
    o.score = score
    o.score_valid = true
    return o.score
}

// Write the 2 or 3 reagent lines out, counting and  highlighting any reagent
// traits being learned in this combination.
// Write a "score" line adding up the learned reagent traits and listing the
// resulting traits.
func (o *Combination)DumpScore() {
    tw         := o.CalcTraits()
    fmt.Println(o.a.LearnLine(tw))
    fmt.Println(o.b.LearnLine(tw))
    if nil != o.c {
        fmt.Println(o.c.LearnLine(tw))
    }
    score := o.Score()
    fmt.Printf("%-9s %2d: %s\n", "score",score, tw)
}

// Pretend we just crafted this potion, learning the reagent traits.
func (o *Combination)Learn() {
    tw := o.CalcTraits()
    o.a.Learn(tw)
    o.b.Learn(tw)
    o.c.Learn(tw)
}

// -- Scan for possible winning combos ---------------------------------------

// Learn every reagent, every trait.
func LearnAll() {
                        // Go reagent-by-reagent, learning all 4 traits
                        // of each reagent.
                        // At WORST this would be mixing up
                        // 28 reagents * 4 traits = 112 combinations.
    combo_ct := 0
    for _,pr := range ALL_REAGENTS {
        for _,pt := range pr.trait_list {
            combo := LearnOneTrait(pr, pt)
            if combo != nil {
                combo_ct++
                fmt.Printf("Combination %d:\n", combo_ct)
                combo.DumpScore()
            }
        }
    }
}

// Return a combination that teaches Reagent ra its possible Trait tr.
// Return nil if ra already knows, or cannot possibly know, tr.
func LearnOneTrait(ra *Reagent, pt *Trait) *Combination {
// fmt.Printf("%s %s: ", ra.abbrev, pt.abbrev)
    known_state := ra.Known(pt)
    if known_state != unknown {
// fmt.Printf(" not unknown\n")
        return nil
    }

    b_list := pt.reagent_list
    c_list := ALL_REAGENTS_PLUS_NIL

    var longest_combo *Combination

    combo_ct := 0
    for _,rb := range b_list {
        if rb == ra { continue }
// fmt.Printf(" %3.3s", rb.abbrev)
        for _,rc := range c_list {
            if rc == rb || rc == ra { continue }
            combo_ct++
// fmt.Printf(".")
            combo := Combination{a:ra, b:rb, c:rc}
            if (nil == longest_combo) || (longest_combo.Score() < combo.Score()) {
                longest_combo = &combo
            }
        }
    }
// longest_score := 0
// if nil != longest_combo { longest_score = longest_combo.Score() }
// fmt.Printf(" combo_ct:%d  longest.Score():%d\n", combo_ct, longest_score )
    if nil != longest_combo {
        longest_combo.Learn()
    }
    return longest_combo
}

var BREACH                = Trait{ trait_word:1<< 0, abbrev:"br", name:"BREACH"               ,  negate_name:"INCREASE_SPELL_RESIST" }
var COWARDICE             = Trait{ trait_word:1<< 1, abbrev:"cw", name:"COWARDICE"            ,  negate_name:"INCREASE_SPELL_POWER"  }
var DEFILE                = Trait{ trait_word:1<< 2, abbrev:"df", name:"DEFILE"               ,  negate_name:"VITALITY"              }
var DETECTION             = Trait{ trait_word:1<< 3, abbrev:"dt", name:"DETECTION"            ,  negate_name:"INVISIBLE"             }
var ENERVATION            = Trait{ trait_word:1<< 4, abbrev:"ev", name:"ENERVATION"           ,  negate_name:"WEAPON_CRITICAL"       }
var ENTRAPMENT            = Trait{ trait_word:1<< 5, abbrev:"et", name:"ENTRAPMENT"           ,  negate_name:"UNSTOPPABLE"           }
var FRACTURE              = Trait{ trait_word:1<< 6, abbrev:"fc", name:"FRACTURE"             ,  negate_name:"INCREASE_ARMOR"        }
var GRADUAL_RAVAGE_HEALTH = Trait{ trait_word:1<< 7, abbrev:"gr", name:"GRADUAL_RAVAGE_HEALTH",  negate_name:"LINGERING_HEALTH"      }
var HINDRANCE             = Trait{ trait_word:1<< 8, abbrev:"hn", name:"HINDRANCE"            ,  negate_name:"SPEED"                 }
var INCREASE_ARMOR        = Trait{ trait_word:1<< 9, abbrev:"am", name:"INCREASE_ARMOR"       ,  negate_name:"FRACTURE"              }
var INCREASE_SPELL_POWER  = Trait{ trait_word:1<<10, abbrev:"sp", name:"INCREASE_SPELL_POWER" ,  negate_name:"COWARDICE"             }
var INCREASE_SPELL_RESIST = Trait{ trait_word:1<<11, abbrev:"sr", name:"INCREASE_SPELL_RESIST",  negate_name:"BREACH"                }
var INCREASE_WEAPON_POWER = Trait{ trait_word:1<<12, abbrev:"wp", name:"INCREASE_WEAPON_POWER",  negate_name:"MAIM"                  }
var INVISIBLE             = Trait{ trait_word:1<<13, abbrev:"iv", name:"INVISIBLE"            ,  negate_name:"DETECTION"             }
var LINGERING_HEALTH      = Trait{ trait_word:1<<14, abbrev:"lh", name:"LINGERING_HEALTH"     ,  negate_name:"GRADUAL_RAVAGE_HEALTH" }
var MAIM                  = Trait{ trait_word:1<<15, abbrev:"mm", name:"MAIM"                 ,  negate_name:"INCREASE_WEAPON_POWER" }
var PROTECTION            = Trait{ trait_word:1<<16, abbrev:"pr", name:"PROTECTION"           ,  negate_name:"VULNERABILITY"         }
var RAVAGE_HEALTH         = Trait{ trait_word:1<<17, abbrev:"-h", name:"RAVAGE_HEALTH"        ,  negate_name:"RESTORE_HEALTH"        }
var RAVAGE_MAGICKA        = Trait{ trait_word:1<<18, abbrev:"-m", name:"RAVAGE_MAGICKA"       ,  negate_name:"RESTORE_MAGICKA"       }
var RAVAGE_STAMINA        = Trait{ trait_word:1<<19, abbrev:"-s", name:"RAVAGE_STAMINA"       ,  negate_name:"RESTORE_STAMINA"       }
var RESTORE_HEALTH        = Trait{ trait_word:1<<20, abbrev:"+h", name:"RESTORE_HEALTH"       ,  negate_name:"RAVAGE_HEALTH"         }
var RESTORE_MAGICKA       = Trait{ trait_word:1<<21, abbrev:"+m", name:"RESTORE_MAGICKA"      ,  negate_name:"RAVAGE_MAGICKA"        }
var RESTORE_STAMINA       = Trait{ trait_word:1<<22, abbrev:"+s", name:"RESTORE_STAMINA"      ,  negate_name:"RAVAGE_STAMINA"        }
var SPEED                 = Trait{ trait_word:1<<23, abbrev:"sd", name:"SPEED"                ,  negate_name:"HINDRANCE"             }
var SPELL_CRITICAL        = Trait{ trait_word:1<<24, abbrev:"sc", name:"SPELL_CRITICAL"       ,  negate_name:"UNCERTAINTY"           }
var UNCERTAINTY           = Trait{ trait_word:1<<25, abbrev:"un", name:"UNCERTAINTY"          ,  negate_name:"SPELL_CRITICAL"        }
var UNSTOPPABLE           = Trait{ trait_word:1<<26, abbrev:"us", name:"UNSTOPPABLE"          ,  negate_name:"ENTRAPMENT"            }
var VITALITY              = Trait{ trait_word:1<<27, abbrev:"vi", name:"VITALITY"             ,  negate_name:"DEFILE"                }
var VULNERABILITY         = Trait{ trait_word:1<<28, abbrev:"vu", name:"VULNERABILITY"        ,  negate_name:"PROTECTION"            }
var WEAPON_CRITICAL       = Trait{ trait_word:1<<29, abbrev:"wc", name:"WEAPON_CRITICAL"      ,  negate_name:"ENERVATION"            }

var ALL_TRAITS   = [...]*Trait{ &BREACH                ,
                                &COWARDICE             ,
                                &DEFILE                ,
                                &DETECTION             ,
                                &ENERVATION            ,
                                &ENTRAPMENT            ,
                                &FRACTURE              ,
                                &GRADUAL_RAVAGE_HEALTH ,
                                &HINDRANCE             ,
                                &INCREASE_ARMOR        ,
                                &INCREASE_SPELL_POWER  ,
                                &INCREASE_SPELL_RESIST ,
                                &INCREASE_WEAPON_POWER ,
                                &INVISIBLE             ,
                                &LINGERING_HEALTH      ,
                                &MAIM                  ,
                                &PROTECTION            ,
                                &RAVAGE_HEALTH         ,
                                &RAVAGE_MAGICKA        ,
                                &RAVAGE_STAMINA        ,
                                &RESTORE_HEALTH        ,
                                &RESTORE_MAGICKA       ,
                                &RESTORE_STAMINA       ,
                                &SPEED                 ,
                                &SPELL_CRITICAL        ,
                                &UNCERTAINTY           ,
                                &UNSTOPPABLE           ,
                                &VITALITY              ,
                                &VULNERABILITY         ,
                                &WEAPON_CRITICAL       }

var BEETLE_SCUTTLE           = Reagent{ abbrev:"beet scut", name:"BEETLE_SCUTTLE"          , trait_list:[4]*Trait{ &BREACH                , &PROTECTION            , &INCREASE_ARMOR        , &VITALITY         } }
var BLESSED_THISTLE          = Reagent{ abbrev:"bles this", name:"BLESSED_THISTLE"         , trait_list:[4]*Trait{ &RESTORE_STAMINA       , &INCREASE_WEAPON_POWER , &RAVAGE_HEALTH         , &SPEED            } }
var BLUE_ENTOLOMA            = Reagent{ abbrev:"blue ento", name:"BLUE_ENTOLOMA"           , trait_list:[4]*Trait{ &RAVAGE_MAGICKA        , &COWARDICE             , &RESTORE_HEALTH        , &INVISIBLE        } }
var BUGLOSS                  = Reagent{ abbrev:"bugloss  ", name:"BUGLOSS"                 , trait_list:[4]*Trait{ &INCREASE_SPELL_RESIST , &COWARDICE             , &RESTORE_HEALTH        , &RESTORE_MAGICKA  } }
var BUTTERFLY_WING           = Reagent{ abbrev:"butt wing", name:"BUTTERFLY_WING"          , trait_list:[4]*Trait{ &RESTORE_HEALTH        , &LINGERING_HEALTH      , &UNCERTAINTY           , &VITALITY         } }
var CLAM_GALL                = Reagent{ abbrev:"clam gall", name:"CLAM_GALL"               , trait_list:[4]*Trait{ &INCREASE_SPELL_RESIST , &HINDRANCE             , &VULNERABILITY         , &DEFILE           } }
var COLUMBINE                = Reagent{ abbrev:"columbine", name:"COLUMBINE"               , trait_list:[4]*Trait{ &RESTORE_HEALTH        , &RESTORE_STAMINA       , &RESTORE_MAGICKA       , &UNSTOPPABLE      } }
var CORN_FLOWER              = Reagent{ abbrev:"corm flow", name:"CORN_FLOWER"             , trait_list:[4]*Trait{ &RESTORE_MAGICKA       , &RAVAGE_HEALTH         , &INCREASE_SPELL_POWER  , &DETECTION        } }
var DRAGONTHORN              = Reagent{ abbrev:"dragthorn", name:"DRAGONTHORN"             , trait_list:[4]*Trait{ &INCREASE_WEAPON_POWER , &FRACTURE              , &RESTORE_STAMINA       , &WEAPON_CRITICAL  } }
var EMETIC_RUSSULA           = Reagent{ abbrev:"emtc russ", name:"EMETIC_RUSSULA"          , trait_list:[4]*Trait{ &RAVAGE_HEALTH         , &RAVAGE_STAMINA        , &RAVAGE_MAGICKA        , &ENTRAPMENT       } }
var FLESHFLY_LARVA           = Reagent{ abbrev:"flesh lrv", name:"FLESHFLY_LARVA"          , trait_list:[4]*Trait{ &RAVAGE_STAMINA        , &GRADUAL_RAVAGE_HEALTH , &VULNERABILITY         , &VITALITY         } }
var IMP_STOOL                = Reagent{ abbrev:"imp stool", name:"IMP_STOOL"               , trait_list:[4]*Trait{ &MAIM                  , &INCREASE_ARMOR        , &RAVAGE_STAMINA        , &ENERVATION       } }
var LADYS_SMOCK              = Reagent{ abbrev:"lady smck", name:"LADYS_SMOCK"             , trait_list:[4]*Trait{ &INCREASE_SPELL_POWER  , &BREACH                , &RESTORE_MAGICKA       , &SPELL_CRITICAL   } }
var LUMINOUS_RUSSULA         = Reagent{ abbrev:"lumi russ", name:"LUMINOUS_RUSSULA"        , trait_list:[4]*Trait{ &RAVAGE_STAMINA        , &RESTORE_HEALTH        , &MAIM                  , &HINDRANCE        } }
var MOUNTAIN_FLOWER          = Reagent{ abbrev:"moun flow", name:"MOUNTAIN_FLOWER"         , trait_list:[4]*Trait{ &INCREASE_ARMOR        , &MAIM                  , &RESTORE_HEALTH        , &RESTORE_STAMINA  } }
var MUDCRAB_CHITIN           = Reagent{ abbrev:"mudc chit", name:"MUDCRAB_CHITIN"          , trait_list:[4]*Trait{ &INCREASE_SPELL_RESIST , &PROTECTION            , &INCREASE_ARMOR        , &DEFILE           } }
var NAMIRAS_ROT              = Reagent{ abbrev:"namra rot", name:"NAMIRAS_ROT"             , trait_list:[4]*Trait{ &SPELL_CRITICAL        , &INVISIBLE             , &SPEED                 , &UNSTOPPABLE      } }
var NIGHTSHADE               = Reagent{ abbrev:"nigt shad", name:"NIGHTSHADE"              , trait_list:[4]*Trait{ &RAVAGE_HEALTH         , &GRADUAL_RAVAGE_HEALTH , &PROTECTION            , &DEFILE           } }
var NIRNROOT                 = Reagent{ abbrev:"nirnroot ", name:"NIRNROOT"                , trait_list:[4]*Trait{ &RAVAGE_HEALTH         , &ENERVATION            , &UNCERTAINTY           , &INVISIBLE        } }
var POWDERED_MOTHER_OF_PEARL = Reagent{ abbrev:"pmot perl", name:"POWDERED_MOTHER_OF_PEARL", trait_list:[4]*Trait{ &LINGERING_HEALTH      , &SPEED                 , &VITALITY              , &PROTECTION       } }
var SCRIB_JELLY              = Reagent{ abbrev:"scrib jel", name:"SCRIB_JELLY"             , trait_list:[4]*Trait{ &RAVAGE_MAGICKA        , &VULNERABILITY         , &SPEED                 , &LINGERING_HEALTH } }
var SPIDER_EGG               = Reagent{ abbrev:"spidr egg", name:"SPIDER_EGG"              , trait_list:[4]*Trait{ &HINDRANCE             , &LINGERING_HEALTH      , &INVISIBLE             , &DEFILE           } }
var STINKHORN                = Reagent{ abbrev:"stinkhorn", name:"STINKHORN"               , trait_list:[4]*Trait{ &FRACTURE              , &INCREASE_WEAPON_POWER , &RAVAGE_HEALTH         , &RAVAGE_STAMINA   } }
var TORCHBUG_THORAX          = Reagent{ abbrev:"torch thx", name:"TORCHBUG_THORAX"         , trait_list:[4]*Trait{ &FRACTURE              , &DETECTION             , &ENERVATION            , &VITALITY         } }
var VIOLET_COPRINUS          = Reagent{ abbrev:"violt cop", name:"VIOLET_COPRINUS"         , trait_list:[4]*Trait{ &BREACH                , &INCREASE_SPELL_POWER  , &RAVAGE_HEALTH         , &RAVAGE_MAGICKA   } }
var WATER_HYACINTH           = Reagent{ abbrev:"water hya", name:"WATER_HYACINTH"          , trait_list:[4]*Trait{ &RESTORE_HEALTH        , &WEAPON_CRITICAL       , &SPELL_CRITICAL        , &ENTRAPMENT       } }
var WHITE_CAP                = Reagent{ abbrev:"white cap", name:"WHITE_CAP"               , trait_list:[4]*Trait{ &COWARDICE             , &INCREASE_SPELL_RESIST , &RAVAGE_MAGICKA        , &DETECTION        } }
var WORMWOOD                 = Reagent{ abbrev:"wormwood ", name:"WORMWOOD"                , trait_list:[4]*Trait{ &WEAPON_CRITICAL       , &DETECTION             , &HINDRANCE             , &UNSTOPPABLE      } }

//  clam gall missing defile, hasnegate-
var ALL_REAGENTS = [...]*Reagent{ &BEETLE_SCUTTLE          ,
                                  &BLESSED_THISTLE         ,
                                  &BLUE_ENTOLOMA           ,
                                  &BUGLOSS                 ,
                                  &BUTTERFLY_WING          ,
                                  &CLAM_GALL               ,
                                  &COLUMBINE               ,
                                  &CORN_FLOWER             ,
                                  &DRAGONTHORN             ,
                                  &EMETIC_RUSSULA          ,
                                  &FLESHFLY_LARVA          ,
                                  &IMP_STOOL               ,
                                  &LADYS_SMOCK             ,
                                  &LUMINOUS_RUSSULA        ,
                                  &MOUNTAIN_FLOWER         ,
                                  &MUDCRAB_CHITIN          ,
                                  &NAMIRAS_ROT             ,
                                  &NIGHTSHADE              ,
                                  &NIRNROOT                ,
                                  &POWDERED_MOTHER_OF_PEARL,
                                  &SCRIB_JELLY             ,
                                  &SPIDER_EGG              ,
                                  &STINKHORN               ,
                                  &TORCHBUG_THORAX         ,
                                  &VIOLET_COPRINUS         ,
                                  &WATER_HYACINTH          ,
                                  &WHITE_CAP               ,
                                  &WORMWOOD                }
var ALL_REAGENTS_PLUS_NIL = []*Reagent{}

// Connect Trait.negate_trait pointers
// Connect Trait.reagent_list pointers
func InitTraits() {
                        // Index by name for faster lookup.
    var mpt = make(map[string]*Trait)
    for _,pt := range ALL_TRAITS {
        mpt[pt.name] = pt
    }
                        // Connect traits to negated traits.
    for _,pt := range(ALL_TRAITS) {
        pt.negate_trait = mpt[pt.negate_name]
    }
                        // Connect traits to reagents that
                        // produce them.
                        //
                        // Build TraitWord bit fields.
    for _,pr := range ALL_REAGENTS {
        for _,pt := range pr.trait_list {
            pt.reagent_list = append(pt.reagent_list, pr)
            pr.possible |= pt.trait_word
            pr.negated  |= pt.negate_trait.trait_word
        }
        pr.unknown = pr.possible
    }

    ALL_REAGENTS_PLUS_NIL = make([]*Reagent, 1+len(ALL_REAGENTS))
    copy(ALL_REAGENTS_PLUS_NIL, ALL_REAGENTS[:])
    ALL_REAGENTS_PLUS_NIL = append(ALL_REAGENTS_PLUS_NIL, nil)
}

func main() {
    InitTraits()
    DumpAllReagents()
    LearnAll()
    DumpAllReagents()


    // CORN_FLOWER.Learn(&INCREASE_SPELL_POWER)

    // a := &CORN_FLOWER
    // b := &LADYS_SMOCK
    // // b := &DRAGONTHORN
    // c := &NAMIRAS_ROT

    // // c = nil

    // fmt.Println("")

    // combo := Combination{a:a,b:b,c:c}
    // combo.DumpScore()

    // fmt.Printf("\nEnd\n")
}


