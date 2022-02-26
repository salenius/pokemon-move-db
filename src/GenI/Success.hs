module GenI.Success where

import GenI.Attribute

class Semigroup (repr Success) => SuccessSYM repr where
  charge :: repr Turn -> repr Success
  afterSucceeding :: repr Success -> repr Effect -> repr Effect
  succeedOnlyIf :: Counterparty -> repr Ailment -> repr Success

infixr 4 `afterSucceeding`

data Success = Success Bool
