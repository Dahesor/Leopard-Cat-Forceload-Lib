# 大脸猫Forceload库
1.21.5+管理forceload的Minecraft数据包库。

## 简介

大脸猫为原版的`forceload`命令加装了外壳。使用大脸猫时，所有的`forceload`指令都应当通过大脸猫下达。

用户可以创建**请求**以加载特定的区块，或指定长方形范围内的多个区块。一个区块上只要挂有至少一个**请求**，就会被持续加载。

Minecraft的`forceload`命令是异步的，这意味着在执行`forceload`后区块可能不会立刻完成加载。大脸猫允许用户提供一个`on_load`命令列表，在请求的区块全部加载完成后自动执行这些命令。

每个请求也可以指定自己的生命周期。

## How to Use

想要创建一个请求，首先在storage `dlm:`的键名`ticket`下输入数据。包括：

`id`: *string*,   该请求的唯一标识符。勿要使用特殊字符。\
`pos`: *Position*,   指定要加载的区块。应该提供该区块内的任意方块坐标。可以为`{x:<z>,z:<z>}`的形式，也可以为一个长度为2或3的列表表示`[x, z]`或`[x, y, z]`(y若提供会被忽略)。 若不指定`pos`则会自动使用当前的执行位置。\
`to`: *Position*,  与`pos`相同。若存在，选定两角之间长方形范围内的所有区块。\
`dimension`: *#[id="dimension"] string,*   该请求的维度。若不提供，但当前命令在原版维度中执行，则会自动获取当前维度；否则请求创建失败。\
`on_load`: *(#[command] string | [#[command] string])*,   一个命令，或者一个列表的命令。在请求的区块全部加载完毕后，由服务器执行这些命令。\
`life`: *struct* {   指定该请求何时过期
 -    `type`: *(`"indefinite"`|`"temp"`|`"wait"`)*,    `indefinite`: （不定性）永不过期，只能手动移除; `temp`: （临时）一旦`on_load`命令执行完毕就立刻移除该请求。; `wait`: （计时）在`time`刻后移除本请求。
 -    `time`: *int*,    若`type`为`wait`，指定请求持续的时间。\
}

在这之后，执行`function dlm:new_ticket`以创建请求。此外，也可以使用`dlm:macro_ticket`并把上述结构填进`ticket`宏参数中; 或使用`dlm:temp_ticket_here`，只需要在storage中指定`on_load`，即可快速在命令的执行位置和维度创建匿名的临时请求。

要移除一个请求，使用`function dlm:close_ticket {id:"<id>"}`。

### API

- **`function dlm:api/extend_ticket {time:<time>,id:"<id>"}`**

变更一个计时请求的结束时间\
`time`: 新的持续时间，从此刻算起\
`id`: 目标请求的ID

- **`function dlm:api/preserve_this_tick`**

仅在`on_load`时可用。若这个请求时临时请求，将它变更为不定性请求。

- **`function dlm:api/gc`**

手动执行垃圾回收器。正常情况下它会自动执行。

## Dependency

大脸猫提供了Leopard_Cat_Dependency文件夹用于大憨批的补全。

将其放置到电脑的任意位置，配合 [Spyglass](https://github.com/SpyglassMC/Spyglass)（Datapack Helper Plus），就可以通过在数据包根目录创建一个`spyglass.json`文件的方式，获取本库所需的所有函数和stoarge的自定义补全。

示例`spyglass.json`:
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
