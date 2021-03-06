module CSI (main) where

import Data.List

data Boy = Matthew | Peter | Jack | Arnold | Carl 
    deriving (Eq,Show)

boys :: [Boy]
boys = [Matthew, Peter, Jack, Arnold, Carl]

{- What the children say is transformed into a truth table
 - of disjunctions possible incriminations. Example:

 - Matthew says Carl didn't do it and neither did he.
 - In other words: Matthew says it was either Peter, Jack or Arnold.

 - We encode the disjunction of possible incriminations for each
 - boy in the `says` function.
 -}

says :: Boy -> Boy -> Bool

says Matthew Peter  = True
says Matthew Jack   = True
says Matthew Arnold = True

says Peter Matthew  = True
says Peter Jack     = True

says Jack Carl      = True

says Arnold Matthew = True
says Arnold Peter   = True
says Arnold Arnold  = True

says Carl Jack      = True
says Carl Carl      = True

says _ _            = False


accusers :: Boy -> [Boy]
accusers boy = filter ((flip says) boy) boys

guilty :: [Boy]
guilty = filter ((== 3) . length . accusers) boys

count :: (Eq a) => a -> [a] -> Int
count element = length . filter (== element)

honest :: [Boy]
honest = filter (\boy -> count boy correctAccusations == lengthGuilty) boys
  where correctAccusations = concatMap accusers guilty
        lengthGuilty       = length guilty

main = putStrLn "Hello, world"
