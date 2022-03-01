module GenIII.Success(
  module GenIII.Success
  ,module GenII.Success
                     ) where

import GenII.Success hiding (SuccessSYM(), HitSYM())
import qualified GenII.Success as GenII
import GenIII.Attribute

class GenII.SuccessSYM repr => SuccessSYM repr where
  firstTurnOnly :: repr Success

class GenII.HitSYM repr => HitSYM repr where
  hitProbAsLevelDiff :: (UserLevel -> TargetLevel -> Prob -> Double) -> repr Hit

type UserLevel = Int
type TargetLevel = Int
type Prob = Double
