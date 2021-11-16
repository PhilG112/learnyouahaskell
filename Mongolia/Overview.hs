module Mongolia.Overview where

data Chain = GenesisBlock | Block Chain Txs

type Txs = Int

chain1 :: Chain
chain1 = Block GenesisBlock 2
chain2 :: Chain
chain2 = Block chain1 4

chain' :: Chain
chain' = Block (Block GenesisBlock 2) 4

chainLength :: Chain -> Int
chainLength GenesisBlock = 0
chainLength (Block c _) = chainLength c + 1