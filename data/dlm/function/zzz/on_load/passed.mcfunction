scoreboard players set #del dlm__ 1
scoreboard players set #persevere dlm__ 0

data modify storage dlm: This_Validation set from storage dlm: validations[0]

execute if data storage dlm: This_Validation{temp:true} run function dlm:zzz/on_load/__close_temp with storage dlm: This_Validation

data modify storage dlm: cmd.exe set from storage dlm: validations[0].on_pass
function dlm:zzz/on_load/run_cmds

execute if score #persevere dlm__ matches 1.. run function dlm:zzz/on_load/__reopen with storage dlm: This_Validation
execute unless score #persevere dlm__ matches 1.. run function dlm:zzz/gc/close_invalid_nvd_

data remove storage dlm: This_Validation


