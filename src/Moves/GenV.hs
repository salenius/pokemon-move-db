module Moves.GenV (
  module ML
  ,module Moves.GenV
  ) where

import GenV.Move as ML hiding (
  psychic',
  sandstorm',
  hail',
  aquaJetVariation,
  darkPulseVariation,
  doubleDamageIf,
  earthPowerVariation,
  flareBlitzVariation,
  iceFangVariation,
  leafStormVariation,
  poisonJabVariation,
  seedBombVariation
  )
import qualified GenV.Move as M (psychic',sandstorm',hail')
import GenV.Damage (DamageSYM())
import GenV.Attribute (Move,TurnSYM(..))
import GenV.Effect

psychic :: (GenIMove mv, DamageSYM mv, ModifStatSYM mv, StatSYM mv) => mv Move
psychic = M.psychic'

sandstorm :: (GenIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
sandstorm = M.sandstorm'

hail :: (GenIIIMove mv, WeatherSYM mv, TurnSYM mv) => mv Move
hail = M.hail'
