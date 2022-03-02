module GenIV.Effect (
  module GenIV.Effect
  ,module GenIII.Effect
                    ) where

import GenIII.Effect hiding (SideEffect())
import qualified GenIII.Effect as Prev
import GenIV.Attribute
import GenIII.Damage (Damage)

class Prev.SideEffect repr => SideEffect repr where
  beforeDamage :: repr Damage -> repr Effect -> repr Damage

infixr 4 `beforeDamage`
