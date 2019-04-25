json = require 'lua/requirements/json';

FUT_URLS = {
    card_bg = 'https://www.easports.com/fifa/ultimate-team/web-app/content/7D49A6B1-760B-4491-B10C-167FBC81D58A/2019/fut/items/images/backgrounds/itemCompanionBGs/large/cards_bg_e_1_',
    display = 'https://www.easports.com/fifa/ultimate-team/api/fut/display',
    player_search = 'https://www.easports.com/fifa/ultimate-team/api/fut/item?jsonParamObject='
}

function encodeURI(str)
    if (str) then
        str = string.gsub (str, "\n", "\r\n")
        str = string.gsub (str, "([^%w ])",
            function (c) return string.format ("%%%02X", string.byte(c)) end)
        str = string.gsub (str, " ", "+")
   end
   return str
end

function fut_get_rarity_display()
    local r = getInternet()
    request = FUT_URLS['display']
    response = json.decode(
        r.getURL(request)
    )
    r.destroy()

    return response
end

function fut_find_player(player_data)
    -- print(fut_find_player('ronaldo')['items'][1]['age'])
    if string.match(player_data, '[0-9]') then
        -- TODO player name from playerid
    end
    request = FUT_URLS['player_search'] .. encodeURI(string.format(
        '{"name":"%s"}',
        player_data
    ))

    local r = getInternet()
    response = json.decode(
        r.getURL(request)
    )
    r.destroy()

    return response
end
