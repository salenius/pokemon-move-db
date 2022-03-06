module GenV.Move (
  module GenV.Move
  ,module GenIV.Move
                 ) where

import GenIV.Move 
import GenV.Effect
import GenV.Attribute
import GenV.Damage

class (Attribute mv, TypeOf mv, CategorySYM mv, SideEffect mv) => GenVMove mv

acrobatics :: (GenVMove mv, DamageSYM mv, DamageProdSYM mv, DamageEventSYM mv) => mv Move
acrobatics =
  name "Acrobatics"
  `having`
  pp 15 <>
  typeOf flying <>
  category physical <>
  makesContact <>
  accuracy 1.0
  `effects`
  basepower 55 *.
  doubleDamageIf userHasNoHeldItem
  `afterDamage`
  noEffect

quiverDance :: (GenVMove mv, StatSYM mv, ModifStatSYM mv) => mv Move
quiverDance =
  name "Quiver Dance"
  `having`
  pp 20 <>
  typeOf bug <>
  category status
  `effects`
  affect user (raise spAttackStat plus1) `andAlso`
  affect user (raise spDefenceStat plus1) `andAlso`
  affect user (raise speedStat plus1)
