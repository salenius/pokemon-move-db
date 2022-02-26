module GenII.Attribute (
  module GenII.Attribute
  ,module GenI.Attribute
                       ) where

import qualified GenI.Attribute as GenI
import GenI.Attribute hiding (Attribute(), TypeOf())

class GenI.TypeOf repr => TypeOf repr where
  steel :: repr PkmnType
  dark :: repr PkmnType

class GenI.Attribute repr => Attribute repr where
  updateAttr :: repr Move -> repr [Attr] -> repr Move
  bypassProtect :: repr [Attr]
  afterHitting :: repr Hit -> repr Effect -> repr Effect

infixr 4 `afterHitting`


data Hit = Hit Bool
