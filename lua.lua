VERSION = "0.0.1"

local micro = import("micro")
local shell = import("micro/shell")

function onSave(bp)
	if bp.Buf:FileType() == "lua" then
		formatLua(bp)
	end
	return true
end

function formatLua(bp)
	bp:Save()
	local _, err = shell.RunCommand("stylua " .. bp.Buf.Path)
	if err ~= nil then
		micro.InfoBar():Error(err)
		return
	end
		
	bp.Buf:ReOpen()	
end
