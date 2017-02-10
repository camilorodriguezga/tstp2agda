
-- tstp2agda proof

open import Data.FOL.Deep 2
open import Data.FOL.Deep.ATP.Metis 2

-- Vars
clause : Prop
clause = Var (# 0)

lit : Prop
lit = Var (# 1)

-- Premise
Γ : Ctxt
Γ = ∅

-- Conjecture
goal : Prop
goal = ((lit ⇒ clause) ⇒ ((lit ∨ clause) ⇔ clause))

-- Subgoals
subgoal₀ : Prop
subgoal₀ = (((lit ⇒ clause) ∧ (lit ∨ clause)) ⇒ clause)

subgoal₁ : Prop
subgoal₁ = ((((lit ⇒ clause) ∧ clause) ∧ ¬ lit) ⇒ clause)

-- Metis Proof.
proof₀ : Γ ⊢ subgoal₀
proof₀ =
  RAA $
    atp-canonicalize $
      inference rule no supported yet $
-- no supported yet


proof₁ : Γ ⊢ subgoal₁
proof₁ =
  RAA $
    atp-canonicalize $
      atp-canonicalize $
        atp-strip $
          assume {Γ = Γ} $
            atp-neg subgoal₁


