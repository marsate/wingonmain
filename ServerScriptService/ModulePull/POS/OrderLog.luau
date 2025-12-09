local http = game:GetService("HttpService")
local acceptableStatuses = {
	"submitted",
	"handed_to",
	"waiting_for_preparation",
	"finding_new_colleague",
	"preparing",
	"completed",
	"waiting_for_pickup",
	"cancelled"
}

local apiKey
local workspaceId

local function setupAPI(key: string, wsId: string)
	apiKey = key
	workspaceId = wsId
end

local function createOrder(customer: Player, actor: Player, info)
	if not apiKey or not workspaceId then
		return {
			error = true,
			message = "API Key not set"
		}
	end
	
	if not info.items then 
		warn("Items not set")
		return {
			error = true,
			message = "Items not set"
		}
	end
	
	local datatable = {
		customer = tostring(customer.UserId),
		submitted_by = tostring(actor.UserId),
		items = info.items
	}
	
	if info.orderNumber then 
		datatable['order_no'] = info.orderNumber
	end
	
	if info.status and table.find(acceptableStatuses, info.status) then
		datatable['status'] = info.status
	elseif info.status then
		warn("Invalid status")
		return {
			error = true,
			message = "Invalid status"
		}
	else
		datatable['status'] = "submitted"
	end
	
	local success, response = pcall(function()
		return http:RequestAsync({
			Url = "https://api.hyra.io/players/orders/" .. workspaceId,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json",
				["Authorization"] = "Bearer " .. apiKey,
				["RBX-Job-ID"] = (game.JobId and game.JobId ~= "") and game.JobId or "Roblox Studio"
			},
			Body = http:JSONEncode(datatable)
			})
	end)
	
	if not success then 
		warn("Failed to make request")
		return {
			error = true,
			message = "Failed to make request, try again"
		}
	end
	
	if success then 
		local parsed = http:JSONDecode(response.Body)
		
		if response.Success then
			return {
				error = false,
				order_number = parsed.order_number,
				id = parsed._id,
			}	
		else
			warn(parsed)
			return {
				error = true,
				message = "Request failed"
			}
		end	
	end
end

local function setWaiting(orderId: string)
	if not apiKey or not workspaceId then
		return {
			error = true,
			message = "API Key not set"
		}
	end

	local success, response = pcall(function()
		return http:RequestAsync({
			Url = "https://api.hyra.io/players/orders/" .. workspaceId .. "/" .. orderId,
			Method = "PATCH",
			Headers = {
				["Content-Type"] = "application/json",
				["Authorization"] = "Bearer " .. apiKey,
				["RBX-Job-ID"] = (game.JobId and game.JobId ~= "") and game.JobId or "Roblox Studio"
			},
			Body = http:JSONEncode({
				status = "waiting_for_preparation",
			})
		})
	end)

	if not success then 
		warn("Failed to make request")
		return {
			error = true,
			message = "Failed to make request, try again"
		}
	end

	if success then 
		local parsed = http:JSONDecode(response.Body)

		if response.Success then
			return {
				error = false,
				order_number = parsed.order_number,
				id = parsed._id,
			}	
		else
			warn(parsed)
			return {
				error = true,
				message = "Request failed"
			}
		end		
	end
end

local function setPreparing(orderId: string, preparedBy: Player)
	if not apiKey or not workspaceId then
		return {
			error = true,
			message = "API Key not set"
		}
	end

	local success, response = pcall(function()
		return http:RequestAsync({
			Url = "https://api.hyra.io/players/orders/" .. workspaceId .. "/" .. orderId,
			Method = "PATCH",
			Headers = {
				["Content-Type"] = "application/json",
				["Authorization"] = "Bearer " .. apiKey,
				["RBX-Job-ID"] = (game.JobId and game.JobId ~= "") and game.JobId or "Roblox Studio"
			},
			Body = http:JSONEncode({
				status = "preparing",
				prepared_by = tostring(preparedBy.UserId)
			})
		})
	end)

	if not success then 
		warn("Failed to make request")
		warn(response)
		return {
			error = true,
			message = "Failed to make request, try again"
		}
	end

	if success then 
		local parsed = http:JSONDecode(response.Body)

		if response.Success then
			return {
				error = false,
				order_number = parsed.order_number,
				id = parsed._id,
			}	
		else
			warn(parsed)
			return {
				error = true,
				message = "Request failed"
			}
		end		
	end
end

