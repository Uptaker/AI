# Minimax

**Minimax**  is a decision rule used for **minimizing the possible loss for a worst case** (maximum loss) scenario. When dealing with gains, it is referred to as "maximin" – to maximize the minimum gain.

The **maximin value** is the highest value that the player can be sure to get without knowing the actions of the other players; equivalently, it is the lowest value the other players can force the player to receive when they know the player's action.

## Pseudocode
The pseudocode for the depth-limited minimax algorithm is given below.

```
function  minimax( node, depth, maximizingPlayer ) is
    if depth = 0 or node is a terminal node then
        return the heuristic value of node
    if maximizingPlayer then
        value := −∞
        for each child of node do
            value := max(value, minimax(child, depth − 1, FALSE))
        return value
    else (* minimizing player *)
        value := +∞
        for each child of node do
            value := min( value, minimax( child, depth − 1, TRUE ) )
        return value
```

```
_(* Initial call *)_
minimax( origin, depth, TRUE )
```
