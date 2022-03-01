{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}



module GenI.Damage where

import GenI.Attribute

class (Semigroup (repr Damage)) => DamageSYM repr where
  basepower :: Int -> repr Damage
  directDamage :: repr DamageFactor -> repr Damage
  counterAttack :: Double -> repr Damage
  ohko :: repr Damage
  (*.) :: repr Damage -> repr DamageProd -> repr Damage
  multiStrike :: (Int -> Double) -> repr Damage -> repr Damage
  damageRandomlyBetween :: repr DamageFactor -> repr DamageFactor -> repr Damage
  afterDamage :: repr Damage -> repr Effect -> repr Effect

infixr 4 `afterDamage`
infixl 6 *.

class DamageProdSYM repr where
  ignoreTypeImmunity :: repr DamageProd
  ignoreTypeAdvantages :: repr DamageProd
  increasedCriticalHitRatio :: Int -> repr DamageProd

class DamageFactorSYM repr where
  constantAmount :: Int -> repr DamageFactor
  levelOfUser :: repr DamageFactor
  hpOfTarget :: Double -> repr DamageFactor
  userTargetHpDelta :: repr DamageFactor
  multiplyBy :: Double -> repr DamageFactor -> repr DamageFactor

----
newtype Damage = Damage Double deriving (Eq,Show,Ord)

newtype DamageProd = DamageProd Double deriving (Eq,Show,Ord)

newtype DamageFactor = DamageFactor Double deriving (Eq,Show,Ord)
