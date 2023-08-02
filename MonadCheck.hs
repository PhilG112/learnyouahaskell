module MonadCheck where

import Control.Monad.Trans.Maybe
import Control.Monad.Trans.State
import Control.Monad.Cont

-- The underlying state type
type MyState = Int

-- A computation that increments the state and may fail
incrementAndCheck :: MaybeT (StateT MyState IO) Bool
incrementAndCheck = do
    lift $ modify (+1)
    newState <- lift get
    if newState <= 10
        then return True
        else MaybeT $ return Nothing

main :: IO ()
main = do
    let initialState = 5
    result <- runStateT (runMaybeT incrementAndCheck) initialState
    case result of
        (Just isSuccess, finalState) ->
            putStrLn $ "Computation succeeded: " ++ show isSuccess ++ ", State: " ++ show finalState
        (Nothing, finalState) ->
            putStrLn $ "Computation failed, State: " ++ show finalState