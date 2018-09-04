# snakesnladders

Explanation: Board will be built using specific key value pairs comprising of snake and ladder points. On dice roll will first update the position (previous position + new random dice number), then we check value associated with the position key in Dict if it returns Just number, I will update the new position with the value of key in Dict else do nothing. 

Pros: We can access the Dict with the key which will be updated position (previous dice + new random dice number), this gives us time complexity of O(log n).

Cons: Will be saving on the space complexity front with this approach. 

Steps to Run it. 

1. clone this repo.
2. cd into the directory. 
3. run elm-reactor, click on snakesNladders file. 
