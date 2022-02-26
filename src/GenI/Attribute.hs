{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE FunctionalDependencies #-}


module GenI.Attribute where

newtype Ready a = Ready a deriving (Eq,Show,Ord)

data TypeAdvantage =
  Ineffective
  | NotVeryEffective
  | NormalEffect
  | SuperEffective
  deriving (Eq,Show,Ord,Enum)
  
data MoveAttr n p t = MoveAttr
  {
    _name :: n
  , _pp :: p
  , _basepower :: Maybe Int
  , _typeOf :: t
  , _accuracy :: Maybe Double
  , _priority :: Int
  }

data Move = Move String deriving (Eq,Show,Ord)

data Attr = Attr String deriving (Eq,Show,Ord)

data PkmnType = PkmnType String deriving (Eq,Show,Ord)

data Battles = Battles

class Semigroup (mv [Attr]) => Attribute mv where
  name :: String -> mv String
  pp :: Int -> mv [Attr]
  typeOf :: mv PkmnType -> mv [Attr]
  accuracy :: Double -> mv [Attr]
  priority :: Int -> mv [Attr]
  having :: mv String -> mv Battles -> mv Move
  effects :: mv [Attr] -> mv Effect -> mv Battles

data Effect = Effect String deriving (Eq,Show)

class TypeOf t where
  normal :: t PkmnType
  fighting :: t PkmnType
  flying :: t PkmnType
  water :: t PkmnType
  fire :: t PkmnType
  grass :: t PkmnType
  electric :: t PkmnType
  ground :: t PkmnType
  rock :: t PkmnType
  bug :: t PkmnType
  poison :: t PkmnType
  ice :: t PkmnType
  psychic :: t PkmnType
  ghost :: t PkmnType
  dragon :: t PkmnType

class TurnSYM repr where
  turns :: Int -> repr Turn
  randomTurnsBetween :: Int -> Int -> repr Turn

infixr 4 `effects`
infixr 2 `having`

data SemiInvulnerable = Dig | Fly | Dive deriving (Eq,Show,Ord,Enum)

data Weather =
  Fine
  | Sunny
  | Rainy
  | Hail
  | Sandstorm
  deriving (Eq,Show,Ord,Enum,Bounded)

data Turn = Turn Int
