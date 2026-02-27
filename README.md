# Leopard Cat Forceload Lib

[中文](./docs/zh_cn.md)

A minecraft data pack library that manages forceloads

For Minecraft Java 1.21.5+

## Introduction

Leopard Cat changes how `forceload` is used. With it installed, all forceload instructions should be given through Leopard Cat.

Users can create **tickets** to load a chunk or a rectangular area of chunks in a specific dimension. A chunk will stay loaded as long as there is at least one ticket loading it.

Minecraft handles `forceload` asynchronously, which means a chunk is not immediately available after `forceload`. Leopard Cat allows you to specify a list of `on_load` commands that will be executed after the target chunk(s) are fully loaded.

A ticket can also specify how long it should last.

## How to Use

To create a ticket, first write parameters into storage `dlm:` under key `ticket`. Fields:

`id`: *string*,   An unique identifier. Do not use special characters.\
`pos`: *Position*,   Specify any block pos in the target chunk. Can be either an object `{x:<z>,z:<z>}`, or a list of length 2 `[x, z]` or length 3 `[x, y, z]` (y will be ignored). If `pos` is omitted then the execution context will be used.\
`to`: *Position*,  Same as `pos`. If present, select the rectangular area formed to load multiple chunks.\
`dimension`: *#[id="dimension"] string,*   Dimension of this ticket. If omitted and the command context is in the 3 vanilla dimensions then it will be deduced automatically.\
`on_load`: *(#[command] string | [#[command] string])*,   A string of command or a list of commands. Executed by the server right after the chunks are all fully loaded\
`life`: *struct* {   Specify how long this ticket should last.
 -    `type`: *(`"indefinite"`|`"temp"`|`"wait"`)*,    `indefinite`: Never close ticket unless instructed to do so; `temp`: Close this ticket immediately after `on_load` commands; `wait`: Close this ticket after `time` amount of ticks
 -    `time`: *int*,    For `type:wait` only. Specifies the number of ticks to wait before auto-removal.\
}

Then, execute `function dlm:new_ticket` to create the ticket. Additionally, `dlm:macro_ticket` can be used by inserting the above structure inside the `ticket` macro parameter; `dlm:temp_ticket_here` can be used by only providing `on_load` and a anonymous temp ticket at the context position will be created.

To close a ticket, use `function dlm:close_ticket {id:"<id>"}`

### API

- **`function dlm:api/extende_ticket {time:<time>,id:"<id>"}`**

Extend a life:`{type:"wait"}` ticket by the macro input\
`time`: the new time this ticket should last, in ticks, counted from the moment this function is called\
`id`: Id of the ticket to extend, must be a ticket of type "wait"

- **`function dlm:api/persevere_this_ticket`**

Callable only during on_load. If the ticket is of `life:{type:"temp"}`, persevere this ticket and do not unload the chunk

- **`function dlm:api/gc`**

Run garbage collection manually. Unload chunks that do not have a ticket. This will run automatically as long as you operate with the public interfaces.

## Dependency

A Leopard_Cat_Dependency folder is included in the repository. This can be used as spyglass dependency file for the spyglass data pack helper extension to procide hints about Leopard Cat's public interfaces.

Put this folder (or zip it) anywhere on your computer, then by creating a `spyglass.json` file at the root of your workspace, the Spyglass extension will provides you the completion and error checking of all the functions and storages you need to write to use this library.

Example content of the `spyglass.json` file. See [Spyglass Documentation](https://spyglassmc.com/user/config.html) for more.
```json
{
	"env": {
		"dependencies": [
			"file:///C:/path/to/Leopard_Cat_Dependency",
			"@vanilla-mcdoc",
			"@vanilla-resourcepack",
			"@vanilla-mcdoc"
		],
		"gameVersion": "1.21.11"
	}
}
```
Remeber to Reload Vscode. If something about this somehow goes wrong, make Vs Code run the `Spyglass: Reset Project Cahce` command. 