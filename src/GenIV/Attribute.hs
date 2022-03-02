module GenIV.Attribute (
  module GenIV.Attribute
  ,module GenIII.Attribute
                       ) where

import GenIII.Attribute hiding (Attribute())
import qualified GenIII.Attribute as Prev

class Prev.Attribute repr => Attribute repr where
  category :: repr Category -> repr [Attr]

class CategorySYM repr where
  physical :: repr Category
  special :: repr Category
  status :: repr Category

data Category = Category String
