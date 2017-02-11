
-- tstp2agda proof

open import Data.FOL.Deep 2
open import Data.FOL.Deep.ATP.Metis 2

-- Vars
x : Prop
x = Var (# 0)

y : Prop
y = Var (# 1)

-- Premise
Γ : Ctxt
Γ = ∅

-- Conjecture
goal : Prop
goal = ((¬ y ⇒ ¬ x) ⇒ ((¬ y ⇒ x) ⇒ y))

-- Subgoal
subgoal₀ : Prop
subgoal₀ = (((¬ y ⇒ ¬ x) ∧ (¬ y ⇒ x)) ⇒ y)

-- Metis Proof.
proof₀ : Γ ⊢ subgoal₀
proof₀ =
  RAA $
    atp-canonicalize $
      atp-simplify $ ∧-intro
        (
        inference rule no supported yet $
          atp-canonicalize $
            atp-strip $
              assume {Γ = Γ} $
                atp-neg subgoal₀        )
        (
        atp-simplify $ ∧-intro
          (
          inference rule no supported yet $
            atp-canonicalize $
              atp-strip $
                assume {Γ = Γ} $
                  atp-neg subgoal₀          )
          (
          inference rule no supported yet $
            atp-canonicalize $
              atp-strip $
                assume {Γ = Γ} $
                  atp-neg subgoal₀          )
        )
        (
        inference rule no supported yet $
          atp-canonicalize $
            atp-strip $
              assume {Γ = Γ} $
                atp-neg subgoal₀        )



