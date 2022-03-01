module GenIII.Attribute (
  module GenIII.Attribute
  ,module GenII.Attribute
  
                        ) where

import GenII.Attribute hiding (Attribute(), SemiInvulnerableSYM())
import qualified GenII.Attribute as Prev

class Prev.Attribute repr => Attribute repr where
  targets :: repr Targeting -> repr [Attr]
  makesContact :: repr [Attr]

class Prev.SemiInvulnerableSYM repr => SemiInvulnerableSYM repr where
  underwater :: repr SemiInvulnerable

class TargetingSYM repr where
  -- |The default implementation for targeting. Single target.
  anyAdjacent :: repr Targeting
  -- |Hits all the neighboring Pokemon
  allAdjacent :: repr Targeting
  -- |Hits all the close by foes only
  allAdjacentFoes :: repr Targeting
  userAndAllies :: repr Targeting
  userOrAdjacentAlly :: repr Targeting
  
data Targeting = Targeting [Counterparty]
