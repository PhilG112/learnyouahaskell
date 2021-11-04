module PL.CommonMonads where

import Control.Monad.Reader
import Control.Monad.State ( MonadState(put, get), State )
import Control.Monad.ST
import Data.STRef

-- Reader
    -- Express computations that needs access to some context value
    -- Make a value avaibale to different computations without having to explicitly pass it around as an argument 

    -- data Reader r a
    -- r = type of context value which can be read within the reader Monad
    -- a = Result of the Reader computation. The type packaged up in the Reader monad

    -- ask :: Reader r r
    -- Use to rad the context value r
    -- Value in reader monad whos resulting value is just the context value stored in the Reader

    -- runReader :: Reader r a -> r -> a
    -- Supply context value
    -- r = context value for the Reader to use

getFirst :: Reader String String 
getFirst = do
    name <- ask
    return (name ++ " woke up")

getSecond :: Reader String String
getSecond = do
    name <- ask 
    return (name ++ " wrote some haskell")

getStory :: Reader String String
getStory = do
    first <- getFirst
    second <- getSecond
    return ("First, " ++ first ++ ". Second, " ++ second)

story :: String
story = runReader getStory "Benson"

-- State
    -- Write code whos state might change during computation
    -- Not a hack to write imperitive code

    -- data State s a
    -- s = type of the state
    -- a = result of the stateful computation

    -- get :: State s s
    -- Gets the state type and returns it

    -- put :: s -> State s ()
    -- s = new state value
    -- return state monad action which stores the new state

    -- evalState :: State s a -> s -> a
    -- Run state monad like this
    -- s = initial state value
    -- a = result of the stateful computation

type Position = Double 
type Velocity = Double

harmonicStep :: State (Position, Velocity) Double
harmonicStep = do
    (position, velocity) <- get
    let acceleration = (-0.01 * position)
        velocity' = velocity + acceleration
        position' = position + velocity'
    put (position', velocity')
    return position

harmonic :: State (Position, Velocity) [Double]
harmonic = do
    position <- harmonicStep
    laterPositions <- harmonic
    return (position:laterPositions)

-- let positions = evalState harmonic (1,0)
-- evalState harmonic (1,0)


-- ST
    -- State monad on steroids
    -- Implement imperative algorithms
    -- Modifiable values
    -- Pure from the outside
    -- Can be higher performance
    -- Translating imperative code
    -- Complicated, multi-part state

    -- data ST s a
    -- a = result of the computation
    -- s = used by the type system to enforce purity, ignore it

    -- runST :: ST s a -> a

    -- data STRef s a
    -- a = This holds a reference to type variable a, updatable value of type a
    -- s = Ignore, keeps track of what ST computation this particular STRef belongs to, cannot mix and match ST computations

    -- newSTRef :: a -> ST s (STRef s a)
    -- a = value at which the STRef should start at
    -- returns an ST computation where the result is the new STRef of type a

    -- readSTRef :: STRef s a -> ST s a
    -- Take the STRef to read from and returns an ST value which retusn the type of the STRef

    -- writeSTRef :: STRef s a -> a -> ST s ()
    -- Take a value to store in the STRef (updating it)
    -- Produces an ST action which will perform that update

sumST :: [Int] -> STRef s Int -> ST s ()
sumST [] accumRef = return ()
sumST (x:xs) accumRef = do
    accum <- readSTRef accumRef
    writeSTRef accumRef (x + accum)
    sumST xs accumRef

sum' :: [Int] -> Int 
sum' xs = runST $ do
    accumRef <- newSTRef 0
    sumST xs accumRef
    readSTRef accumRef