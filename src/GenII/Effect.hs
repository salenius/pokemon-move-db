module GenII.Effect (
  module GenII.Effect
  ,module GenI.Effect
                    ) where

import qualified GenI.Effect as GenI
import GenI.Effect hiding (StatSYM(), AilmentSYM(), SideEffect(), MoveCallSYM(), HPSYM())
import GenII.Attribute

class GenI.StatSYM repr => StatSYM repr where
  spAttackStat :: repr Stat
  spDefenceStat :: repr Stat

class GenI.SideEffect repr => SideEffect repr where
  replaceEffect :: repr Move -> repr Effect -> repr Move
  start :: repr Weather -> repr Effect

class GenI.AilmentSYM repr => AilmentSYM repr where
  infatuated :: repr Ailment

class GenI.MoveCallSYM repr => MoveCallSYM repr where
  callRandomUserMove :: repr MovePoolAvailable -> repr Effect

class ProtectionSYM repr where
  protectFromOpponentsMoves :: repr Effect

class GenI.HPSYM repr => HPSYM repr where
  adjustUserAndTargetHP :: (Int -> Int -> (Int,Int)) -> repr Effect

class TypeEffectSYM repr where
  removeTypeImmunities :: repr PkmnType -> repr PokemonEff

class StatChangeRemapSYM repr where
  mapAccuracyAndEvasion :: (Int -> Int -> (Int,Int)) -> repr Effect

class FaintingSYM repr where
  ifFaints :: Counterparty -> repr Effect -> repr Effect
