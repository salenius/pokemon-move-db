module GenIII.Damage (
  module GenIII.Damage
  ,module GenII.Damage
                     ) where

import qualified GenII.Damage as GenII
import GenII.Damage hiding (DamageSYM())
import GenIII.Attribute

class GenII.DamageSYM repr => DamageSYM repr where
  basepowerFromHp :: Counterparty -> (MaxHP -> CurrentHP -> Int) -> repr Damage
  modifyDamageIf :: (Double -> Double) -> repr DamageEvent -> repr DamageProd

class DamageEventSYM repr where
  targetHasAlreadyDamagedUserThisTurn :: repr DamageEvent

type MaxHP = Int
type CurrentHP = Int
newtype DamageEvent = DamageEvent String
