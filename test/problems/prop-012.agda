
-- tstp2agda proof

open import Data.FOL.Deep 1 public
open import Data.FOL.Deep.ATP.Metis 1 public

-- Vars
p : Prop
p = Var (# 0)

-- Premise
Γ : Ctxt
Γ = ∅

-- Conjecture
goal : Prop
goal = (¬ ¬ p ⇔ p)


-- Subgoals
subgoal₀ : Prop
subgoal₀ = (¬ ¬ p ⇒ p)


subgoal₁ : Prop
subgoal₁ = (p ⇒ p)

-- Metis Proof.
proof₀ : Γ ⊢ subgoal₀
proof₀ =
  RAA $
  -- Γ , ¬ subgoal₀⊢ ⊥
    atp-canonicalize $
      atp-canonicalize $
        atp-strip $
          assume {Γ = Γ} $
            atp-neg subgoal₀

proof₁ : Γ ⊢ subgoal₁
proof₁ =
  RAA $
  -- Γ , ¬ subgoal₁⊢ ⊥
    atp-canonicalize $
      atp-canonicalize $
        atp-strip $
          assume {Γ = Γ} $
            atp-neg subgoal₁

proof : Γ ⊢ goal
proof =
  ⇒-elim
    atp-splitGoal
    (
    ∧-intro
      subgoal₀
      subgoal₁
    )

