
-- | Data.Proof.ProofTreeGen module

{-# LANGUAGE CPP           #-}


module Data.Proof.ProofTreeGen where


import           Data.Map   (Map, empty, insert)
import           Data.Map   as M (lookup)
import           Data.Maybe (catMaybes, mapMaybe)
import           Data.Set   (Set)
import           Data.TSTP  (Role, Rule, F)

#if __GLASGOW_HASKELL__ <= 708
import           Control.Applicative ((<$>), (<*>))
import           Data.Foldable       (Foldable (..))
import           Data.Traversable    (Traversable (..))
import           Prelude             hiding (foldl, foldr)
#endif

-- | Generic tree structure for representing the structure of a proof.
data ProofTreeGen a =
    -- | 'Leaf' 'r' 'a' is a node with 'Role' 'r' and content 'a' (usually
    -- 'String', 'F' or 'Formula') and with no dependencies in other nodes.
    Leaf Role a |
    -- | 'Root' 'r' 'a' 'd' is a node with deduction 'Rule' 'r', content 'a'
    -- (usually 'String', 'F' or 'Formula'),  and dependencies 'd'.
    Root Rule a [ProofTreeGen a]
         deriving (Eq,Ord,Show)

-- | Simple type for sets of identifiers whit associated scopes
type IdSet = Set (Int,String)

-- | Concrete instance of 'ProofTreeGen' with 'String' as
-- contents. Each node contains the name of a corresponding formula,
-- along with its dependencies.
type ProofTree = ProofTreeGen String

instance Functor ProofTreeGen where
    fmap f (Leaf r a)   = Leaf r (f a)
    fmap f (Root r a t) = Root r (f a) (map (fmap f) t)

instance Foldable ProofTreeGen where
    foldr f b (Leaf r a)   = f a b
    foldr f b (Root r a t) = f a $ foldr (flip $ foldr f) b t

instance Traversable ProofTreeGen where
    traverse f (Leaf r a)   = Leaf r <$> f a
    traverse f (Root r a t) = Root r <$> f a <*> traverse (traverse f) t

-- | 'Map' from formula names to an 'F' formula type, useful to get more
-- information from a node in a 'ProofTree'.
type ProofMap = Map String F
