{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE GADTs #-}


module GenI.Effect where

import GenI.Attribute
import GenI.Success

type StatSetter = Int -> Int

type StatEff eff = StatSetter -> eff PokemonEff

type CurrentHP = Int

type MaxHP = Int

data Stat = Stat Int

plus1 :: StatSetter
plus1 = (+1)

minus1 :: StatSetter
minus1 = flip (-) 1

class StatSYM repr where
  attackStat :: repr Stat
  defenceStat :: repr Stat
  specialStat :: repr Stat
  speedStat :: repr Stat

class ModifStatSYM repr where
  accuracyStat :: repr Stat
  evasionStat :: repr Stat
  raise :: repr Stat -> (Int -> Int) -> repr PokemonEff

class AilmentSYM repr where
  asleep :: repr Ailment
  burned :: repr Ailment
  frozen :: repr Ailment
  paralyzed :: repr Ailment
  poisoned :: repr Ailment
  cured :: repr Ailment
  flinched :: repr PokemonEff
  confused :: repr Ailment
  leechSeeded :: repr Ailment
  cure :: repr Ailment -> repr PokemonEff
  make :: repr Ailment -> repr PokemonEff

class ScreenSYM repr where
  lightScreen' :: repr CrossPokemonEff
  reflect' :: repr CrossPokemonEff

class WeatherSYM repr where
  fine :: repr Weather
  rainy :: repr Weather
  sunny :: repr Weather
  hail :: repr Weather
  sandstorm :: repr Weather

class HPSYM repr where
  hp :: (MaxHP -> CurrentHP -> Int) -> repr PokemonEff
  endOfTurnHp :: (MaxHP -> CurrentHP -> Int) -> repr PokemonEff

class TypeCancelSYM repr where
  unlessTargetTypeIs :: repr PkmnType -> repr PokemonEff -> repr PokemonEff

class SideEffect repr where
  noEffect :: repr Effect
  forNext :: repr Turn -> repr Effect -> repr Effect
  withProbability :: Double -> repr Effect -> repr Effect
  andAlso :: repr Effect -> repr Effect -> repr Effect
  orMaybe :: repr Effect -> repr Effect -> repr Effect
  ifMisses :: repr Effect -> repr Effect -> repr Effect
  affect :: Counterparty -> repr PokemonEff -> repr Effect
  start :: repr Weather -> repr Effect
  setUp :: Counterparty -> repr CrossPokemonEff -> repr Effect
  break :: Counterparty -> repr CrossPokemonEff -> repr Effect

data PokemonEff = PokemonEff String

data CrossPokemonEff = CrossPokemonEff String

data Ailment = Ailment String

data Counterparty = User | Target deriving (Eq,Show,Ord,Enum)

newtype Global a = Global a

user = User
target = Target


--- deletoi, hyvä tiedostaa silti

class Joku r where
  a :: r Effect
  b :: Int -> r Effect
  c :: r Effect -> r Effect -> r Effect

data Hassu r where
  A :: Hassu Effect
  B :: Int -> Hassu Effect
  C :: Hassu Effect -> Hassu Effect -> Hassu Effect

instance Joku Hassu where
  a = A
  b = B
  c = C

funktio :: Hassu r -> Int
funktio z = case z of
  A -> 1
  B x -> x
  C x y -> 107
