module GenIV.Damage (
  module GenIV.Damage
  ,module GenIII.Damage
                    ) where

import GenIII.Damage hiding (DamageSYM(), DamageEventSYM())
import qualified GenIII.Damage as Prev

class Prev.DamageSYM repr => DamageSYM repr

class Prev.DamageEventSYM repr => DamageEventSYM repr where
  userMovesAfterTarget :: repr DamageEvent
  targetSwitchesOut :: repr DamageEvent
  opponentUsesItem :: repr DamageEvent
