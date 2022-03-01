{-# LANGUAGE LambdaCase #-}

module GenII.Move (
  module GenII.Move
  ,module MovesOfGenI
                  ) where

import GenII.Attribute
import GenII.Effect
import GenII.Success
import GenII.Damage
import qualified GenI.Move as Prev
import GenI.Move as MovesOfGenI hiding (
  GenIMove,
  blizzard,
  bodySlam,
  disable,
  earthquake,
  fireBlast,
  psychic',
  rockSlide,
  solarBeam,
  thunderbolt,
  thunder,
  toxic
  )

class (Attribute mv, TypeOf mv, SideEffect mv) => GenIIMove mv

class (Prev.GenIMove mv, GenIIMove mv) => GenIMove mv

aeroblast :: (GenIIMove mv, DamageSYM mv, DamageProdSYM mv) => mv Move
aeroblast =
  name "Aeroblast"
  `having`
  pp 5 <>
  typeOf flying <>
  accuracy 0.95
  `effects`
  basepower 100 *.
  increasedCriticalHitRatio 1
  `afterDamage`
  noEffect

bellyDrum :: (GenIIMove mv, ModifStatSYM mv, StatSYM mv, SuccessSYM mv, HPSYM mv) => mv Move
bellyDrum =
  name "Belly Drum"
  `having`
  pp 10 <>
  typeOf normal
  `effects`
  requireUserHp (currentHpPctAtLeast 0.5) 
  `afterSucceeding`
  affect user (hp (cutHpPct 0.5)) `andAlso`
  affect user (raise attackStat (+12))

blizzard :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
blizzard = Prev.blizzard `updateAttr` accuracy 0.7

bodySlam :: (GenIMove mv, DamageSYM mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
bodySlam = Prev.bodySlam `replaceEffect` (30 % affect target (make paralyzed))

boneRush :: (GenIIMove mv, DamageSYM mv) => mv Move
boneRush = boneRushVariation "Bone Rush" ground

crunch :: (GenIIMove mv, DamageSYM mv, StatSYM mv, ModifStatSYM mv) => mv Move
crunch = crunchVariation "Crunch" dark spDefenceStat

destinyBond :: (GenIIMove mv, FaintingSYM mv, HPSYM mv) => mv Move
destinyBond =
  name "Destiny Bond"
  `having`
  pp 5 <>
  typeOf ghost
  `effects`
  ifFaints user faintTarget

disable :: (GenIMove mv, DisableSYM mv, TurnSYM mv) => mv Move
disable = Prev.disable
  `replaceEffect` (forNext (randomTurnsBetween 2 8) (affect target disableLastMove))

dragonBreath :: (GenIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
dragonBreath =
  name "Dragon Breath"
  `having`
  pp 20 <>
  typeOf dragon <>
  accuracy 1.0
  `effects`
  basepower 60
  `afterDamage`
  30 % affect target (make paralyzed)

earthquake ::
  (GenIMove mv, DamageSYM mv, DamageProdSYM mv, SemiInvulnerableSYM mv, VanishSYM mv)
  => mv Move
earthquake =
  Prev.earthquake `replaceDamage` (basepower 100 *. againstVanishedTarget underground (*2))

extremeSpeed :: (GenIIMove mv, DamageSYM mv) => mv Move
extremeSpeed =
  name "ExtremeSpeed"
  `having`
  pp 5 <>
  typeOf normal <>
  accuracy 1.0 <>
  priority 1
  `effects`
  basepower 80
  `afterDamage`
  noEffect

fireBlast :: (GenIMove mv, DamageSYM mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
fireBlast = Prev.fireBlast `replaceEffect` (10 % affect target (make burned))

foresight :: (GenIIMove mv, TypeEffectSYM mv, StatChangeRemapSYM mv) => mv Move
foresight =
  name "Foresight"
  `having`
  pp 40 <>
  typeOf normal <>
  accuracy 1.0
  `effects`
  mapAccuracyAndEvasion (\ac ev -> if ac < ev then (0,0) else (ac, ev)) `andAlso`
  affect target (removeTypeImmunities ghost)

gigaDrain :: (GenIIMove mv, DamageSYM mv, HPSYM mv) => mv Move
gigaDrain =
  name "Giga Drain"
  `having`
  pp 10 <>
  typeOf grass <>
  accuracy 1.0
  `effects`
  basepower 75
  `afterDamage`
  drain (\dam curhp -> floor $ 0.5 * fromIntegral dam + fromIntegral curhp)

icyWind :: (GenIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
icyWind =
  name "Icy Wind"
  `having`
  pp 20 <>
  typeOf ice <>
  accuracy 0.95
  `effects`
  basepower 55
  `afterDamage`
  99.6 % affect target (raise speedStat minus1)

ironTail :: (GenIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
ironTail =
  name "Iron Tail"
  `having`
  pp 15 <>
  typeOf steel <>
  accuracy 0.75
  `effects`
  basepower 100
  `afterDamage`
  30 % affect target (raise defenceStat minus1)

machPunch :: (GenIIMove mv, DamageSYM mv) => mv Move
machPunch = quickAttackVariation "Mach Punch" fighting

megahorn :: (GenIIMove mv, DamageSYM mv) => mv Move
megahorn =
  name "Megahorn"
  `having`
  pp 10 <>
  typeOf bug <>
  accuracy 0.85
  `effects`
  basepower 120
  `afterDamage`
  noEffect

outrage :: (GenIIMove mv, DamageSYM mv, MoveLimitSYM mv, AilmentSYM mv, TurnSYM mv)
  => mv Move
outrage =
  name "Outrage"
  `having`
  pp 15 <>
  typeOf dragon <>
  accuracy 1.0
  `effects`
  basepower 90
  `afterDamage`
  loopBetween 2 3

painSplit :: (GenIIMove mv, HPSYM mv) => mv Move
painSplit =
  name "Pain Split"
  `having`
  pp 20 <>
  typeOf normal <>
  accuracy 1.0
  `effects`
  adjustUserAndTargetHP splitEqually
  where
    splitEqually userhp targethp = (floor $ u, floor $ u)
      where
        u = fromIntegral (userhp + targethp) / 2

protect :: (GenIIMove mv, ProtectionSYM mv, SuccessSYM mv) => mv Move
protect =
  name "Protect"
  `having`
  pp 10 <>
  typeOf normal <>
  priority 4
  `effects`
  failureIfUsedInRow protectFailureRate
  `afterSucceeding`
  protectFromOpponentsMoves

psychic' :: (GenIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
psychic' = Prev.psychic' `replaceEffect` (10 % affect target (raise spDefenceStat minus1))

pursuit :: (GenIIMove mv, DamageSYM mv, HitSYM mv, NonStrikeOpSYM mv, SuccessSYM mv)
  => mv Move
pursuit =
  name "Pursuit"
  `having`
  pp 20 <>
  typeOf dark <>
  accuracy 1.0
  `effects`
  ifTarget switchingOut
   (execImmediatelyBeforeTarget
    `afterSucceeding` bypassAccuracyCheck
    `afterHitting` basepower 80
    `afterDamage` noEffect)
   (basepower 40 `afterDamage` noEffect)

rainDance :: (GenIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
rainDance = rainDanceVariation "Rain Dance" water rainy

rockSlide :: (GenIMove mv, AilmentSYM mv, DamageSYM mv) => mv Move
rockSlide = Prev.rockSlide `replaceEffect` (30 % affect target flinched)

sacredFire :: (GenIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
sacredFire =
  name "Sacred Fire"
  `having`
  pp 5 <>
  typeOf fire
  `effects`
  basepower 100
  `afterDamage`
  thaw user `andAlso`
  (50 % affect target (make burned))

sandstorm' :: (GenIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
sandstorm' = rainDanceVariation "Sandstorm" rock sandstorm

shadowBall :: (GenIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
shadowBall = crunchVariation "Shadow Ball" ghost spDefenceStat

sleepTalk :: (GenIIMove mv, SuccessSYM mv, MoveCallSYM mv, AilmentSYM mv) => mv Move
sleepTalk =
  name "Sleep Talk"
  `having`
  pp 10 <>
  typeOf normal
  `effects`
  succeedOnlyIf user asleep
  `afterSucceeding`
  callRandomUserMove (nonCallableMoves sleepTalkCantCall)

sludgeBomb :: (GenIIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
sludgeBomb =
  name "Sludge Bomb"
  `having`
  pp 10 <>
  typeOf poison <>
  accuracy 1.0
  `effects`
  basepower 90
  `afterDamage`
  30 % affect target (make poisoned)

solarBeam ::
  (GenIMove mv, DamageSYM mv, DamageProdSYM mv, WeatherSYM mv, SuccessSYM mv, TurnSYM mv)
  => mv Move
solarBeam =
  Prev.solarBeam  `replaceDamage` (basepower 120 *. weatherModifsDamage rainy (* 0.5))

sunnyDay :: (GenIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
sunnyDay = rainDanceVariation "Sunny Day" fire sunny

swagger :: (GenIIMove mv, StatSYM mv, ModifStatSYM mv, AilmentSYM mv) => mv Move
swagger =
  name "Swagger"
  `having`
  pp 15 <>
  typeOf normal <>
  accuracy 0.9
  `effects`
  affect target (raise attackStat (+2)) `andAlso`
  affect target (make confused)

thunderbolt :: (GenIMove mv, DamageSYM mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
thunderbolt = Prev.thunderbolt `replaceEffect` (10 % affect target (make paralyzed))

thunder ::
  (GenIMove mv, DamageSYM mv, AilmentSYM mv, TypeCancelSYM mv, WeatherSYM mv, HitSYM mv)
  => mv Move
thunder = Prev.thunder `replaceEffect` (30 % affect target (make paralyzed)) `replaceHit` (bypassAccuracyCheckDuring rainy)

toxic :: (GenIMove mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
toxic =
  Prev.toxic `replaceEffect`
  (affect target . unlessTargetTypeIs steel . unlessTargetTypeIs poison $ make badlyPoisoned)
---

protectFailureRate :: SuccessSYM mv => mv FailureAlgo
protectFailureRate = probabilityOfFailing undefined

sleepTalkCantCall :: [MoveId]
sleepTalkCantCall = undefined

thaw :: (AilmentSYM mv, SideEffect mv) => Counterparty -> mv Effect
thaw cp = affect cp (cure burned)

currentHpPctAtLeast :: Double -> (Int -> Int -> Bool)
currentHpPctAtLeast d = \maxh curh -> fromIntegral curh >= d * fromIntegral maxh

cutHpPct :: Double -> (Int -> Int -> Int)
cutHpPct d = \x y -> floor $ fromIntegral y - d * fromIntegral x

crunchVariation nm t stat =
  name nm
  `having`
  pp 15 <>
  typeOf t <>
  accuracy 1.0
  `effects`
  basepower 80
  `afterDamage`
  20 % affect target (raise stat minus1)

rainDanceVariation nm t w =
  name nm
  `having`
  pp 5 <>
  typeOf t
  `effects`
  forNext (turns 5) (start w)

boneRushVariation nm t =
  name nm
  `having`
  pp 10 <>
  typeOf t <>
  accuracy 0.80
  `effects`
  multiStrike probOfHitting (basepower 25)
  `afterDamage`
  noEffect

probOfHitting = \case
  2 -> 0.375
  3 -> 0.375
  4 -> 0.125
  5 -> 0.125
  _ -> 0
