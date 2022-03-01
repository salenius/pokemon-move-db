{-# LANGUAGE LambdaCase #-}

module GenIII.Move (
  module GenIII.Move
  ,module PreviousMoves
                   ) where

import GenII.Move as PreviousMoves hiding (
  GenIMove,
  GenIIMove,
  bodySlam,
  crunch,
  earthquake,
  extremeSpeed,
  ironTail,
  machPunch,
  megahorn,
  outrage,
  pursuit,
  rockSlide,
  surf
  )
import qualified GenII.Move as Prev
import GenIII.Attribute
import GenIII.Effect
import GenIII.Damage
import GenIII.Success
import Prelude hiding (break)

class (Attribute mv, TypeOf mv, SideEffect mv, TargetingSYM mv) => GenIIIMove mv
class (GenIIIMove mv, Prev.GenIIMove mv, TargetingSYM mv) => GenIIMove mv
class (GenIIIMove mv, Prev.GenIMove mv, TargetingSYM mv) => GenIMove mv

bodySlam :: (GenIMove mv, DamageSYM mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
bodySlam = Prev.bodySlam `updateAttr` makesContact

brickBreak :: (GenIIIMove mv, DamageSYM mv, ScreenSYM mv) => mv Move
brickBreak =
  name "Brick Break"
  `having`
  pp 15 <>
  typeOf fighting <>
  accuracy 1.0 <>
  makesContact
  `effects`
  basepower 75
  `afterDamage`
  break target lightScreen' `andAlso`
  break target reflect'

bulkUp :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv) => mv Move
bulkUp = dragonDanceVariation "Bulk Up" fighting attackStat defenceStat

calmMind :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv) => mv Move
calmMind = dragonDanceVariation "Calm Mind" psychic spAttackStat spDefenceStat

cosmicPower :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv) => mv Move
cosmicPower = dragonDanceVariation "Cosmic Power" psychic spDefenceStat defenceStat

crunch :: (GenIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
crunch = Prev.crunch `updateAttr` makesContact

dragonClaw :: (GenIIIMove mv, DamageSYM mv) => mv Move
dragonClaw = strengthVariation "Dragon Claw" 15 dragon `updateAttr` makesContact

dragonDance :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv) => mv Move
dragonDance = dragonDanceVariation "Dragon Dance" dragon attackStat speedStat

earthquake ::
  (GenIMove mv, DamageSYM mv, DamageProdSYM mv,
   HitSYM mv, SemiInvulnerableSYM mv, VanishSYM mv)
  => mv Move
earthquake =
  Prev.earthquake `updateAttr` (targets allAdjacent)

eruption :: (GenIIIMove mv, DamageSYM mv) => mv Move
eruption = waterSpoutVariation "Eruption" fire user

extremeSpeed :: (GenIIMove mv, DamageSYM mv) => mv Move
extremeSpeed = Prev.extremeSpeed `updateAttr` makesContact

fakeOut :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv, SuccessSYM mv) => mv Move
fakeOut =
  name "Fake Out"
  `having`
  pp 10 <>
  typeOf normal <>
  accuracy 1.0 <>
  priority 1
  `effects`
  firstTurnOnly
  `afterSucceeding`
  basepower 40
  `afterDamage`
  affect target flinched

hail' :: (GenIIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
hail' = rainDanceVariation "Hail" ice hail

heatWave :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
heatWave =
  name "Heat Wave"
  `having`
  pp 10 <>
  typeOf fire <>
  accuracy 0.9 <>
  targets allAdjacentFoes
  `effects`
  basepower 95
  `afterDamage`
  10 % affect target (make burned)

ironDefense :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv) => mv Move 
ironDefense =
  dragonDanceVariation "Iron Defense" steel defenceStat defenceStat `updateAttr` pp 20

