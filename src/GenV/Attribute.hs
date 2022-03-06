module GenV.Attribute (
  module GenV.Attribute
  ,module GenIV.Attribute
                      ) where

import GenIV.Attribute hiding (TargetingSYM())
import qualified GenIV.Attribute as Prev

class Prev.TargetingSYM mv => TargetingSYM mv where
  allPokemon :: mv Targeting
  anyPokemon :: mv Targeting
  allFoes :: mv Targeting



