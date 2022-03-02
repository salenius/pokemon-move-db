module GenIV.Success (
  module GenIV.Success
  ,module GenIII.Success
                     ) where

import GenIII.Success --hiding (SuccessSYM())
--import qualified GenIII.Success as Prev

class TargetMoveReqSYM repr where
  targetChoseNonStatusMove :: repr Success

