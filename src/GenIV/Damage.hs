module GenIV.Damage (
  module GenIV.Damage
  ,module GenIII.Damage
                    ) where

import GenIII.Damage hiding (DamageSYM())
import qualified GenIII.Damage as Prev

class Prev.DamageSYM repr => DamageSYM repr
