module GenI.Success where

import GenI.Attribute

class SuccessSYM repr where
  charge :: repr Turn -> repr Success
  afterSucceeding :: repr Success -> repr Effect -> repr Effect

infixr 4 `afterSucceeding`

data Success = Success Bool
