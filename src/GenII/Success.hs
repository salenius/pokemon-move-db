module GenII.Success (
  module GenI.Success
  ,module GenII.Success
                     ) where

import GenI.Success hiding (SuccessSYM())
import qualified GenI.Success as GenI
import GenII.Effect
import GenII.Attribute

class (GenI.SuccessSYM repr) => SuccessSYM repr where
  ifTarget :: repr NonStrikeOp -> repr Effect -> repr Effect -> repr Effect
  execImmediatelyBeforeTarget :: repr Success
  failureIfUsedInRow :: repr FailureAlgo -> repr Success
  probabilityOfFailing :: (Int -> Int) -> repr FailureAlgo
  requireUserHp :: (MaxHP -> CurrentHP -> Bool) -> repr Success

class HitSYM repr where
  replaceHit :: repr Move -> repr Hit -> repr Move
  bypassAccuracyCheck :: repr Hit
  bypassAccuracyCheckDuring :: repr Weather -> repr Hit

class NonStrikeOpSYM repr where
  switchingOut :: repr NonStrikeOp
  usingItem :: repr NonStrikeOp


data NonStrikeOp = NonStrikeOp String

data FailureAlgo = FailureAlgo String