local function setReprepare(orderId: string)
	if not apiKey or not workspaceId then
		return {
			error = true,
			message = "API Key not set"
		}
	end

	local success, response = pcall(function()
		return http:RequestAsync({
			Url = "https://api.hyra.io/players/orders/" .. workspaceId .. "/" .. orderId,
			Method = "PATCH",
			Headers = {
				["Content-Type"] = "application/json",
				["Authorization"] = "Bearer " .. apiKey,
				["RBX-Job-ID"] = (game.JobId and game.JobId ~= "") and game.JobId or "Roblox Studio"
			},
			Body = http:JSONEncode({
				status = "finding_new_colleague",
			})
		})
	end)

	if not success then 
		warn("Failed to make request")
		return {
			error = true,
			message = "Failed to make request, try again"
		}
	end

	if success then 
		local parsed = http:JSONDecode(response.Body)

		if response.Success then
			return {
				error = false,
				order_number = parsed.order_number,
				id = parsed._id,
			}	
		else
			warn(parsed)
			return {
				error = true,
				message = "Request failed"
			}
		end		
	end
end

local function setReadyForPickup(orderId: string)
	if not apiKey or not workspaceId then
		return {
			error = true,
			message = "API Key not set"
		}
	end

	local success, response = pcall(function()
		return http:RequestAsync({
			Url = "https://api.hyra.io/players/orders/" .. workspaceId .. "/" .. orderId,
			Method = "PATCH",
			Headers = {
				["Content-Type"] = "application/json",
				["Authorization"] = "Bearer " .. apiKey,
				["RBX-Job-ID"] = (game.JobId and game.JobId ~= "") and game.JobId or "Roblox Studio"
			},
			Body = http:JSONEncode({
				status = "waiting_for_pickup",
			})
		})
	end)

	if not success then 
		warn("Failed to make request")
		return {
			error = true,
			message = "Failed to make request, try again"
		}
	end

	if success then 
		local parsed = http:JSONDecode(response.Body)

		if response.Success then
			return {
				error = false,
				order_number = parsed.order_number,
				id = parsed._id,
			}	
		else
			warn(parsed)
			return {
				error = true,
				message = "Request failed"
			}
		end		
	end
end

local function setComplete(orderId: string, pickedUpBy: Player)
	if not apiKey or not workspaceId then
		return {
			error = true,
			message = "API Key not set"
		}
	end
	
	local datatable = {
		status = "completed"
	}
	
	if pickedUpBy then
		datatable['picked_up_by'] = tostring(pickedUpBy.UserId)
	end

	local success, response = pcall(function()
		return http:RequestAsync({
			Url = "https://api.hyra.io/players/orders/" .. workspaceId .. "/" .. orderId,
			Method = "PATCH",
			Headers = {
				["Content-Type"] = "application/json",
				["Authorization"] = "Bearer " .. apiKey,
				["RBX-Job-ID"] = (game.JobId and game.JobId ~= "") and game.JobId or "Roblox Studio"
			},
			Body = http:JSONEncode(datatable)
		})
	end)

	if not success then 
		warn("Failed to make request")
		warn(response)
		return {
			error = true,
			message = "Failed to make request, try again"
		}
	end

	if success then 
		local parsed = http:JSONDecode(response.Body)

		if response.Success then
			return {
				error = false,
				order_number = parsed.order_number,
				id = parsed._id,
			}	
		else
			warn(parsed)
			return {
				error = true,
				message = "Request failed"
			}
		end		
	end
end

local function setCancelled(orderId: string)
	if not apiKey or not workspaceId then
		return {
			error = true,
			message = "API Key or Workspace ID not set"
		}
	end

	local success, response = pcall(function()
		return http:RequestAsync({
			Url = "https://api.hyra.io/players/orders/" .. workspaceId .. "/" .. orderId,
			Method = "PATCH",
			Headers = {
				["Content-Type"] = "application/json",
				["Authorization"] = "Bearer " .. apiKey,
				["RBX-Job-ID"] = (game.JobId and game.JobId ~= "") and game.JobId or "Roblox Studio"
			},
			Body = http:JSONEncode({
				status = "cancelled",
			})
		})
	end)

	if not success then
		warn("Failed to make HTTP request:", response)
		return {
			error = true,
			message = "Failed to make request, try again"
		}
	end

	if response.StatusCode == 200 then
		local parseSuccess, parsed = pcall(function()
			return http:JSONDecode(response.Body)
		end)

		if parseSuccess then
			return {
				error = false,
				order_number = parsed.order_number,
				id = parsed._id,
			}
		else
			warn("Failed to parse response:", response.Body)
			return {
				error = true,
				message = "Failed to parse API response"
			}
		end
	else
		warn("Request failed with status code:", response.StatusCode)
		warn("Response body:", response.Body)
		return {
			error = true,
			message = "Request failed: " .. response.StatusCode
		}
	end
end


return {
	setupAPI = setupAPI,
	createOrder = createOrder,
	setWaiting = setWaiting,
	setPreparing = setPreparing,
	setReprepare = setReprepare,
	setReadyForPickup = setReadyForPickup,
	setComplete = setComplete,
	setCancelled = setCancelled,
}
