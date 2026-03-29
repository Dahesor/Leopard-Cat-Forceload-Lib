$data modify storage dlm: data[].Chunks[].tickets[{id:"$(from_ticket)"}].valid set value false
$data modify storage dlm: validations[{from_ticket:"$(from_ticket)"}].valid set value false
$data modify storage dlm: live_tickets[{id:"$(from_ticket)"}].valid set value false
$data modify storage dlm: timed_tickets[{id:"$(from_ticket)"}].valid set value false