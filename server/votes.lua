RegisterNetEvent('ev:getVotingId', function(id)
    local source <const> = source
    local identifier = getIdentifier(source, 'license')
    MySQL.Async.fetchScalar('SELECT 1 FROM ev_voting WHERE license = @license', {
        ['license'] = identifier
    }, function(hasVoted)
        if not hasVoted then
            MySQL.Async.execute('INSERT INTO ev_voting (license, choice) VALUES (@identifier, @choice)', {
                ['identifier'] = identifier,
                ['choice'] = id
            })
            return TriggerClientEvent('ev:showNotification', source, 'You have voted for ' .. id)
        else
            return TriggerClientEvent('ev:showNotification', source, 'You already casted your vote')
        end
    end)
end)

---Returns the candidate votes
---@param playerId number
---@param candidate string
local function getCounts(playerId, candidate)
    MySQL.Async.fetchScalar('SELECT COUNT(1) FROM ev_voting WHERE choice = @choice', {
        ['choice'] = candidate
    }, function(result)
        if result then
            return TriggerClientEvent('ev:showNotification', playerId, 'Candidate ' .. candidate .. ' has a total amount of ' .. tostring(result) .. ' votes!')
        else
            return TriggerClientEvent('ev:showNotification', playerId, 'Candidate does not exist')
        end
    end)
end

RegisterCommand('getCounts', function(source, args)
    local source <const> = source
    if source > 0 then
        if args[1] then
            getCounts(source, args[1])
        else
            return TriggerClientEvent('ev:showNotification', source, 'You need to include the candidate name')
        end
    end
end, true) -- Admins only but can be implemented into a framework

function getIdentifier(playerId, type)
    local function match(total, identifier)
        return string.match(total, identifier)
    end
    for _, v in pairs(GetPlayerIdentifiers(playerId)) do
        if match(v, type) then
            return v
        end
    end
    return 'Unknown'
end