ironTail :: (GenIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
ironTail = Prev.ironTail `updateAttr` makesContact

machPunch :: (GenIIMove mv, DamageSYM mv) => mv Move
machPunch = Prev.machPunch `updateAttr` makesContact

magicCoat :: (GenIIIMove mv, StatusReflectionSYM mv) => mv Move
magicCoat =
  name "Magic Coat"
  `having`
  pp 15 <>
  typeOf psychic <>
  priority 4
  `effects`
  formMagicCoat

megahorn :: (GenIIMove mv, DamageSYM mv) => mv Move
megahorn = Prev.megahorn `updateAttr` makesContact

outrage :: (GenIIMove mv, DamageSYM mv, MoveLimitSYM mv, AilmentSYM mv, TurnSYM mv) => mv Move
outrage = Prev.outrage `updateAttr` makesContact

muddyWater :: (GenIIIMove mv, DamageSYM mv, ModifStatSYM mv) => mv Move
muddyWater =
  name "Muddy Water"
  `having`
  pp 10 <>
  typeOf water <>
  accuracy 0.85
  `effects`
  basepower 95
  `afterDamage`
  30 % affect target (raise accuracyStat minus1)

overheat :: (GenIIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
overheat = overheatVariation "Overheat" fire

poisonFang :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
poisonFang =
  name "Poison Fang"
  `having`
  pp 15 <>
  typeOf poison <>
  accuracy 1.0 <>
  makesContact
  `effects`
  basepower 50
  `afterDamage`
  30 % affect target (make poisoned)

poisonTail :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv, DamageProdSYM mv) => mv Move
poisonTail =
  name "Poison Tail"
  `having`
  pp 25 <>
  typeOf poison <>
  accuracy 1.0 <>
  makesContact
  `effects`
  basepower 50 *.
  increasedCriticalHitRatio 1
  `afterDamage`
  10 % affect target (make poisoned)

pursuit ::
  (GenIIMove mv, DamageSYM mv, HitSYM mv, NonStrikeOpSYM mv, SuccessSYM mv) => mv Move
pursuit = Prev.pursuit `updateAttr` makesContact

rockBlast :: (GenIIIMove mv, DamageSYM mv) => mv Move
rockBlast = boneRushVariation "Rock Blast" rock

rockSlide :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
rockSlide = Prev.rockSlide `updateAttr` (targets allAdjacentFoes)

sheerCold :: (GenIIIMove mv, DamageSYM mv, HitSYM mv) => mv Move
sheerCold =
  name "Sheer Cold"
  `having`
  pp 5 <>
  typeOf ice <>
  accuracy 0.3
  `effects`
  hitProbAsLevelDiff (\u t ac -> fromIntegral u - fromIntegral t + ac)
  `afterHitting`
  ohko
  `afterDamage`
  noEffect

signalBeam :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
signalBeam =
  name "Signal Beam"
  `having`
  pp 15 <>
  typeOf bug <>
  accuracy 1.0
  `effects`
  basepower 75
  `afterDamage`
  10 % affect target (make confused)

superpower :: (GenIIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
superpower =
  name "Superpower"
  `having`
  pp 5 <>
  typeOf fighting <>
  accuracy 1.0 <>
  makesContact
  `effects`
  basepower 120
  `afterDamage`
  affect user (raise attackStat minus1) `andAlso`
  affect user (raise defenceStat minus1)

surf :: (GenIMove mv, DamageSYM mv, DamageProdSYM mv, SemiInvulnerableSYM mv, VanishSYM mv)
  => mv Move
surf = Prev.surf
  `updateAttr` (targets allAdjacent)
  `replaceDamage` (basepower 95 *. againstVanishedTarget underwater (*2))

taunt :: (GenIIIMove mv, TauntSYM mv, TurnSYM mv, StatusReflectionSYM mv) => mv Move
taunt =
  name "Taunt"
  `having`
  pp 20 <>
  typeOf dark <>
  accuracy 1.0 <>
  magicCoatable
  `effects`
  forNext (turns 2) (affect target disableStatusMoves)

torment ::  (GenIIIMove mv, TauntSYM mv, TurnSYM mv, StatusReflectionSYM mv) => mv Move
torment =
  name "Torment"
  `having`
  pp 15 <>
  typeOf dark <>
  accuracy 1.0 <>
  magicCoatable
  `effects`
  affect target disableUsingSameMoveTwiceInRow

voltTackle :: (GenIIIMove mv, DamageSYM mv, HPSYM mv) => mv Move
voltTackle =
  name "Volt Tackle"
  `having`
  pp 15 <>
  typeOf electric <>
  accuracy 1.0 <>
  makesContact
  `effects`
  basepower 120
  `afterDamage`
  recoil 0.333

waterPulse :: (GenIIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
waterPulse =
  name "Water Pulse"
  `having`
  pp 20 <>
  typeOf water <>
  accuracy 1.0
  `effects`
  basepower 60
  `afterDamage`
  20 % affect target (make confused)

waterSpout :: (GenIIIMove mv, DamageSYM mv) => mv Move
waterSpout = waterSpoutVariation "Water Spout" water user

willOWisp :: (GenIIIMove mv, AilmentSYM mv, StatusReflectionSYM mv) => mv Move
willOWisp =
  name "Will-O-Wisp"
  `having`
  pp 15 <>
  typeOf fire <>
  accuracy 0.75 <>
  magicCoatable
  `effects`
  affect target (make burned)

yawn :: (GenIIIMove mv, AilmentSYM mv, StatusReflectionSYM mv) => mv Move
yawn =
  name "Yawn"
  `having`
  pp 10 <>
  typeOf normal <>
  magicCoatable
  `effects`
  afterTurns 1 (affect target (make asleep))
  
---


dragonDanceVariation :: (GenIIIMove mv, ModifStatSYM mv, StatSYM mv)
  => String -> mv PkmnType -> mv Stat -> mv Stat -> mv Move
dragonDanceVariation nm tpof stat1 stat2 =
   name nm
  `having`
  pp 20 <>
  typeOf tpof
  `effects`
  affect user (raise stat1 plus1) `andAlso`
  affect user (raise stat2 plus1)

waterSpoutVariation nm t cp =
  name nm
  `having`
  pp 5 <>
  typeOf t <>
  accuracy 1.0
  `effects`
  basepowerFromHp cp (\m c -> floor $ 150 * (fromIntegral c / fromIntegral m))
  `afterDamage`
  noEffect

overheatVariation nm t =
  name nm
  `having`
  pp 5 <>
  typeOf t <>
  accuracy 0.9
  `effects`
  basepower 140
  `afterDamage`
  affect user (raise spAttackStat ((-) 2))
