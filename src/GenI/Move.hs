{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE LambdaCase #-}


module GenI.Move where

import GenI.Attribute
import GenI.Effect
import GenI.Damage
import GenI.Success

hundred :: Double
hundred = 100

(%) x = withProbability (x / hundred)

class (Attribute mv, TypeOf mv, SideEffect mv) => GenIMove mv


auroraBeam :: (GenIMove mv, DamageSYM mv, StatSYM mv, ModifStatSYM mv) => mv Move
auroraBeam =
  name "Aurora Beam"
  `having`
  pp 20 <>
  typeOf ice <>
  accuracy 1.0
  `effects`
  basepower 65
  `afterDamage`
  33.2 % affect target (raise attackStat minus1)

blizzard :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
blizzard =
  name "Blizzard"
  `having`
  pp 5 <>
  typeOf ice <>
  accuracy 0.9
  `effects`
  basepower 120
  `afterDamage`
  10 % affect target (make frozen)

bodySlam :: (GenIMove mv, DamageSYM mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
bodySlam =
  name "Body Slam"
  `having`
  pp 15 <>
  typeOf normal <>
  accuracy 1.0
  `effects`
  basepower 85
  `afterDamage`
  30 % affect target (unlessTargetTypeIs normal (make paralyzed))

crabhammer :: (GenIMove mv, DamageSYM mv, DamageProdSYM mv) => mv Move
crabhammer =
  name "Crabhammer"
  `having`
  pp 10 <>
  typeOf water <>
  accuracy 0.85
  `effects`
  basepower 90 *.
  increasedCriticalHitRatio 1
  `afterDamage`
  noEffect

disable :: (GenIMove mv, DisableSYM mv, TurnSYM mv) => mv Move
disable =
  name "Disable"
  `having`
  pp 20 <>
  typeOf normal <>
  accuracy 0.55
  `effects`
  forNext (randomTurnsBetween 0 7) (affect target disableRandomMove)

drillPeck :: (GenIMove mv, DamageSYM mv) => mv Move
drillPeck = strengthVariation "Drill Peck" 20 flying

earthquake :: (GenIMove mv, DamageSYM mv) => mv Move
earthquake =
  name "Earthquake"
  `having`
  pp 10 <>
  typeOf ground <>
  accuracy 1.0
  `effects`
  damageWithBasepower 100

fireBlast :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
fireBlast =
  name "Fire Blast"
  `having`
  pp 5 <>
  typeOf fire <>
  accuracy 0.85
  `effects`
  basepower 120
  `afterDamage`
  30 % affect target (make burned)

firePunch :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
firePunch =
  name "Fire Punch"
  `having`
  pp 15 <>
  typeOf fire <>
  accuracy 1.0
  `effects`
  basepower 75
  `afterDamage`
  10 % affect target (make burned)

flamethrower :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
flamethrower =
  name "Flamethrower"
  `having`
  pp 15 <>
  typeOf fire <>
  accuracy 1.0
  `effects`
  basepower 95
  `afterDamage`
  10 % affect target (make burned)

hydroPump :: (GenIMove mv, DamageSYM mv) => mv Move
hydroPump =
  name "Hydro Pump"
  `having`
  pp 5 <>
  typeOf water <>
  accuracy 0.8
  `effects`
  damageWithBasepower 120

hyperFang :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
hyperFang =
  name "Hyper Fang"
  `having`
  pp 15 <>
  typeOf normal <>
  accuracy 0.9
  `effects`
  basepower 80
  `afterDamage`
  10 % affect target flinched

iceBeam :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
iceBeam =
  name "Ice Beam"
  `having`
  pp 10 <>
  typeOf ice <>
  accuracy 1.0
  `effects`
  basepower 95
  `afterDamage`
  10 % affect target (make frozen)

icePunch :: (GenIMove mv, DamageSYM mv, AilmentSYM mv) => mv Move
icePunch =
  name "Ice Punch"
  `having`
  pp 15 <>
  typeOf ice <>
  accuracy 1.0
  `effects`
  basepower 75
  `afterDamage`
  10 % affect target (make frozen)

leechSeed :: (GenIMove mv, AilmentSYM mv, TypeCancelSYM mv, HPSYM mv) => mv Move
leechSeed =
  name "Leech Seed"
  `having`
  pp 10 <>
  typeOf grass
  `effects`
  affect target (unlessTargetTypeIs grass (endOfTurnHp (partOfMaxHp 16 (-))))
  `andAlso`
  affect target (unlessTargetTypeIs grass (make leechSeeded))

lightScreen :: (GenIMove mv, DamageSYM mv, ScreenSYM mv, TurnSYM mv) => mv Move
lightScreen =
  name "Light Screen"
  `having`
  pp 20 <>
  typeOf psychic
  `effects`
  forNext (turns 5) (setUp user lightScreen')

petalDance :: (GenIMove mv, DamageSYM mv, MoveLimitSYM mv, AilmentSYM mv, TurnSYM mv)
  => mv Move
petalDance =
  name "Petal Dance"
  `having`
  pp 20 <>
  typeOf grass <>
  accuracy 1.0
  `effects`
  basepower 70
  `afterDamage`
  loopBetween 3 4

psychic' :: (GenIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
psychic' =
  name "Psychic"
  `having`
  pp 10 <>
  typeOf psychic <>
  accuracy 1.0
  `effects`
  basepower 95
  `afterDamage`
  33.2 % affect target (raise specialStat minus1)

quickAttack :: (GenIMove mv, DamageSYM mv) => mv Move
quickAttack = quickAttackVariation "Quick Attack" normal

recover :: (GenIMove mv, HPSYM mv) => mv Move
recover =
  name "Recover"
  `having`
  pp 20 <>
  typeOf normal
  `effects`
  affect user (hp (partOfMaxHp 2 (+)))

reflect :: (GenIMove mv, DamageSYM mv, ScreenSYM mv, TurnSYM mv) => mv Move
reflect =
  name "Reflect"
  `having`
  pp 20 <>
  typeOf psychic
  `effects`
  forNext (turns 5) (setUp user reflect')

rest :: (GenIMove mv, AilmentSYM mv, HPSYM mv) => mv Move
rest =
  name "Rest"
  `having`
  pp 10 <>
  typeOf psychic
  `effects`
  affect user (hp toMax) `andAlso`
  affect user (cure burned) `andAlso`
  affect user (cure paralyzed) `andAlso`
  affect user (cure frozen) `andAlso`
  affect user (cure poisoned) `andAlso`
  affect user (make asleep)

rockSlide :: (GenIMove mv, DamageSYM mv) => mv Move
rockSlide =
  name "Rock Slide"
  `having`
  pp 10 <>
  typeOf rock <>
  accuracy 0.9
  `effects`
  damageWithBasepower 75

selfDestruct :: (GenIMove mv, DamageSYM mv, HPSYM mv) => mv Move
selfDestruct =
  name "Self-Destruct"
  `having`
  pp 5 <>
  typeOf normal <>
  accuracy 1.0
  `effects`
  basepower 130
  `afterDamage`
  faintUser

sleepPowder :: (GenIMove mv, AilmentSYM mv) => mv Move
sleepPowder =
  name "Sleep Powder"
  `having`
  pp 15 <>
  typeOf grass <>
  accuracy 0.75
  `effects`
  affect target (make asleep) 

solarBeam :: (GenIMove mv, DamageSYM mv, SuccessSYM mv, TurnSYM mv) => mv Move
solarBeam =
  name "Solar Beam"
  `having`
  pp 10 <>
  typeOf grass <>
  accuracy 1.0
  `effects`
  charge (turns 1)
  `afterSucceeding`
  damageWithBasepower 120

strength :: (GenIMove mv, DamageSYM mv) => mv Move
strength = strengthVariation "Strength" 15 normal

surf :: (GenIMove mv, DamageSYM mv) => mv Move
surf =
  name "Surf"
  `having`
  pp 15 <>
  typeOf water <>
  accuracy 1.0
  `effects`
  damageWithBasepower 95

swordsDance :: (GenIMove mv, StatSYM mv, ModifStatSYM mv) => mv Move
swordsDance =
  name "Swords Dance"
  `having`
  pp 20 <>
  typeOf normal
  `effects`
  affect user (raise attackStat (+2))

thrash :: (GenIMove mv, DamageSYM mv, MoveLimitSYM mv, AilmentSYM mv, TurnSYM mv)
  => mv Move
thrash =
  name "Thrash"
  `having`
  pp 20 <>
  typeOf normal <>
  accuracy 1.0
  `effects`
  basepower 90
  `afterDamage`
  loopBetween 3 4


thunderbolt :: (GenIMove mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
thunderbolt =
  name "Thunderbolt"
  `having`
  pp 15 <>
  typeOf electric <>
  accuracy 1.0
  `effects`
  10 % affect target (unlessTargetTypeIs electric (make paralyzed))

thunder :: (GenIMove mv, AilmentSYM mv, DamageSYM mv, TypeCancelSYM mv) => mv Move
thunder =
  name "Thunder"
  `having`
  pp 10 <>
  typeOf electric <>
  accuracy 0.7
  `effects`
   10 % affect target (unlessTargetTypeIs electric (make paralyzed))

toxic :: (GenIMove mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
toxic =
  name "Toxic"
  `having`
  pp 10 <>
  typeOf poison <>
  accuracy 0.85
  `effects`
  affect target (unlessTargetTypeIs poison (make badlyPoisoned))

waterfall :: (GenIMove mv, DamageSYM mv) => mv Move
waterfall =
  name "Waterfall"
  `having`
  pp 15 <>
  typeOf water <>
  accuracy 1.0
  `effects`
  damageWithBasepower 80

----

faintUser :: (SideEffect mv, HPSYM mv) => mv Effect
faintUser =
  affect user (hp (-))

faintTarget :: (SideEffect mv, HPSYM mv) => mv Effect
faintTarget =
  affect target (hp (-))

partOfMaxHp :: Int -> (Int -> Int -> Int) -> (Int -> Int -> Int)
partOfMaxHp part op max' cur' = cur' `op` (floor y)
  where
    y = z * fromIntegral max'
    z :: Double
    z = fromIntegral 1 / fromIntegral part

toMax :: Int -> Int -> Int
toMax x y = y

loopBetween :: (SideEffect mv, MoveLimitSYM mv, TurnSYM mv, AilmentSYM mv)
  => Int -> Int -> mv Effect
loopBetween x y =
  beginLoop (loopMove (randomTurnsBetween x y) `afterLoopOver` affect target (make confused))

damageWithBasepower :: (DamageSYM mv, SideEffect mv) => Int -> mv Effect
damageWithBasepower bp = basepower bp `afterDamage` noEffect

recoil :: (HPSYM mv) => Double -> mv Effect
recoil pct = drain (\d h -> floor $ fromIntegral h - fromIntegral d * pct)

quickAttackVariation nm t =
  name nm
  `having`
  pp 30 <>
  typeOf t <>
  accuracy 1.0 <>
  priority 1
  `effects`
  damageWithBasepower 40

strengthVariation nm p t =
  name nm
  `having`
  pp p <>
  typeOf t <>
  accuracy 1.0
  `effects`
  damageWithBasepower 80

