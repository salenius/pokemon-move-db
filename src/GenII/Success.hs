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

class HitSYM repr where
  bypassAccuracyCheck :: repr Hit

class NonStrikeOpSYM repr where
  switchingOut :: repr NonStrikeOp
  usingItem :: repr NonStrikeOp


data NonStrikeOp = NonStrikeOp String

data FailureAlgo = FailureAlgo String
