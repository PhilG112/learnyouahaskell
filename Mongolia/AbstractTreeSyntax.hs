module Mongolia.AbstractTreeSyntax where

data Expr =
    Lit Int 
    | Add Expr Expr
    | Neg Expr
    | IfZero Expr Expr Expr

expr1 :: Expr
expr1 = IfZero (Add (Lit 3) (Neg (Lit 3)))
               (Lit 42)
               (Add (Lit 1) (Lit 2))


eval :: Expr -> Int
eval (Lit n) = n
eval (Add x y) = eval x + eval y
eval (Neg x) = -(eval x)
eval (IfZero x y z) = if eval x == 0 then eval y else eval z
