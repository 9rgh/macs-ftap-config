--[[
	blackplt — encoded loader
	Opening this raw link shows mostly gibberish.
	Use: loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL"))()
]]

local _b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function _d(data)
	data = string.gsub(data, "[^" .. _b .. "=]", "")
	return (data:gsub(".", function(x)
		if x == "=" then return "" end
		local r, f = "", (_b:find(x) - 1)
		for i = 6, 1, -1 do
			r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
		end
		return r
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
		if #x ~= 8 then return "" end
		local c = 0
		for i = 1, 8 do
			c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
		end
		return string.char(c)
	end))
end

local _p = [=[
bG9jYWwgVHdlZW5TZXJ2aWNlID0gZ2FtZTpHZXRTZXJ2aWNlKCJUd2VlblNlcnZpY2UiKQ0KbG9jYWwgUGxheWVycyA9IGdhbWU6R2V0U2VydmljZSgiUGxheWVycyIpDQpsb2NhbCBMb2NhbFBsYXllciA9IFBsYXllcnMuTG9jYWxQbGF5ZXINCg0KDQpsb2NhbCBmb2xkZXJOYW1lID0gTG9jYWxQbGF5ZXIuTmFtZSAuLiAiU3Bhd25lZEluVG95cyINCmxvY2FsIGZvbGRlciA9IHdvcmtzcGFjZTpXYWl0Rm9yQ2hpbGQoZm9sZGVyTmFtZSwgMTApDQoNCmlmIG5vdCBmb2xkZXIgdGhlbg0KCXdhcm4oIuaJvuS4jeWIsOizh+aWmeWkvu+8miIgLi4gZm9sZGVyTmFtZSkNCglyZXR1cm4NCmVuZA0KDQpsb2NhbCBSRUZMRUNUQU5DRSA9IDAuMjgNCmxvY2FsIENPTE9SX1RJTUUgPSAwLjcNCg0KbG9jYWwgZnVuY3Rpb24gYXBwbHlCbGFjayhvYmopDQoJaWYgbm90IG9iaiBvciBub3Qgb2JqLlBhcmVudCB0aGVuIHJldHVybiBlbmQNCg0KCWZvciBfLCBwYXJ0IGluIGlwYWlycyhvYmo6R2V0RGVzY2VuZGFudHMoKSkgZG8NCgkJaWYgcGFydDpJc0EoIkJhc2VQYXJ0IikgdGhlbg0KCQkJbG9jYWwgb2xkID0gcGFydDpGaW5kRmlyc3RDaGlsZCgiRmFrZVJlZmxlY3Rpb24iKQ0KCQkJaWYgb2xkIHRoZW4gb2xkOkRlc3Ryb3koKSBlbmQNCg0KCQkJVHdlZW5TZXJ2aWNlOkNyZWF0ZSgNCgkJCQlwYXJ0LA0KCQkJCVR3ZWVuSW5mby5uZXcoQ09MT1JfVElNRSwgRW51bS5FYXNpbmdTdHlsZS5RdWFkLCBFbnVtLkVhc2luZ0RpcmVjdGlvbi5PdXQpLA0KCQkJCXsNCgkJCQkJQ29sb3IgPSBDb2xvcjMuZnJvbVJHQigxMCwgMTAsIDEwKSwNCgkJCQkJUmVmbGVjdGFuY2UgPSBSRUZMRUNUQU5DRQ0KCQkJCX0NCgkJCSk6UGxheSgpDQoNCgkJCWxvY2FsIGhpZ2hsaWdodCA9IEluc3RhbmNlLm5ldygiSGlnaGxpZ2h0IikNCgkJCWhpZ2hsaWdodC5OYW1lID0gIkZha2VSZWZsZWN0aW9uIg0KCQkJaGlnaGxpZ2h0LkFkb3JuZWUgPSBwYXJ0DQoJCQloaWdobGlnaHQuRmlsbENvbG9yID0gQ29sb3IzLmZyb21SR0IoMjU1LCAyNTUsIDI1NSkNCgkJCWhpZ2hsaWdodC5GaWxsVHJhbnNwYXJlbmN5ID0gMC45Mw0KCQkJaGlnaGxpZ2h0Lk91dGxpbmVUcmFuc3BhcmVuY3kgPSAxDQoJCQloaWdobGlnaHQuRGVwdGhNb2RlID0gRW51bS5IaWdobGlnaHREZXB0aE1vZGUuT2NjbHVkZWQNCgkJCWhpZ2hsaWdodC5QYXJlbnQgPSBwYXJ0DQoJCWVuZA0KCWVuZA0KZW5kDQoNCmZvbGRlci5DaGlsZEFkZGVkOkNvbm5lY3QoZnVuY3Rpb24ob2JqKQ0KCWlmIG9iai5OYW1lID09ICJQYWxsZXRMaWdodEJyb3duIiB0aGVuDQoJCXRhc2sud2FpdCgwLjI1KQ0KCQlpZiBvYmogYW5kIG9iai5QYXJlbnQgdGhlbg0KCQkJYXBwbHlCbGFjayhvYmopDQoJCWVuZA0KCWVuZA0KZW5kKQ0KDQoNCmZvciBfLCBvYmogaW4gaXBhaXJzKGZvbGRlcjpHZXRDaGlsZHJlbigpKSBkbw0KCWlmIG9iai5OYW1lID09ICJQYWxsZXRMaWdodEJyb3duIiB0aGVuDQoJCXRhc2suc3Bhd24oZnVuY3Rpb24oKQ0KCQkJdGFzay53YWl0KDAuMjUpDQoJCQlhcHBseUJsYWNrKG9iaikNCgkJZW5kKQ0KCWVuZA0KZW5kDQo=
]=]

local ok, err = pcall(function()
	loadstring(_d(_p))()
end)
if not ok then
	warn("[blackplt] load failed:", err)
end
