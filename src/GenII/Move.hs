module GenII.Move where

import GenI.Move
import GenII.Attribute
import GenII.Effect
import GenII.Success
import GenII.Damage

class (Attribute mv, TypeOf mv, SideEffect mv) => GenIIMove mv

crunch :: (GenIIMove mv, DamageSYM mv, StatSYM mv, ModifStatSYM mv) => mv Move
crunch =
  name "Crunch"
  `having`
  pp 15 <>
  typeOf dark <>
  accuracy 1.0
  `effects`
  basepower 80
  `afterDamage`
  20 % affect target (raise spDefenceStat minus1)

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
machPunch =
  name "Mach Punch"
  `having`
  pp 30 <>
  typeOf fighting <>
  accuracy 1.0 <>
  priority 1
  `effects`
  basepower 40
  `afterDamage`
  noEffect

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
  pp 10 <>
  typeOf dragon <>
  accuracy 1.0
  `effects`
  basepower 90
  `afterDamage`
  beginLoop (loopMove (randomTurnsBetween 2 5) `afterLoopOver` affect target (make confused))

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
rainDance =
  name "Rain Dance"
  `having`
  pp 5 <>
  typeOf water
  `effects`
  forNext (turns 5) (start rainy)

sandstorm' :: (GenIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
sandstorm' =
  name "Sandstorm"
  `having`
  pp 10 <>
  typeOf rock
  `effects`
  forNext (turns 5) (start sandstorm)

shadowBall :: (GenIIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
shadowBall =
  name "Shadow Ball"
  `having`
  pp 15 <>
  typeOf ghost <>
  accuracy 1.0
  `effects`
  basepower 80
  `afterDamage`
  20 % affect target (raise spDefenceStat minus1)

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

sunnyDay :: (GenIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
sunnyDay =
  name "Sunny Day"
  `having`
  pp 10 <>
  typeOf fire
  `effects`
  forNext (turns 5) (start sunny)

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

---

protectFailureRate :: SuccessSYM mv => mv FailureAlgo
protectFailureRate = probabilityOfFailing undefined

sleepTalkCantCall :: [MoveId]
sleepTalkCantCall = undefined
