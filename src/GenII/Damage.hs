module GenII.Damage (
  module GenII.Damage
  ,module GenI.Damage
                    ) where

import qualified GenI.Damage as GenI
import GenI.Damage hiding (DamageSYM(), DamageProdSYM())
import GenII.Attribute

class GenI.DamageSYM repr => DamageSYM repr where
  replaceDamage :: repr Move -> repr Damage -> repr Move

class GenI.DamageProdSYM repr => DamageProdSYM repr where
  weatherModifsDamage :: repr Weather -> (Double -> Double) -> repr DamageProd
  againstVanishedTarget :: repr SemiInvulnerable -> (Double -> Double) -> repr DamageProd
