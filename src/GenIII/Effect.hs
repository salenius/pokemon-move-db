module GenIII.Effect (
  module GenIII.Effect
  ,module GenII.Effect
                     ) where

import qualified GenII.Effect as GenII
import GenII.Effect hiding (SideEffect())
import GenIII.Attribute

class GenII.SideEffect repr => SideEffect repr

class DisableSYM repr => TauntSYM repr where
  disableStatusMoves :: repr PokemonEff
  disableUsingSameMoveTwiceInRow :: repr PokemonEff

class StatusReflectionSYM repr where
  formMagicCoat :: repr Effect
  magicCoatable :: repr [Attr]

class ItemOpSYM repr where
  dropItem :: repr PokemonEff
  swapItems :: repr CrossPokemonEff
  takeItem :: repr CrossPokemonEff
  
