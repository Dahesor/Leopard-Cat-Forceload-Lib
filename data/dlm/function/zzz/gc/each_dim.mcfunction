data modify storage dlm: data[0].Chunks[].alive set value false

data modify storage dlm: data[0].Chunks[{tickets:[{valid:true}]}].alive set value true

data modify storage dlm: gc set value []
data modify storage dlm: gc append from storage dlm: data[0].Chunks[{alive:false}]

data remove storage dlm: data[0].Chunks[{alive:false}]

execute if data storage dlm: gc[0] run function dlm:zzz/gc/__goto_dimension with storage dlm: data[0]

execute unless data storage dlm: data[0].Chunks[1] unless data storage dlm: data[0].Chunks[0].tickets[].id run data modify storage dlm: data[0].Chunks set value []

#Next
data modify storage dlm: data append from storage dlm: data[0]
data remove storage dlm: data[0]
scoreboard players add #this dlm__ 1
execute if score #this dlm__ < #dimension dlm__ run function dlm:zzz/gc/each_dim