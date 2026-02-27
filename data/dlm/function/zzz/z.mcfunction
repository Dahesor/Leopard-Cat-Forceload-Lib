#data modify storage dlm: ticket set value {id:"test1",pos:{x:1000,z:1000},life:{type:"temp"},on_load:["say c"]}

data modify storage dlm: ticket set value {life:{type:"wait",time:1000},on_load:"say a"}
function dlm:new_ticket

return 1
data modify storage dlm: ticket set value {id:"test1",pos:{x:1000,z:1000},life:{type:"wait",time:1000}}
function dlm:new_ticket

data modify storage dlm: ticket set value {id:"test2",pos:{x:1000,z:1101},life:{type:"wait",time:500}}
function dlm:new_ticket

data modify storage dlm: ticket set value {id:"test3",pos:{x:1000,z:1101},life:{type:"wait",time:750}}
function dlm:new_ticket

data modify storage dlm: ticket set value {id:"test4",pos:{x:1000,z:1101},life:{type:"wait",time:1100}}
function dlm:new_ticket


function dlm:api/extende_ticket {id:"test2",time:2000}