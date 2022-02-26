module GenII.Damage (
  module GenII.Damage
  ,module GenI.Damage
                    ) where

import qualified GenI.Damage as GenI
import GenI.Damage hiding (DamageSYM())
import GenII.Attribute

class GenI.DamageSYM repr => DamageSYM repr where
  replaceDamage :: repr Move -> repr Damage -> repr Move
