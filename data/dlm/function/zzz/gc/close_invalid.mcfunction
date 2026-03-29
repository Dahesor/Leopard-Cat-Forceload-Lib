data remove storage dlm: data[].Chunks[].tickets[{valid:false}]
data remove storage dlm: validations[{valid:false}]
data remove storage dlm: live_tickets[{valid:false}]
data remove storage dlm: timed_tickets[{valid:false}]

scoreboard players set #need_gc dlm__ 1