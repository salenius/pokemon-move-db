module GenV.Damage (
  module GenV.Damage
  ,module GenIV.Damage
                   ) where

import GenIV.Damage hiding (DamageEventSYM())
import qualified GenIV.Damage as Prev

class Prev.DamageEventSYM repr => DamageEventSYM repr where
  userHasNoHeldItem :: repr DamageEvent
