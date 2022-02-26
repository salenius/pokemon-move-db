{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE KindSignatures #-}


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

crabhammer :: (GenIMove mv, DamageSYM mv) => mv Move
crabhammer =
  name "Crabhammer"
  `having`
  pp 10 <>
  typeOf water <>
  accuracy 0.85
  `effects`
  basepower 90 <>
  increasedCriticalHitRatio 1
  `afterDamage`
  noEffect

earthquake :: (GenIMove mv, DamageSYM mv) => mv Move
earthquake =
  name "Earthquake"
  `having`
  pp 10 <>
  typeOf ground <>
  accuracy 1.0
  `effects`
  basepower 100
  `afterDamage`
  noEffect

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
  basepower 75
  `afterDamage`
  noEffect

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
  basepower 120
  `afterDamage`
  noEffect

surf :: (GenIMove mv, DamageSYM mv) => mv Move
surf =
  name "Surf"
  `having`
  pp 15 <>
  typeOf water <>
  accuracy 1.0
  `effects`
  basepower 95
  `afterDamage`
  noEffect

swordsDance :: (GenIMove mv, StatSYM mv, ModifStatSYM mv) => mv Move
swordsDance =
  name "Swords Dance"
  `having`
  pp 20 <>
  typeOf normal
  `effects`
  affect user (raise attackStat (+2))

thunderbolt :: (GenIMove mv, AilmentSYM mv, TypeCancelSYM mv) => mv Move
thunderbolt =
  name "Thunderbolt"
  `having`
  pp 15 <>
  typeOf electric <>
  accuracy 1.0
  `effects`
  10 % affect target (unlessTargetTypeIs electric (make paralyzed))

waterfall :: (GenIMove mv, DamageSYM mv) => mv Move
waterfall =
  name "Waterfall"
  `having`
  pp 15 <>
  typeOf water <>
  accuracy 1.0
  `effects`
  basepower 80
  `afterDamage`
  noEffect

----

faintUser :: (SideEffect mv, HPSYM mv) => mv Effect
faintUser =
  affect user (hp (-))

partOfMaxHp :: Int -> (Int -> Int -> Int) -> (Int -> Int -> Int)
partOfMaxHp part op max' cur' = cur' `op` (floor y)
  where
    y = z * fromIntegral max'
    z :: Double
    z = fromIntegral 1 / fromIntegral part

toMax :: Int -> Int -> Int
toMax x y = y
